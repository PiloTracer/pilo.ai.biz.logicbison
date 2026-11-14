#!/usr/bin/env bash
# gate-verify.sh — Verify NEXT.md tasks cite evidence and claimed gates have support.
#
# Two independent checks:
#   1. Every row in NEXT.md's task tables has a non-empty description/Notes cell.
#   2. Every gate claiming PASS in .work.biz/gates.md has its evidence on disk,
#      and every phase NEXT.md reports as reached has a matching PASS in the ledger.
#
# The ledger is authoritative. Mentioning a gate name in prose is not a claim that
# the gate is met, so notes like "unlocks the strategy-ready gate" do not trip this.
#
# Use --warn-only to report findings and exit 0. Use --self-test to check the parsers.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0
WARN_ONLY=0
SELF_TEST=0

while [ $# -gt 0 ]; do
  case "$1" in
    --warn-only) WARN_ONLY=1 ;;
    --self-test) SELF_TEST=1 ;;
    *) echo "usage: gate-verify.sh [--warn-only] [--self-test]" >&2; exit 2 ;;
  esac
  shift
done

gate_fail() { echo "FAIL: $*" >&2; fail=1; }

# Print the raw Status value of a "## <gate>" section in a gates ledger, or nothing.
#
# Tolerant by design, because real ledgers are hand-annotated:
#   - heading ids match on a normalized form, so "## active deal", "## Active-Deal",
#     and "## active_deal" all resolve to active-deal
#   - the Status value is returned verbatim, including trailing commentary such as
#     "PASS 2026-07-25 - deployed and verified live", so callers can report it
# Use gate_is_met() to decide whether the gate counts as met.
gate_status() {
  local file="$1" gate="$2"
  awk -v want="$gate" '
    function norm(s) {
      sub(/^##[[:space:]]+/, "", s)
      s = tolower(s)
      gsub(/[[:space:]_]+/, "-", s)
      gsub(/^-+|-+$/, "", s)
      return s
    }
    /^## / {
      if (inside) exit
      if (norm($0) == want) { inside = 1 }
      next
    }
    inside && /^\*\*Status:\*\*/ {
      sub(/^\*\*Status:\*\*[[:space:]]*/, "")
      gsub(/^[[:space:]]+|[[:space:]]+$/, "")
      print
      exit
    }
  ' "$file"
}

# A gate is met only when its Status value starts with the word PASS. Anything else
# (NOT MET, NOT ATTEMPTED, ACTIVATED, NONE, FAIL, BLOCKED, absent) is not met.
gate_is_met() {
  printf '%s' "${1:-}" | grep -qiE '^pass([^a-z]|$)'
}

# Does a NEXT.md phase cell claim the phase has been reached?
#
# Negative markers are checked first and win outright, because a cell routinely
# names the gate it is waiting on: "Pending (gated on strategy-ready)" must not
# read as reached just because it contains the word "ready".
#
# The affirmative pattern additionally refuses a match preceded by a hyphen, so a
# bare gate id such as "strategy-ready" is never mistaken for a status.
phase_claims_reached() {
  local val="${1:-}"
  [ -n "$val" ] || return 1

  if printf '%s' "$val" | grep -qiE '(^|[^a-z])(pending|not|never|no|blocked|gated|waiting|todo|t\.b\.d|tbd|n/a|deferred|skip|unmet|in progress|wip)([^a-z]|$)'; then
    return 1
  fi

  printf '%s' "$val" | grep -qiE '(^|[^a-z-])(ready|certified|pass|passed|complete|completed|done|met)([^a-z]|$)'
}

# Print the Status cell of a "| <phase> | <status> |" row under "## Current Phase".
phase_status() {
  local file="$1" phase="$2"
  awk -v want="$phase" '
    /^## Current Phase/ { inside = 1; next }
    inside && /^## / { exit }
    inside && /^\|/ && !/^\|[[:space:]]*-/ {
      n = split($0, cells, "|")
      name = cells[2]; val = cells[3]
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
      if (tolower(name) == tolower(want)) { print val; exit }
    }
  ' "$file"
}

# Report rows in a markdown table section whose description cell is empty.
check_table_section() {
  local file="$1" start_marker="$2" end_marker="$3" desc_col="$4"

  awk -v start="$start_marker" -v end="$end_marker" -v col="$desc_col" '
    $0 ~ start { capture=1; next }
    $0 ~ end && capture { capture=0 }
    capture && /^\|/ && !/^\|---/ {
      # Split by "|"; the leading empty cell shifts visible columns by one.
      n = split($0, cells, "|");
      val = cells[col + 1];
      gsub(/[[:space:]]/, "", val);
      task = cells[2];
      gsub(/[[:space:]]/, "", task);
      if (task != "" && task != "#" && val == "") {
        print task;
      }
    }
  ' "$file" 2>/dev/null
}

# --- self-test: exercise the parsers against a fixture -----------------------

self_test() {
  local tmp status
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN

  # Shapes taken from real hand-annotated ledgers, not just the pristine template.
  cat >"${tmp}/gates.md" <<'EOF'
## strategy-ready
**Status:** PASS
**Evidence:** `x`

## brand-ready

**Status:** PASS 2026-07-25 - deployed and verified live (screenshots: dir/)
**Note:** annotated by hand

## pipeline-ready
**Status:** ACTIVATED 2026-07-30 - outreach hold lifted

## sales-ready
**Status:** NOT ATTEMPTED

## active deal
**Status:** NONE - 0 active deals
EOF

  status="$(gate_status "${tmp}/gates.md" strategy-ready)"
  gate_is_met "$status" || { echo "gate-verify self-test: FAIL (strategy-ready not met, parsed '${status}')" >&2; return 1; }

  # A PASS with trailing commentary must still count as met.
  status="$(gate_status "${tmp}/gates.md" brand-ready)"
  gate_is_met "$status" || { echo "gate-verify self-test: FAIL (annotated PASS not met, parsed '${status}')" >&2; return 1; }

  # ACTIVATED, NOT ATTEMPTED, and NONE are not PASS.
  for g in pipeline-ready sales-ready; do
    status="$(gate_status "${tmp}/gates.md" "$g")"
    [ -n "$status" ] || { echo "gate-verify self-test: FAIL (${g} status not found)" >&2; return 1; }
    if gate_is_met "$status"; then
      echo "gate-verify self-test: FAIL (${g} wrongly met, parsed '${status}')" >&2; return 1
    fi
  done

  # A space-separated heading must resolve to the hyphenated gate id.
  status="$(gate_status "${tmp}/gates.md" active-deal)"
  [ -n "$status" ] || { echo "gate-verify self-test: FAIL (space-separated heading not matched)" >&2; return 1; }
  if gate_is_met "$status"; then
    echo "gate-verify self-test: FAIL (active-deal wrongly met, parsed '${status}')" >&2; return 1
  fi

  status="$(gate_status "${tmp}/gates.md" nonexistent-gate)"
  [ -z "$status" ] || { echo "gate-verify self-test: FAIL (absent gate parsed as '${status}')" >&2; return 1; }

  # Phrasings taken from real NEXT.md files, not sanitized one-word values. A cell
  # routinely names the gate it waits on, which is what broke the first version.
  cat >"${tmp}/NEXT.md" <<'EOF'
## Current Phase

| Phase | Status |
|-------|--------|
| Strategy | Ready |
| Brand | Pending (gated on strategy-ready) |
| Pipeline | Not started |
| Sales | Blocked — waiting on pipeline-ready |
| Delivery | Complete |

## Active tasks
EOF

  status="$(phase_status "${tmp}/NEXT.md" Strategy)"
  phase_claims_reached "$status" || { echo "gate-verify self-test: FAIL (Strategy '${status}' should claim reached)" >&2; return 1; }

  status="$(phase_status "${tmp}/NEXT.md" Delivery)"
  phase_claims_reached "$status" || { echo "gate-verify self-test: FAIL (Delivery '${status}' should claim reached)" >&2; return 1; }

  # None of these claim the phase is reached, even though each contains a word
  # that the naive affirmative pattern matched.
  for p in Brand Pipeline Sales; do
    status="$(phase_status "${tmp}/NEXT.md" "$p")"
    [ -n "$status" ] || { echo "gate-verify self-test: FAIL (${p} phase not found)" >&2; return 1; }
    if phase_claims_reached "$status"; then
      echo "gate-verify self-test: FAIL (${p} '${status}' wrongly claims reached)" >&2; return 1
    fi
  done

  echo "gate-verify self-test: PASS"
}

if [ "$SELF_TEST" -eq 1 ]; then
  self_test
  exit $?
fi

# --- check 1: NEXT.md tasks cite evidence -----------------------------------

NEXT="${REPO_ROOT}/.work.biz/plans/NEXT.md"

if [ -f "$NEXT" ]; then
  # Active tasks: columns are # | Task | Status | Notes
  while IFS= read -r task; do
    [ -n "$task" ] && gate_fail "Active task '${task}' has empty Notes — cite evidence"
  done < <(check_table_section "$NEXT" "## Active tasks" "## " 4)

  # Recently completed: columns are # | What was done | Date
  while IFS= read -r task; do
    [ -n "$task" ] && gate_fail "Recently completed task '${task}' has empty description — cite evidence"
  done < <(check_table_section "$NEXT" "## Recently completed" "## " 2)
fi

# --- check 2: claimed gates have evidence -----------------------------------

WORK="${REPO_ROOT}/.work.biz"
GATES="${WORK}/gates.md"

# gate id | NEXT.md phase name | evidence paths relative to .work.biz/
GATE_SPEC="
strategy-ready|Strategy|strategy/certification.md
brand-ready|Brand|reference/BRAND_STATUS.md
pipeline-ready|Pipeline|strategy/pricing.md pipeline/pipeline_tracker.md pipeline/outreach-cadence.md
sales-ready|Sales|pipeline/pipeline_tracker.md
active-deal||pipeline/pipeline_tracker.md
"

if [ ! -d "$WORK" ]; then
  echo "skip: no .work.biz/ — not a Business OS project, gate ledger checks not applicable"
elif [ ! -f "$GATES" ]; then
  # A bootstrapped project that has lost its ledger must not pass silently. Every
  # gate check below would be skipped and the script would still print PASS, which
  # is the worst possible outcome for a framework whose gates are its main claim.
  # Distinguish that from a repo that never had .work.biz/ at all.
  gate_fail ".work.biz/ exists but gates.md is missing — gate claims cannot be verified without a ledger; re-run @biz-bootstrap to restore it"
else
  while IFS='|' read -r gate phase evidence; do
    [ -z "$gate" ] && continue

    status="$(gate_status "$GATES" "$gate")"

    if gate_is_met "$status"; then
      for path in $evidence; do
        if [ ! -e "${WORK}/${path}" ]; then
          gate_fail "gates.md claims ${gate} PASS but .work.biz/${path} is missing"
        fi
      done
    fi

    # A phase reported as reached in NEXT.md must be backed by the ledger.
    if [ -n "$phase" ] && [ -f "$NEXT" ]; then
      phase_val="$(phase_status "$NEXT" "$phase")"
      if phase_claims_reached "$phase_val"; then
        if ! gate_is_met "$status"; then
          gate_fail "NEXT.md reports ${phase} phase as '${phase_val}' but gates.md has ${gate} at '${status:-absent}'"
        fi
      fi
    fi
  done <<EOF
$(echo "$GATE_SPEC")
EOF
fi

if [ "$fail" -eq 0 ]; then
  echo "gate-verify: PASS"
  exit 0
fi

if [ "$WARN_ONLY" -eq 1 ]; then
  echo "gate-verify: WARN (findings above; --warn-only)"
  exit 0
fi

echo "gate-verify: FAIL (use --warn-only to override)"
exit 1
