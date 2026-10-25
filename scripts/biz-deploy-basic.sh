#!/usr/bin/env bash
# biz-deploy-basic.sh — Thin-client bootstrap of Business OS into a target project.
#
# Copies ONLY the minimal scaffold into the target:
#   - .cursorrules (from templates/cursorrules.template, with AI_BIZ_SOURCE
#     token substituted to the absolute path of THIS source framework root, and
#     Change-safety gate-table script paths baked to the same absolute root)
#   - .work.biz/ skeleton (HANDOFF, NEXT, UNKNOWNS, pipeline, research)
#
# Framework assets (skills/, standards/, concepts/, docs/, scripts/, templates/)
# are NOT copied — the target's .cursorrules carries an AI_BIZ_SOURCE pointer so
# the agent resolves them from the source framework root at runtime (thin-client mode).
#
# Default = NO-OVERWRITE: existing target files are preserved by construction.
# --update: no-overwrite + re-syncs the source pointer + re-bakes script paths
# (via biz-cursorrules-verify.sh --fix) + lists existing-but-differing
# local-surface files (.cursorrules, .work.biz/* template outputs) as merge
# candidates for agent rules-aware merge.
# --force: idempotent overwrite of the local scaffold surface only.
#
# Source resolution: BIZ_ROOT is derived from this script's location, so the
# script can be invoked from a TARGET using an external source framework root:
#   bash /mnt/work/Projects/pilo.ai.biz.logicbison/scripts/biz-deploy-basic.sh /mnt/work/Projects/tools-project
# Override the source with BIZ_SOURCE=/abs/path/to/source-root if needed.
#
# Usage:
#   bash scripts/biz-deploy-basic.sh <target-path>              # no-overwrite (write .cursorrules when absent,
#                                                               #  otherwise append the managed Business OS block)
#   bash scripts/biz-deploy-basic.sh [status] [target-path]     # read-only report (+ verify)
#   bash scripts/biz-deploy-basic.sh <target-path> [--update]   # no-overwrite + block refresh + repair + merge candidates
#   bash scripts/biz-deploy-basic.sh <target-path> [--no-merge] # never touch an existing .cursorrules
#   bash scripts/biz-deploy-basic.sh <target-path> [--force confirm-overwrite-cursorrules]
#                                                           # overwrite scaffold (explicit opt-in; blocked without the token)
#   BIZ_SOURCE=/path/to/source-root bash scripts/biz-deploy-basic.sh <target-path>
#
# Argument forms are equivalent: verbs accept the '--' prefix or bare form
# (`update` ≡ `--update`, `status` ≡ `--status`), '-' / '--' separators are
# ignored, and the target path may appear in any position:
#   biz-deploy-basic.sh /path update   ≡   biz-deploy-basic.sh /path --update
#
# .cursorrules in a target that already runs another OS framework: the file is
# never replaced. Business OS owns only the region between
# `<!-- BIZ_DESIGN_OS_BEGIN -->` and `<!-- BIZ_DESIGN_OS_END -->`, which this
# script appends once and refreshes in place afterwards
# (scripts/biz-cursorrules-merge.sh). Everything outside the markers is another
# framework's rules and is left byte-for-byte intact.
#
set -euo pipefail

# ── Argument normalization ─────────────────────────────────────────────
# Verbs with or without '--', in any position relative to the target path;
# '-' and '--' (skill parse-table separators) are ignored — a '-' must never
# become the target directory.
MODE=""
RAW_TARGET=""
CONFIRM_OVERWRITE=0
NO_MERGE=0
for arg in "$@"; do
  [[ "$arg" == "-" || "$arg" == "--" ]] && continue
  tok="${arg#--}"
  case "$tok" in
    status|update|force|skip) MODE="$tok" ;;
    merge|merge-block) MODE="merge" ;;
    no-merge) NO_MERGE=1 ;;
    confirm-overwrite-cursorrules) CONFIRM_OVERWRITE=1 ;;
    /*|./*|../*|~*|*/*|.)
      if [[ -z "$RAW_TARGET" ]]; then RAW_TARGET="$arg"
      else echo "ERROR: multiple target paths: '$RAW_TARGET' and '$arg'" >&2; exit 2; fi ;;
    *) echo "ERROR: unknown argument: $arg" >&2
       echo "Usage: $0 [status] <target-path> [--force confirm-overwrite-cursorrules|--update|--no-merge] (path must contain '/'; use ./name for local dirs)" >&2
       exit 2 ;;
  esac
done
# Default mode wires an existing .cursorrules by appending the managed block.
# `skip` is retained as the explicit spelling of the old no-touch behaviour.
[[ "$NO_MERGE" -eq 1 && -z "$MODE" ]] && MODE="skip"
MODE="${MODE:-merge}"
if [[ -z "$RAW_TARGET" ]]; then
  if [[ "$MODE" == "status" ]]; then
    RAW_TARGET="."
  else
    echo "Usage: $0 [status] <target-path> [--force|--update|--no-merge]" >&2
    exit 2
  fi
fi

# Source Business OS root: explicit override wins, else derive from script location.
# pwd -P canonicalises the path so a source reachable under two names (a real
# directory plus a legacy `.ai.biz` symlink) always bakes ONE pointer into
# targets, and that pointer is the directory the framework actually lives in.
if [[ -n "${BIZ_SOURCE:-}" ]]; then
  BIZ_ROOT="$(cd "$BIZ_SOURCE" && pwd -P)"
else
  BIZ_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
fi
MERGE_SH="${BIZ_ROOT}/scripts/biz-cursorrules-merge.sh"

# ── Status mode (read-only) ───────────────────────────────────────────
if [[ "$MODE" == "status" ]]; then
  if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
    DEST_ROOT="$(pwd -P)"
  else
    DEST_ROOT="$(cd "$RAW_TARGET" && pwd -P)"
  fi
  CURS_DEST="${DEST_ROOT}/.cursorrules"
  status_rc=0
  echo "=== biz-deploy-basic status → $DEST_ROOT ==="
  # .cursorrules checks are delegated to the shared verifier (single source of
  # truth: AI_BIZ_SOURCE, gate-table script-path baking, source-resolution,
  # .work.biz skeleton, REPLACE token count).
  if [[ -f "$CURS_DEST" ]]; then
    BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" "$DEST_ROOT" || status_rc=$?
  else
    echo "  .cursorrules: MISSING"
    status_rc=1
  fi
  if [[ -f "$CURS_DEST" ]]; then
    echo "  .cursorrules block: $(bash "$MERGE_SH" "$DEST_ROOT" --state 2>/dev/null || echo unknown) (managed region: BIZ_DESIGN_OS_BEGIN/END)"
  fi
  [[ -d "${DEST_ROOT}/.work.biz/context" ]] && echo "  .work.biz/: present" || echo "  .work.biz/: missing"
  [[ -d "${DEST_ROOT}/.ai.biz/skills" ]] && echo "  local .ai.biz/skills/: present (WARN — fat-client leak)" || echo "  local .ai.biz/skills/: absent (thin-client ok)"
  exit "$status_rc"
fi

# Target = repo root of the consumer (the dir that will hold .cursorrules + .work.biz/).
if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
  DEST_ROOT="$(pwd -P)"
else
  DEST_ROOT="$(cd "$RAW_TARGET" && pwd -P)"
fi

if [[ ! -d "$DEST_ROOT" ]]; then
  echo "ERROR: target directory does not exist: $DEST_ROOT" >&2
  exit 1
fi

# Validate source has required templates and skills.
TPL_CURS="${BIZ_ROOT}/templates/cursorrules.template"
if [[ ! -f "$TPL_CURS" ]]; then
  echo "ERROR: source framework missing templates/cursorrules.template at $BIZ_ROOT" >&2
  exit 1
fi
if [[ ! -d "${BIZ_ROOT}/skills" ]]; then
  echo "ERROR: source framework missing skills/ directory at $BIZ_ROOT" >&2
  exit 1
fi

# Scaffold file set (the thin-client local surface for Business OS).
CURS_DEST="${DEST_ROOT}/.cursorrules"
# Must stay in sync with templates/bootstrap.sh and skills/biz-bootstrap/skill.md § I1.
# The `--update` merge scan only considers files listed here, so anything missing is
# silently never offered for update on an existing thin-client install.
WORK_FILES=(
  "README.md" "context/HANDOFF.md" "plans/NEXT.md" "plans/UNKNOWNS.md"
  "pipeline/pipeline_tracker.md" "pipeline/outreach-cadence.md"
  "research/research_index.md" "strategy/README.md" "gates.md"
  "decisions/DECISIONS.md"
  "reference/CONTENT_STATUS.md" "reference/BRAND_STATUS.md"
  "reference/VOICE_PROFILE.md" "reference/VOICE_RETRO.md"
  "reference/OPERATOR_PROFILE.md" "reference/PROJECTS.md"
)
# Must match the dir loop in templates/bootstrap.sh (framework-verify checks this).
WORK_DIRS=(
  "context" "plans" "pipeline" "research" "drafts" "strategy" "reference"
  "ideas" "ideas.archive" "decisions"
)

echo "=== biz-deploy-basic (Business OS) → $DEST_ROOT (thin-client bootstrap) ==="
echo "  source: $BIZ_ROOT"
case "$MODE" in
  merge)  echo "  mode:   merge (no-overwrite; write the file when absent, otherwise append only the managed block)" ;;
  update) echo "  mode:   update (no-overwrite; refresh the managed block + repair pointer/paths in place)" ;;
  skip)   echo "  mode:   skip (no-overwrite; an existing .cursorrules is never touched)" ;;
  force)  echo "  mode:   force (overwrites the scaffold; requires confirm-overwrite-cursorrules when .cursorrules exists)" ;;
  *)      echo "  mode:   $MODE" ;;
esac

if [[ -d "${DEST_ROOT}/.ai.biz/skills" ]]; then
  echo "  WARN: target has local .ai.biz/skills/ directory (fat-client leak)"
  if [[ "$MODE" != "force" ]]; then
    echo "  BLOCKED: use --force to confirm thin-client on a fat-client target,"
    echo "    or remove the local .ai.biz/ directory first."
    exit 1
  fi
  echo "  --force: proceeding (mixed state accepted by operator)"
fi

# Build the substituted .cursorrules content.
# Substitutes:
#   1. AI_BIZ_SOURCE=REPLACE_BASICSOURCE → absolute BIZ_ROOT
#   2. `bash scripts/<name>` → `bash <BIZ_ROOT>/scripts/<name>` (Change-safety
#      gate table + git-hooks install line). These commands live inside
#      .cursorrules itself, not inside a skill doc, so the general "any
#      .ai.biz/<x> inside a skill resolves to $AI_BIZ_SOURCE/<x>" rule
#      doesn't unambiguously cover them — bake the resolved absolute path here
#      instead of relying on read-time interpretation.
subst_cursorules() {
  local BIZ_ROOT_ESC="${BIZ_ROOT//\//\\/}"
  local SIBLING_PARENT tmpfile
  SIBLING_PARENT="$(cd "$BIZ_ROOT/.." && pwd)"
  tmpfile="$(mktemp)"

  # Step 1: substitute AI_BIZ_SOURCE
  perl -pe "s/AI_BIZ_SOURCE=REPLACE_BASICSOURCE/AI_BIZ_SOURCE=${BIZ_ROOT_ESC}/" "$TPL_CURS" > "$tmpfile"

  # Step 2: discover and fill sister framework paths at deploy time (Frameworks
  # registry in the target .cursorrules). Sister dir names follow legacy
  # `.ai.<fw>` or family naming — see scripts/sister-discovery.sh. If a sister
  # exists on disk, bake its absolute path into the REPLACE:AI_*_PATH cell; if
  # absent, leave the token and say what was checked + how to adjust (manual
  # cell fill; runtime auto-discover reports degraded routing).
  if [[ -f "${BIZ_ROOT}/scripts/sister-discovery.sh" ]]; then
    # shellcheck source=/dev/null
    source "${BIZ_ROOT}/scripts/sister-discovery.sh"
    local fw
    for fw in $FRAMEWORK_SLOTS; do
      [[ "$fw" == "biz" ]] && continue   # self — registry row is "*this directory*", never a token
      local token_upper token fw_dir_abs fw_esc checked
      token_upper="$(echo "$fw" | tr '[:lower:]' '[:upper:]')"
      token="REPLACE:AI_${token_upper}_PATH"
      fw_dir_abs="$(find_sister_dir "$BIZ_ROOT" "$fw" "$SIBLING_PARENT" || true)"
      if [[ -n "$fw_dir_abs" ]]; then
        fw_esc="${fw_dir_abs//\//\\/}"
        perl -i -pe "s{${token} \\(default:? \\\`[^)]*\\)}{${fw_esc} (discovered at deploy time)}" "$tmpfile"
        if grep -q "$token" "$tmpfile"; then
          echo "  frameworks: WARN ${token} cell did not match expected template shape — left for runtime auto-discover" >&2
        else
          echo "  frameworks: resolved ${token} → ${fw_dir_abs}" >&2
        fi
      else
        checked="$(sister_names "$fw" "$BIZ_ROOT" | paste -sd' ' -)"
        echo "  frameworks: ${token} not found (checked ${checked} in $SIBLING_PARENT) —" >&2
        echo "    if the sister exists under another dir name, fill ${token} manually in" >&2
        echo "    the target .cursorrules; naming: legacy .ai.<fw> or family naming" >&2
        echo "    (see scripts/sister-discovery.sh)." >&2
      fi
    done

    # Agent OS root (registry `.ai` row — the "big brother" orchestrator, not a
    # framework slot): fill REPLACE:AI_PATH from the family-named root or
    # legacy `../.ai`. If neither exists, leave the token and say so — the
    # operator must set the correct path, never a guess.
    local ai_dir ai_esc
    ai_dir="$(find_agent_os_dir "$BIZ_ROOT" "$SIBLING_PARENT" || true)"
    if [[ -n "$ai_dir" ]]; then
      ai_esc="${ai_dir//\//\\/}"
      perl -i -pe "s{REPLACE:AI_PATH \\(default:? \\\`[^)]*\\)}{${ai_esc} (discovered at deploy time)}" "$tmpfile"
      if grep -q 'REPLACE:AI_PATH' "$tmpfile"; then
        echo "  frameworks: WARN REPLACE:AI_PATH cell did not match expected template shape — left for runtime auto-discover" >&2
      else
        echo "  frameworks: resolved REPLACE:AI_PATH → ${ai_dir}" >&2
      fi
    else
      echo "  frameworks: REPLACE:AI_PATH not found (checked $(agent_os_names "$BIZ_ROOT" | paste -sd' ' -) in $SIBLING_PARENT) —" >&2
      echo "    ask the operator for the Agent OS root path and fill REPLACE:AI_PATH" >&2
      echo "    manually in the target .cursorrules. Never guess this cell." >&2
    fi
  fi

  # Step 2b: the registry's self row. The template carries "*this directory*"
  # because that is correct for the self-hosted source and for fat-client
  # installs; a thin-client target holds no framework files, so the row must
  # name the source root or it misroutes business work into the consumer repo.
  perl -i -pe "s{^\| \`\.ai\.biz\` \(Business OS\) \| \`\@biz-director\` \| \*this directory\* \|}{| \`.ai.biz\` (Business OS) | \`\@biz-director\` | ${BIZ_ROOT_ESC} (source root) |}" "$tmpfile"
  if grep -q '\*this directory\*' "$tmpfile"; then
    echo "  frameworks: WARN self row (.ai.biz) is still '*this directory*' — template row shape changed; check templates/cursorrules.template" >&2
  fi

  # Step 3: bake resolved script paths (Change-safety gate table + hook install)
  perl -i -pe "s{bash (?<!/)scripts/}{bash ${BIZ_ROOT_ESC}/scripts/}g" "$tmpfile"

  cat "$tmpfile"
  rm -f "$tmpfile"
}

WROTE_TEMPLATE=0
write_cursorules() {
  if [[ "$1" == "force" ]] || [[ ! -f "$CURS_DEST" ]]; then
    subst_cursorules > "$CURS_DEST"
    WROTE_TEMPLATE=1
    echo "  cursorrules: wrote (subst AI_BIZ_SOURCE=$BIZ_ROOT)"
  else
    echo "  cursorrules: skip (exists) — keeping existing target .cursorrules"
  fi
}

# Pre-scan: detect whether target already has a thin-client pointer set, so the
# report can flag a stale source path (e.g. source moved) for --update.
# Canonical name is AI_BIZ_SOURCE; a legacy AGENT_OS_SOURCE line counts only
# when it resolves to a Business OS root (foreign Agent OS pointer is not ours).
existing_source=""
if [[ -f "$CURS_DEST" ]]; then
  existing_source="$(grep -E '^AI_BIZ_SOURCE=' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || true)"
  if [[ -z "$existing_source" ]]; then
    existing_source="$(grep -oE 'AI_BIZ_SOURCE=[^[:space:]`]+' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || true)"
  fi
  if [[ -z "$existing_source" ]]; then
    legacy_source="$(grep -E '^AGENT_OS_SOURCE=' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || true)"
    if [[ -z "$legacy_source" ]]; then
      legacy_source="$(grep -oE 'AGENT_OS_SOURCE=[^[:space:]`]+' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || true)"
    fi
    if [[ -n "$legacy_source" && "$legacy_source" != "REPLACE_BASICSOURCE" && -f "${legacy_source}/skills/biz-deploy-basic/skill.md" ]]; then
      existing_source="$legacy_source"
    fi
  fi
fi

# Step 1: .cursorrules — four shapes, one rule: never destroy another
# framework's rules.
#   absent / none       → write the full thin-client template
#   managed block       → skip (default) or refresh in place (--update)
#   legacy (no markers) → leave alone; report the migration candidate
#   unterminated        → refuse to touch the file
# --force still replaces wholesale, and only after the operator names
# `confirm-overwrite-cursorrules` (a replace destroys every sister framework's
# block in the file — same guard as Agent OS / UI Design OS).
curs_state="none"
[[ -f "$CURS_DEST" ]] && curs_state="$(bash "$MERGE_SH" "$DEST_ROOT" --state 2>/dev/null || echo unknown)"
state_before="$curs_state"
echo "  cursorrules: state=${curs_state}"

if [[ "$MODE" == "force" ]]; then
  if [[ -f "$CURS_DEST" && "$CONFIRM_OVERWRITE" -ne 1 ]]; then
    lost="$(grep -oE '(BIZ_DESIGN_OS_BEGIN|SOC_DESIGN_OS_BEGIN|UI_DESIGN_OS_BEGIN|FLUTTER_AGENT_OS_BEGIN|MLT_DESIGN_OS_BEGIN|Core Principles|Source resolution)' "$CURS_DEST" 2>/dev/null | sort -u | paste -sd, - | sed 's/,/, /g' || true)"
    echo "  BLOCKED: --force would replace .cursorrules wholesale ($(wc -l < "$CURS_DEST") lines)"
    [[ -n "$lost" ]] && echo "    content that would be LOST: ${lost}"
    echo "    to proceed, name the confirmation token explicitly:"
    echo "      bash ${BIZ_ROOT}/scripts/biz-deploy-basic.sh ${DEST_ROOT} --force confirm-overwrite-cursorrules"
    echo "    otherwise use --update (in-place refresh) — the normal, non-destructive path."
    exit 1
  fi
  write_cursorules force
else
  case "$curs_state" in
    none|absent)
      if [[ "$NO_MERGE" -eq 1 || "$MODE" == "skip" ]]; then
        [[ "$NO_MERGE" -eq 1 ]] && why="--no-merge" || why="skip verb"
        echo "  cursorrules: skip (${why}) — .cursorrules untouched"
      elif [[ -f "$CURS_DEST" ]]; then
        # A foreign framework's file: append the managed block, change nothing else.
        if ! mout="$(bash "$MERGE_SH" "$DEST_ROOT" --layout thin 2>&1)"; then
          printf '%s\n' "$mout" | sed 's/^/  /'
          echo "  BLOCKED: could not write ${CURS_DEST} — the target is unwritable (permissions, read-only mount, or sandbox)." >&2
          echo "    Nothing else was written. Re-run with write access to the target." >&2
          exit 1
        fi
        printf '%s\n' "$mout" | sed 's/^/  /'
      else
        write_cursorules skip
      fi
      ;;
    present)
      if [[ "$MODE" == "update" ]]; then
        if ! mout="$(bash "$MERGE_SH" "$DEST_ROOT" --refresh --layout thin 2>&1)"; then
          printf '%s\n' "$mout" | sed 's/^/  /'
          echo "  BLOCKED: could not refresh ${CURS_DEST} — the target is unwritable." >&2
          exit 1
        fi
        printf '%s\n' "$mout" | sed 's/^/  /'
      else
        echo "  cursorrules: managed block already present — left as is (--update refreshes it)"
      fi
      ;;
    legacy)
      echo "  cursorrules: Business OS already wired without managed markers — left as is"
      echo "    (hand merge or standalone file; --update repairs the pointer and script paths in place)"
      ;;
    unterminated)
      echo "  BLOCKED: unmatched Business OS marker in ${CURS_DEST}" >&2
      grep -nxF -e '<!-- BIZ_DESIGN_OS_BEGIN -->' -e '<!-- BIZ_DESIGN_OS_END -->' "$CURS_DEST" | sed 's/^/    /' >&2 || true
      echo "    repair the marker pair (or restore from git), then re-run." >&2
      exit 1
      ;;
    *)
      echo "  cursorrules: state unknown — leaving .cursorrules untouched" ;;
  esac
fi

# Step 2: .work.biz/ skeleton via bootstrap.sh (no-overwrite).
BOOTSTRAP_SKIP_CURSERRULES=1 REPO_ROOT="$DEST_ROOT" BIZ_SOURCE="$BIZ_ROOT" \
  bash "$BIZ_ROOT/templates/bootstrap.sh" \
  > /tmp/biz-deploy-basic-scaffold.$$.log 2>&1 || { cat /tmp/biz-deploy-basic-scaffold.$$.log; rm -f /tmp/biz-deploy-basic-scaffold.$$.log; exit 1; }
grep -E '(created:|skip )' /tmp/biz-deploy-basic-scaffold.$$.log | sed 's/^/  work: /' || true
rm -f /tmp/biz-deploy-basic-scaffold.$$.log

# Re-read the state now that this run may have written or refreshed the block.
[[ -f "$CURS_DEST" ]] && curs_state="$(bash "$MERGE_SH" "$DEST_ROOT" --state 2>/dev/null || echo unknown)"

# --update: re-sync the source pointer and re-bake gate-table script paths.
# Single source of truth: biz-cursorrules-verify.sh --fix — idempotent,
# in-place, preserves all other target edits and tokens, migrates a legacy
# AGENT_OS_SOURCE biz pointer to AI_BIZ_SOURCE, and refuses to rewrite a
# foreign framework's pointer (mixed Agent OS + Business OS repos).
if [[ "$MODE" == "update" ]] && [[ -f "$CURS_DEST" ]] && grep -qE 'AI_BIZ_SOURCE=|AGENT_OS_SOURCE=|BIZ_DESIGN_OS_BEGIN' "$CURS_DEST"; then
  fix_rc=0
  BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" --fix --thin "$DEST_ROOT" || fix_rc=$?
  if [[ "$fix_rc" -ne 0 ]]; then
    echo "  cursorrules: verifier exited ${fix_rc} during --fix — review the [FAIL] lines above"
    echo "    (findings that are not mechanical pointer/path repairs need the agent merge below)"
  fi
fi
# If --update AND existing .cursorrules came from a fat-client template (neither
# an AI_BIZ_SOURCE nor a legacy AGENT_OS_SOURCE line at all), flag it — the
# source-resolution section is a merge candidate, handled by the agent (see
# skill § update-merge protocol).
if [[ "$MODE" == "update" ]] && [[ -f "$CURS_DEST" ]] && ! grep -qE 'AI_BIZ_SOURCE=|AGENT_OS_SOURCE=|BIZ_DESIGN_OS_BEGIN' "$CURS_DEST"; then
  echo "  cursorrules: MERGE CANDIDATE — existing .cursorrules lacks the Business OS block"
  echo "    (run without --no-merge to append the managed block; target content is preserved)"
fi

# Step 3: --update — list existing-but-differing files as merge candidates.
if [[ "$MODE" == "update" ]]; then
  echo ""
  echo "=== update merge candidates ==="
  # .cursorrules: a managed block is refreshed mechanically above, so only the
  # standalone / hand-merged shapes need an agent diff against the template.
  if [[ -f "$CURS_DEST" ]]; then
    case "$curs_state" in
      present)
        if [[ "$state_before" == "absent" || "$state_before" == "none" ]]; then
          echo "  .cursorrules: managed block appended this run — no agent merge needed"
        elif [[ "$MODE" == "update" ]]; then
          echo "  .cursorrules: managed block refreshed this run — no agent merge needed"
        else
          echo "  .cursorrules: managed block present — left as is, no agent merge needed"
        fi ;;
      none)
        echo "  .cursorrules: full template written by this run" ;;
      *)
        tmp_cur="$(mktemp)"
        subst_cursorules > "$tmp_cur"
        if ! cmp -s "$tmp_cur" "$CURS_DEST"; then
          echo "  merge: .cursorrules  (standalone/hand-merged; differs from current template-with-source)"
        fi
        rm -f "$tmp_cur" ;;
    esac
  fi
  # .work.biz/ skeleton files vs source templates
  TPL_WORK="${BIZ_ROOT}/templates/work"
  for f in "${WORK_FILES[@]}"; do
    src="${TPL_WORK}/${f}.template"
    dest="${DEST_ROOT}/.work.biz/${f}"
    [[ -f "$src" && -f "$dest" ]] || continue
    if ! cmp -s "$src" "$dest"; then
      echo "  merge: .work.biz/${f}  (target has user content — agent appends new template sections only; preserves user edits)"
    fi
  done
  echo "  (agent performs rules-aware merge — append new sections, preserve target"
  echo "   customizations + REPLACE tokens + AI_BIZ_SOURCE. See skill biz-deploy-basic § update-merge.)"
fi

echo ""
echo "=== Done: thin-client bootstrap (Business OS) → $DEST_ROOT ==="
echo "  .cursorrules: $([ -f "$CURS_DEST" ] && echo present || echo MISSING)"
src_pointer="$(grep -oE 'AI_BIZ_SOURCE=[^[:space:]`]*' "$CURS_DEST" 2>/dev/null | head -1 || true)"
if [[ -z "$src_pointer" ]]; then
  src_pointer="$(grep -oE 'AGENT_OS_SOURCE=[^[:space:]`]*' "$CURS_DEST" 2>/dev/null | head -1 || true)"
fi
echo "  source pointer: ${src_pointer:-<unset — fat-client>}"
echo "  .work.biz/: $([ -d "${DEST_ROOT}/.work.biz" ] && echo present || echo MISSING)"
echo "  skills (local): $([ -d "${DEST_ROOT}/.ai.biz/skills" ] && echo "present — fat-client (unexpected for basic)" || echo 'absent — thin-client (skills load from source)')"
echo ""
echo "Next steps in target project:"
if [[ "$WROTE_TEMPLATE" -eq 1 ]]; then
  echo "  1. Edit ${DEST_ROOT}/.cursorrules — fill every REPLACE: token EXCEPT AI_BIZ_SOURCE (biz-deploy-basic set it)"
elif [[ "$curs_state" == "present" || "$curs_state" == "legacy" ]]; then
  echo "  1. ${CURS_DEST} — Business OS wiring is in place; no REPLACE: tokens to fill"
else
  echo "  1. ${CURS_DEST} — left untouched (skip); Business OS is NOT wired until the block is merged: re-run without --no-merge/skip"
fi
echo "  2. Verify source is reachable:  test -d \"\$(grep -oE 'AI_BIZ_SOURCE=[^ ]*' $CURS_DEST | cut -d= -f2-)\""
echo "  3. Run @biz-session start  (skill loads from \$AI_BIZ_SOURCE/skills/biz-session/skill.md)"
echo "  4. For project-tracking context: @biz-session context"

# ── Post-deploy verification: every deploy proves the target .cursorrules ──
# update already repaired via --fix above; skip/force verifies read-only
# (repair is update's job — no-overwrite mode must not edit an existing file).
echo ""
echo "=== post-deploy verification ==="
final_rc=0
BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" "$DEST_ROOT" || final_rc=$?
if [[ "$final_rc" -ne 0 ]]; then
  if [[ "$MODE" == "update" ]]; then
    echo "  update could not auto-repair all findings — review [FAIL] lines above"
    exit "$final_rc"
  fi
  echo "  (findings are pre-existing; run @biz-deploy-basic update to repair)"
fi
