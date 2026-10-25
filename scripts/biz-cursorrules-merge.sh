#!/usr/bin/env bash
# biz-cursorrules-merge.sh — install / refresh the managed Business OS block in a
# consumer project's .cursorrules, without touching anything outside the markers.
#
# Why a block instead of a whole file: a target project that already runs another
# OS framework (Agent OS, UI Design OS, Social OS, …) already owns a .cursorrules.
# Overwriting it destroys the other framework's rules; skipping it leaves Business
# OS completely unwired (no source pointer, no skills table), which looks like a
# successful deploy and silently does nothing. The block is the only operation that
# is both useful and non-destructive:
#
#   <!-- BIZ_DESIGN_OS_BEGIN -->  …managed by this script…
#   <!-- BIZ_DESIGN_OS_END -->
#
# Content outside the markers is never read, rewritten, or reordered. Re-running is
# idempotent: `merge` never changes an existing block, `refresh` replaces only the
# region between the markers.
#
# Layouts:
#   thin  — framework assets live in the source root; the block carries
#           AI_BIZ_SOURCE=<absolute source> and absolute script paths.
#   fat   — framework assets are vendored at <target>/.ai.biz; the block carries no
#           pointer and references .ai.biz/ relative to the target.
#
# Usage:
#   bash scripts/biz-cursorrules-merge.sh <target-root>                    # merge (add if absent)
#   bash scripts/biz-cursorrules-merge.sh <target-root> --refresh          # add or rewrite the block
#   bash scripts/biz-cursorrules-merge.sh <target-root> --print            # render the block to stdout
#   bash scripts/biz-cursorrules-merge.sh <target-root> --state            # present|absent|legacy|unterminated|none
#   bash scripts/biz-cursorrules-merge.sh <target-root> --layout fat
#   BIZ_SOURCE=/abs/path/to/source bash scripts/biz-cursorrules-merge.sh <target>
#
# Verbs accept the '--' prefix or the bare form; flags may appear in any position.
# Exit: 0 = done (merge/refresh/print/state) · 1 = block is malformed and was not
#       touched · 2 = usage or missing template.
set -euo pipefail

BEGIN_MARK='<!-- BIZ_DESIGN_OS_BEGIN -->'
END_MARK='<!-- BIZ_DESIGN_OS_END -->'

MODE="merge"
LAYOUT="thin"
RAW_TARGET=""
USAGE="Usage: $0 <target-root> [--merge|--refresh|--print|--state] [--layout thin|fat]"
while [[ $# -gt 0 ]]; do
  arg="$1"; shift || true
  [[ "$arg" == "-" || "$arg" == "--" ]] && continue
  tok="${arg#--}"
  case "$tok" in
    merge|refresh|print|state) MODE="$tok" ;;
    thin|fat) LAYOUT="$tok" ;;
    layout|layout=*)
      if [[ "$tok" == layout=* ]]; then LAYOUT="${tok#layout=}"
      elif [[ $# -gt 0 ]]; then LAYOUT="$1"; shift
      else echo "ERROR: --layout needs a value (thin|fat)" >&2; echo "$USAGE" >&2; exit 2; fi ;;
    /*|./*|../*|~*|*/*|.)
      if [[ -z "$RAW_TARGET" ]]; then RAW_TARGET="$arg"
      else echo "ERROR: multiple target paths: '$RAW_TARGET' and '$arg'" >&2; exit 2; fi ;;
    *) echo "ERROR: unknown argument: $arg" >&2; echo "$USAGE" >&2; exit 2 ;;
  esac
done
case "$LAYOUT" in thin|fat) ;; *) echo "ERROR: unknown layout '$LAYOUT' (thin|fat)" >&2; echo "$USAGE" >&2; exit 2 ;; esac
[[ -n "$RAW_TARGET" ]] || { echo "$USAGE" >&2; exit 2; }

# Source root: explicit override wins, else derive from this script's location.
# pwd -P canonicalises symlinked installs so the same physical source always
# produces the same pointer (an install reachable as both /x/.ai.biz and
# /x/pilo.ai.biz.logicbison must not bake two different paths into targets).
if [[ -n "${BIZ_SOURCE:-}" ]]; then
  BIZ_ROOT="$(cd "$BIZ_SOURCE" && pwd -P)"
else
  BIZ_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
fi

if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
  DEST_ROOT="$(pwd -P)"
else
  DEST_ROOT="$(cd "$RAW_TARGET" 2>/dev/null && pwd -P)" || {
    echo "ERROR: target directory does not exist: $RAW_TARGET" >&2; exit 2; }
fi
CURS="${DEST_ROOT}/.cursorrules"
SNIPPET_TPL="${BIZ_ROOT}/templates/cursorrules.biz.snippet.template"

# ── Block state ────────────────────────────────────────────────────────
# present      — exactly one BEGIN/END pair (the normal, healthy state)
# unterminated — a marker appears without its pair (a hand-edited block)
# legacy       — Business OS is wired, but without markers (a hand merge or a
#                pre-block standalone .cursorrules); never append a second block
# absent       — no Business OS wiring at all (foreign framework file, or empty)
# none         — no .cursorrules yet
block_state() {
  [[ -f "$CURS" ]] || { echo none; return 0; }
  local n_begin n_end
  n_begin="$(grep -cxF "$BEGIN_MARK" "$CURS" 2>/dev/null || true)"
  n_end="$(grep -cxF "$END_MARK" "$CURS" 2>/dev/null || true)"
  n_begin="${n_begin:-0}"; n_end="${n_end:-0}"
  if [[ "$n_begin" -eq 1 && "$n_end" -eq 1 ]]; then echo present; return 0; fi
  if [[ "$n_begin" -gt 0 || "$n_end" -gt 0 ]]; then echo unterminated; return 0; fi
  if grep -qE 'AI_BIZ_SOURCE=|^\| `?biz-strategy`? \||^## Business OS \(`\.ai\.biz' "$CURS" 2>/dev/null; then
    echo legacy; return 0
  fi
  echo absent
}

# ── Render the block for the requested layout ─────────────────────────
render_block() {
  [[ -f "$SNIPPET_TPL" ]] || {
    echo "ERROR: source template missing: $SNIPPET_TPL" >&2; exit 2; }
  local rendered ptr tmp_snip
  rendered="$(mktemp)"; ptr="$(mktemp)"; tmp_snip="$(mktemp)"
  # `${var:-}`: the RETURN trap is global and may fire after these locals are gone.
  trap 'rm -f "${rendered:-}" "${ptr:-}" "${tmp_snip:-}"' RETURN

  if [[ "$LAYOUT" == "fat" ]]; then
    cat > "$ptr" <<EOF
**Business OS source (fat-client — vendored in this repo):** framework assets live at \`.ai.biz/\` in this repo; \`.work.biz/\` is local project memory. There is no source pointer to resolve.
EOF
  else
    cat > "$ptr" <<EOF
**Business OS source (thin-client — written by \`@biz-deploy-basic\`):**

AI_BIZ_SOURCE=REPLACE_BASICSOURCE

*(If the line above still reads \`REPLACE_BASICSOURCE\`, the block was hand-copied rather than deployed: run \`bash ${BIZ_ROOT}/scripts/biz-deploy-basic.sh . update\` to wire it. Legacy installs used \`AGENT_OS_SOURCE=\`; treat it as this pointer only when it resolves to a Business OS root.)*
EOF
  fi

  # Substitute the pointer section (multi-line) by marker line.
  awk -v ptrfile="$ptr" '
    /^REPLACE_BIZ_POINTER_SECTION$/ { while ((getline l < ptrfile) > 0) print l; close(ptrfile); next }
    { print }
  ' "$SNIPPET_TPL" > "$rendered"

  if [[ "$LAYOUT" == "fat" ]]; then
    # Local absolute-free references: the vendored copy is this repo's .ai.biz/.
    perl -i -pe 's{\$AI_BIZ_SOURCE/}{.ai.biz/}g' "$rendered"
    # Two fixed-length lookbehinds (an alternation inside one is variable-length
    # and perl warns / misbehaves): skip `bash /abs/...` and an already-vendored
    # `bash .ai.biz/scripts/`.
    perl -i -pe 's{bash (?<!/)(?<!\.ai\.biz/)scripts/}{bash .ai.biz/scripts/}g' "$rendered"
  else
    local esc="${BIZ_ROOT//\//\\/}"
    perl -i -pe "s/AI_BIZ_SOURCE=REPLACE_BASICSOURCE/AI_BIZ_SOURCE=${esc}/" "$rendered"
    perl -i -pe "s{bash (?<!/)scripts/}{bash ${esc}/scripts/}g" "$rendered"
  fi

  # A block must never carry an unresolved source pointer.
  if [[ "$LAYOUT" == "thin" ]] && grep -q '^AI_BIZ_SOURCE=REPLACE_BASICSOURCE$' "$rendered"; then
    echo "ERROR: rendered block still contains REPLACE_BASICSOURCE (source root: $BIZ_ROOT)" >&2
    exit 2
  fi

  cat "$rendered"
}

# Inner content of the block (markers stripped) — used by refresh.
render_inner() {
  render_block | tail -n +2 | grep -vxF "$END_MARK"
}

# ── Actions ────────────────────────────────────────────────────────────
case "$MODE" in
  state)
    block_state
    exit 0
    ;;
  print)
    render_block
    exit 0
    ;;
esac

state="$(block_state)"
case "$state" in
  none|absent)
    # Writability first: a read-only target (permission, read-only mount, or a
    # sandbox) must fail before anything is touched, not halfway through an
    # append that would leave a stray separator line behind.
    if [[ -f "$CURS" ]]; then
      [[ -w "$CURS" ]] || { echo "ERROR: ${CURS} is not writable — refusing to modify it" >&2; exit 1; }
    else
      mkdir -p "$DEST_ROOT" 2>/dev/null || true
      [[ -w "$DEST_ROOT" ]] || { echo "ERROR: ${DEST_ROOT} is not writable — cannot create .cursorrules" >&2; exit 1; }
    fi
    payload="$(mktemp)"; trap 'rm -f "${payload:-}"' EXIT
    # Preserve the existing file byte-for-byte; only append. One write: the
    # separator and the block are composed first, so a failure cannot leave the
    # file half-appended.
    sep=0
    if [[ -f "$CURS" ]]; then
      sep=1
      [[ -s "$CURS" && -n "$(tail -c 1 "$CURS")" ]] && sep=2
      { printf '\n'; [[ "$sep" -eq 2 ]] && printf '\n'; } > "$payload"
    else
      : > "$payload"
    fi
    render_block >> "$payload"
    cat "$payload" >> "$CURS"
    added=$(( $(wc -l < "$payload" | tr -d ' ') - sep ))
    if [[ "$state" == "none" ]]; then
      echo "cursorrules: created ${CURS} with the Business OS block (${added} lines)"
    else
      echo "cursorrules: merged Business OS block → ${CURS} (+${added} lines, existing content untouched)"
    fi
    ;;
  present)
    if [[ "$MODE" == "refresh" ]]; then
      inner="$(mktemp)"; out="$(mktemp)"; before="$(mktemp)"
      trap 'rm -f "$inner" "$out" "$before"' EXIT
      render_inner > "$inner"
      cp "$CURS" "$before"
      awk -v inner="$inner" '
        /^<!-- BIZ_DESIGN_OS_BEGIN -->$/ {
          print
          while ((getline l < inner) > 0) print l
          close(inner)
          inblock = 1
          next
        }
        inblock && /^<!-- BIZ_DESIGN_OS_END -->$/ { inblock = 0; print; next }
        inblock { next }
        { print }
      ' "$before" > "$out"
      if cmp -s "$out" "$CURS"; then
        echo "cursorrules: block already current (${CURS})"
      else
        cat "$out" > "$CURS"
        echo "cursorrules: refreshed Business OS block → ${CURS} (content outside the markers untouched)"
      fi
    else
      echo "cursorrules: Business OS block present — left as is (use --refresh to update it)"
    fi
    ;;
  legacy)
    echo "cursorrules: Business OS already wired without managed markers (hand merge or standalone file) — no block added"
    ;;
  unterminated)
    echo "ERROR: ${CURS} has an unmatched Business OS marker" >&2
    grep -nxF -e "$BEGIN_MARK" -e "$END_MARK" "$CURS" | sed 's/^/  /' >&2
    echo "Repair the marker pair by hand (or restore the region from git), then re-run." >&2
    exit 1
    ;;
esac
