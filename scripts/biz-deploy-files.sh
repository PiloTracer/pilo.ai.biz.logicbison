#!/usr/bin/env bash
# biz-deploy-files.sh — Deploy .ai.biz (Business OS) files into a target project
#
# Default = NO-OVERWRITE. Use --force for legacy overwrite, or --update for merge
# candidates when source files differ from target copies.
#
# Usage:
#   bash scripts/biz-deploy-files.sh <target-path>              # no-overwrite
#   bash scripts/biz-deploy-files.sh [status] [target-path]     # read-only report (+ verify)
#   bash scripts/biz-deploy-files.sh <target-path> --force      # overwrite existing
#   bash scripts/biz-deploy-files.sh <target-path> --update     # no-overwrite + merge list
#   BIZ_SOURCE=/path/to/source-root bash scripts/biz-deploy-files.sh <target-path>
#
# Argument forms are equivalent: verbs accept the '--' prefix or bare form
# (`update` ≡ `--update`, `status` ≡ `--status`), '-' / '--' separators are
# ignored, and the target path may appear in any position:
#   biz-deploy-files.sh /path update   ≡   biz-deploy-files.sh /path --update
#
set -euo pipefail

# ── Argument normalization ─────────────────────────────────────────────
# Verbs with or without '--', in any position relative to the target path;
# '-' and '--' (skill parse-table separators) are ignored — a '-' must never
# become the target directory.
MODE=""
RAW_TARGET=""
for arg in "$@"; do
  [[ "$arg" == "-" || "$arg" == "--" ]] && continue
  tok="${arg#--}"
  case "$tok" in
    copy|skip) : ;;   # explicit copy verb = default copy mode
    update|force|status) MODE="$tok" ;;
    /*|./*|../*|~*|*/*|.)
      if [[ -z "$RAW_TARGET" ]]; then RAW_TARGET="$arg"
      else echo "ERROR: multiple target paths: '$RAW_TARGET' and '$arg'" >&2; exit 2; fi ;;
    *) echo "ERROR: unknown argument: $arg" >&2
       echo "Usage: $0 [status] [copy] [-] <target-path> [--force|--update] (path must contain '/'; use ./name for local dirs)" >&2
       exit 2 ;;
  esac
done
MODE="${MODE:-skip}"
if [[ -z "$RAW_TARGET" ]]; then
  if [[ "$MODE" == "status" ]]; then
    RAW_TARGET="."
  else
    echo "Usage: $0 [status] [copy] [-] <target-path> [--force|--update]" >&2
    exit 2
  fi
fi

if [[ -n "${BIZ_SOURCE:-}" ]]; then
  BIZ_ROOT="$(cd "$BIZ_SOURCE" && pwd)"
else
  BIZ_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

# ── Status mode (read-only) ───────────────────────────────────────────
if [[ "$MODE" == "status" ]]; then
  if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
    DEST_ROOT="$(pwd)"
  else
    DEST_ROOT="$(cd "$RAW_TARGET" && pwd)"
  fi
  echo "=== biz-deploy-files status → $DEST_ROOT ==="
  if [[ -d "${DEST_ROOT}/.ai.biz/skills" ]]; then
    skill_n="$(find "${DEST_ROOT}/.ai.biz/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
    echo "  .ai.biz/skills: present ($skill_n skill dirs — fat-client)"
  else
    echo "  .ai.biz/skills: missing (no fat-client copy at this target)"
  fi
  status_rc=0
  if [[ -f "${DEST_ROOT}/.cursorrules" ]]; then
    BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" "$DEST_ROOT" || status_rc=$?
  else
    echo "  .cursorrules: absent (nothing to verify — run @biz-bootstrap init there)"
  fi
  exit "$status_rc"
fi

if [[ "$RAW_TARGET" == *.ai.biz ]]; then
  DEST_DIR="$RAW_TARGET"
else
  DEST_DIR="${RAW_TARGET}/.ai.biz"
fi

PARENT="$(dirname "$DEST_DIR")"
if [[ ! -d "$PARENT" ]]; then
  echo "ERROR: parent directory does not exist: $PARENT" >&2
  exit 1
fi

if [[ -e "$DEST_DIR" ]] && [[ ! -d "$DEST_DIR" ]]; then
  echo "ERROR: $DEST_DIR exists but is not a directory" >&2
  exit 1
fi

if ! (cd "$BIZ_ROOT" && git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
  echo "ERROR: source $BIZ_ROOT is not a git repo." >&2
  exit 1
fi

GIT_TOP="$(cd "$BIZ_ROOT" && git rev-parse --show-toplevel)"
if [[ "$GIT_TOP" != "$BIZ_ROOT" ]]; then
  echo "ERROR: $BIZ_ROOT is not the git repo root (root is $GIT_TOP)." >&2
  exit 1
fi

echo "=== biz-deploy-files → $DEST_DIR ==="
echo "  source: $BIZ_ROOT"
echo "  mode:   $MODE (no-overwrite by default)"

SKILL_EXCLUDE_REGEX='^(\.github/|\.gitignore$|\.gitattributes$|\.cursorrules$|scripts/biz-deploy-files\.sh$|scripts/biz-deploy-basic\.sh$|scripts/biz-cursorrules-verify\.sh$)'

TMP_LIST="$(mktemp)"
MERGE_CANDS="$(mktemp)"
trap 'rm -f "$TMP_LIST" "$MERGE_CANDS"' EXIT

( cd "$BIZ_ROOT" \
  && git ls-files --cached --others --exclude-standard \
  | grep -vE "$SKILL_EXCLUDE_REGEX" \
) > "$TMP_LIST"

COUNT="$(wc -l < "$TMP_LIST" | tr -d ' ')"
mkdir -p "$DEST_DIR"

SKIPPED=0
if [[ "$MODE" != "force" ]]; then
  while IFS= read -r rel; do
    [[ -z "$rel" ]] && continue
    if [[ -f "$DEST_DIR/$rel" ]]; then
      SKIPPED=$((SKIPPED+1))
      if [[ "$MODE" == "update" ]] && ! cmp -s "$BIZ_ROOT/$rel" "$DEST_DIR/$rel"; then
        echo "$rel" >> "$MERGE_CANDS"
      fi
    fi
  done < "$TMP_LIST"
fi

if [[ "$MODE" == "force" ]]; then
  rsync -a --files-from="$TMP_LIST" "$BIZ_ROOT"/ "$DEST_DIR"/
else
  rsync -a --ignore-existing --files-from="$TMP_LIST" "$BIZ_ROOT"/ "$DEST_DIR"/
fi

COPIED=$((COUNT - SKIPPED))
echo "  copied: $COPIED files (git-ignored content excluded by policy)"
echo "  skipped (exists): $SKIPPED files"

if [[ "$MODE" == "update" ]] && [[ -s "$MERGE_CANDS" ]]; then
  MERGE_N="$(wc -l < "$MERGE_CANDS" | tr -d ' ')"
  echo ""
  echo "=== update merge candidates ($MERGE_N existing-but-differing files) ==="
  while IFS= read -r rel; do
    echo "  merge: $rel"
  done < "$MERGE_CANDS"
fi

if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
  REPO_ROOT="$(cd "$PARENT" && pwd)"
  REPO_ROOT="$REPO_ROOT" BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/templates/bootstrap.sh" \
    > /tmp/biz-deploy-files-scaffold.$$.log 2>&1 || { cat /tmp/biz-deploy-files-scaffold.$$.log; rm -f /tmp/biz-deploy-files-scaffold.$$.log; exit 1; }
  grep -E '(created:|skip )' /tmp/biz-deploy-files-scaffold.$$.log | sed 's/^/  scaffold: /' || true
  rm -f /tmp/biz-deploy-files-scaffold.$$.log
  SCAFFOLD_DONE=1
fi

echo ""
echo "=== Done: files deployed to $DEST_DIR ==="
if [[ -n "${SCAFFOLD_DONE:-}" ]]; then
  echo "  Scaffold created (.work.biz/, .cursorrules)"
  # ── Post-deploy verification (in-place only) ───────────────────────
  # update repairs via --fix; skip/force verifies read-only (repair is
  # update's job — no-overwrite mode must not edit an existing file).
  echo ""
  echo "=== post-deploy verification ==="
  vr_rc=0
  if [[ "$MODE" == "update" ]]; then
    BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" --fix "$REPO_ROOT" || vr_rc=$?
  else
    BIZ_SOURCE="$BIZ_ROOT" bash "$BIZ_ROOT/scripts/biz-cursorrules-verify.sh" "$REPO_ROOT" || vr_rc=$?
  fi
  if [[ "$vr_rc" -ne 0 ]]; then
    if [[ "$MODE" == "update" ]]; then
      echo "  update could not auto-repair all findings — review [FAIL] lines above"
      exit "$vr_rc"
    fi
    echo "  (findings are pre-existing; run @biz-deploy-files update to repair)"
  fi
else
  echo "Next: @biz-bootstrap init or bash templates/bootstrap.sh"
fi
echo "  Then: @biz-strategy greenfield"
