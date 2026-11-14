#!/usr/bin/env bash
# blast-radius-check.sh — Detect cross-area diffs.
#
# Measures what the NEXT commit would carry:
#   - anything staged  -> staged content only (git diff --cached), so a scoped
#     commit of one area passes even while other areas sit unstaged in the
#     working tree (the split-into-scoped-commits workflow this script enforces)
#   - nothing staged   -> the whole working tree against HEAD (pre-commit sweep)
#
# Default: exit non-zero when ≥3 top-level areas are touched (high risk).
# Use --warn-only to print the risk and exit 0.
set -euo pipefail

WARN_ONLY=0
SELF_TEST=0

for arg in "$@"; do
  case "$arg" in
    --warn-only) WARN_ONLY=1 ;;
    --self-test) SELF_TEST=1 ;;
  esac
done

# Classify a file list (one path per line on stdin) into top-level areas and
# report risk. Shared by the real run and the self-test.
measure() {
  local all_files file area
  all_files="$(sort -u | grep -v '^$' || true)"

  if [ -z "$all_files" ]; then
    echo "blast-radius: files=0 areas=none risk=low"
    echo "blast-radius-check: PASS"
    return 0
  fi

  local -A AREAS=()
  for file in $all_files; do
    area="$(echo "$file" | cut -d/ -f1)"
    AREAS["$area"]=$((${AREAS["$area"]:-0} + 1))
  done

  local file_count area_count risk
  file_count="$(echo "$all_files" | wc -l)"
  area_count="${#AREAS[@]}"

  risk="low"
  if [ "$area_count" -ge 3 ]; then
    risk="high"
  elif [ "$area_count" -ge 2 ]; then
    risk="med"
  fi

  echo "blast-radius: files=${file_count} areas=${area_count} risk=${risk}"
  for area in "${!AREAS[@]}"; do
    echo "  ${area}: ${AREAS[$area]}"
  done

  if [ "$risk" = "high" ]; then
    if [ "$WARN_ONLY" -eq 1 ]; then
      echo "blast-radius-check: WARN (high risk — consider splitting the change)"
      return 0
    else
      echo "blast-radius-check: FAIL (high risk — ≥3 areas touched; use --warn-only to override)"
      return 1
    fi
  fi

  echo "blast-radius-check: PASS"
  return 0
}

# The file set to measure. Staged content wins when it exists: that is what the
# next commit carries, and counting unstaged leftovers would make the first
# scoped commit of a split workflow impossible to pass.
collect_files() {
  local staged
  staged="$(git diff --cached --name-only 2>/dev/null || true)"
  if [ -n "$staged" ]; then
    echo "measuring: staged content (what the next commit carries)" >&2
    printf '%s\n' "$staged"
  else
    # Untracked files count here. `git diff HEAD` is blind to them, so a session
    # that scaffolds a new tree (a new skill folder, a bootstrap run) used to be
    # rated on the tracked half of its own change.
    echo "measuring: working tree vs HEAD, incl. untracked (nothing staged)" >&2
    git diff --name-only HEAD 2>/dev/null || true
    git ls-files --others --exclude-standard 2>/dev/null || true
  fi
}

if [ "$SELF_TEST" -eq 1 ]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  git init -q "$tmp"
  git -C "$tmp" -c user.email=self@test -c user.name=self commit -q --allow-empty -m init

  fail=0

  # Clean tree: no files, low risk, PASS.
  if ! ( cd "$tmp" && collect_files | measure >/dev/null ); then
    echo "blast-radius-check self-test: FAIL (clean tree should pass)" >&2; fail=1
  fi

  # Three areas changed but only ONE staged: the scoped commit must pass.
  # This is the exact case the old HEAD-diff behavior failed.
  mkdir -p "$tmp/a" "$tmp/b" "$tmp/c"
  echo x > "$tmp/a/1"; echo x > "$tmp/b/1"; echo x > "$tmp/c/1"

  # Untracked with nothing staged: the three new areas must already rate high
  # risk. Before untracked-awareness this measured files=0 and passed silently.
  if ( cd "$tmp" && collect_files | measure >/dev/null ); then
    echo "blast-radius-check self-test: FAIL (three untracked areas, nothing staged, should fail)" >&2; fail=1
  fi

  git -C "$tmp" add a/1
  if ! ( cd "$tmp" && collect_files | measure >/dev/null ); then
    echo "blast-radius-check self-test: FAIL (one staged area amid three changed areas should pass)" >&2; fail=1
  fi

  # All three areas staged: high risk, must fail without --warn-only.
  git -C "$tmp" add b/1 c/1
  if ( cd "$tmp" && collect_files | measure >/dev/null ); then
    echo "blast-radius-check self-test: FAIL (three staged areas should fail)" >&2; fail=1
  fi

  # Same three staged areas with --warn-only must pass.
  WARN_ONLY=1
  if ! ( cd "$tmp" && collect_files | measure >/dev/null ); then
    echo "blast-radius-check self-test: FAIL (--warn-only should pass three staged areas)" >&2; fail=1
  fi

  if [ "$fail" -eq 0 ]; then
    echo "blast-radius-check self-test: PASS"
  fi
  exit "$fail"
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

collect_files | measure
