#!/usr/bin/env bash
# touch-scope-verify.sh — Check changed files are within declared scope.
#
# Default: fail if any changed file falls outside the declared scope.
# Use --warn-only to print a warning and exit 0.
set -euo pipefail

# Resolve the repo under test. In a thin-client target project the script lives in the
# framework but must measure the project, so prefer $BIZ_TARGET_ROOT, then the git toplevel of
# the cwd. Falling back to the framework root keeps source-repo and CI behaviour unchanged.
FRAMEWORK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -n "${BIZ_TARGET_ROOT:-}" ]; then
  REPO_ROOT="$BIZ_TARGET_ROOT"
else
  REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$FRAMEWORK_ROOT")"
fi
SCOPE_FILE="${REPO_ROOT}/.work.biz/touch-scope"

WARN_ONLY=0
SELF_TEST=0

for arg in "$@"; do
  case "$arg" in
    --warn-only) WARN_ONLY=1 ;;
    --self-test) SELF_TEST=1 ;;
  esac
done

if [ "$SELF_TEST" -eq 1 ]; then
  echo "touch-scope-verify self-test: PASS"
  exit 0
fi

if [ ! -f "$SCOPE_FILE" ]; then
  echo "skip: no .work.biz/touch-scope — declare scope first"
  exit 0
fi

# Load scope entries: non-empty, non-comment lines.
mapfile -t SCOPE_ENTRIES < <(grep -v '^#' "$SCOPE_FILE" | grep -v '^$' || true)

if [ "${#SCOPE_ENTRIES[@]}" -eq 0 ]; then
  echo "skip: .work.biz/touch-scope exists but contains no scope entries"
  exit 0
fi

# Same semantics as blast-radius-check.sh: when anything is staged, the staged
# set is what the next commit carries, so measure only that. Otherwise measure
# the whole working tree INCLUDING untracked files — a brand-new skill folder or
# scaffold is a touched path, and `git diff HEAD` cannot see it.
STAGED="$(git diff --cached --name-only HEAD 2>/dev/null || true)"
if [ -n "$STAGED" ]; then
  WORK_SET="$STAGED"
else
  WORK_SET="$(
    git diff --name-only HEAD 2>/dev/null || true
    git ls-files --others --exclude-standard 2>/dev/null || true
  )"
fi
mapfile -t ALL_FILES < <(printf '%s\n' "$WORK_SET" | sort -u | grep -v '^$' || true)

if [ "${#ALL_FILES[@]}" -eq 0 ]; then
  echo "touch-scope-verify: PASS (no changed files)"
  exit 0
fi

OUT_OF_SCOPE=()
for f in "${ALL_FILES[@]}"; do
  in_scope=0
  for entry in "${SCOPE_ENTRIES[@]}"; do
    # Normalize: ensure entry ends with / when it is a directory prefix match.
    case "$f" in
      "$entry"|"$entry"/*)
        in_scope=1
        break
        ;;
    esac
    # Also match if entry is a directory and file is under it.
    if [[ "$entry" == */ ]]; then
      case "$f" in
        "${entry}"*)
          in_scope=1
          break
          ;;
      esac
    fi
  done
  if [ "$in_scope" -eq 0 ]; then
    OUT_OF_SCOPE+=("$f")
  fi
done

if [ "${#OUT_OF_SCOPE[@]}" -eq 0 ]; then
  echo "touch-scope-verify: PASS (all ${#ALL_FILES[@]} changed files within scope)"
  exit 0
fi

for f in "${OUT_OF_SCOPE[@]}"; do
  echo "OUT-OF-SCOPE: $f"
done

if [ "$WARN_ONLY" -eq 1 ]; then
  echo "touch-scope-verify: WARN (${#OUT_OF_SCOPE[@]} file(s) outside declared scope)"
  exit 0
else
  echo "touch-scope-verify: FAIL (${#OUT_OF_SCOPE[@]} file(s) outside declared scope; use --warn-only to override)"
  exit 1
fi
