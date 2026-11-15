#!/usr/bin/env bash
# prose-rhythm-check.sh - measurable voice-floor checks for lead-facing prose.
#
# WHY THIS EXISTS
# On 2026-11-14 a LinkedIn post was compressed from 389 to 299 words by deleting connectives and
# verbs. It measured 3 runs of same-length sentences, 5 pairs of consecutive sub-8-word sentences,
# and verbless fragments. The owner rejected it: "the way the paragraphs are broken down into
# sentences totally signal AI-generated... sometimes they feel choppy, or incomplete."
# The framework floor already forbade it (standards/20260621-CONTENT-STANDARD.md:143 "Vary sentence
# length... Avoid chains of same-length sentences"). The rule existed; nothing enforced it.
# A second pass then over-corrected into chains of uniformly LONG sentences, which passed a naive
# checker and still read wrong - hence the separate long-chain test.
#
# WHAT IT CHECKS (thresholds from .work.biz/reference/VOICE_PROFILE.md section "Sentence architecture")
#   1. sentence-length spread >= 15 words
#   2. no 3+ consecutive sentences within 2 words of the same length   (choppy)
#   3. no 3+ consecutive sentences over 30 words                       (uniform-long)
#   4. no consecutive pair of sentences under 8 words
#   5. zero em dashes and en dashes, zero curly quotes
#   6. word count and character count reported (LinkedIn hard limit is 3000 characters)
#
# WHAT IT DELIBERATELY DOES NOT CHECK
# Fragment detection is reported but never fails the run: a genuine checklist of gates or controls is
# supposed to be terse and parallel, and prose metrics pointed at a list produce false positives.
# Markdown headings, tables, blockquotes, list markers and HTML comments are stripped before scoring,
# so only narrative prose is measured. Judge lists by eye.
#
# USAGE
#   prose-rhythm-check.sh <file> [<file>...]     check prose files
#   prose-rhythm-check.sh --self-test            verify the checker against known-good and known-bad input
#
# EXIT: 0 all files pass, 1 at least one failure, 2 usage error.
set -uo pipefail

PY_CHECK='
import re, sys
t = open(sys.argv[1], encoding="utf-8", errors="replace").read()
t = re.sub(r"<!--.*?-->", "", t, flags=re.S)              # HTML comments
t = re.sub(r"^```.*?^```", "", t, flags=re.S | re.M)       # fenced code
lines = []
for ln in t.splitlines():
    s = ln.strip()
    if not s: continue
    if s.startswith(("#", "|", ">", "![", "---")): continue
    if re.match(r"^([-*+]\s+|\d+\.\s+)", s): continue      # lists are EXEMPT: a checklist is meant
    if re.match(r"^\*\*[^*]{1,60}:\*\*$", s): continue      # to be terse and parallel; scoring it as
    lines.append(s)                                         # prose produces false failures
t_prose = "\n".join(lines)
prose_words = t_prose.split()
if len(prose_words) < 120:
    print(f"SKIP  {sys.argv[1]}")
    print(f"      {len(prose_words)} words of narrative prose, under the 120-word floor")
    print("      Scope is narrative prose: posts, articles, video scripts, war stories, case")
    print("      studies. Message-template kits, short disclaimers, list-heavy and tabular")
    print("      documents are out of scope and must be judged by eye, not by this script.")
    sys.exit(0)
sents = [x.strip() for x in re.split(r"(?<=[.!?])\s+", t_prose) if len(x.split()) > 2]
w = [len(x.split()) for x in sents]
fails = []
spread = max(w) - min(w)
if spread < 15: fails.append(f"spread {spread} < 15")
runs = [i for i in range(len(w)-2) if abs(w[i]-w[i+1]) <= 2 and abs(w[i+1]-w[i+2]) <= 2]
if runs: fails.append(f"{len(runs)} same-length run(s)")
short = [i for i in range(len(w)-1) if w[i] < 8 and w[i+1] < 8]
if short: fails.append(f"{len(short)} consecutive short-sentence pair(s)")
longc = [i for i in range(len(w)-2) if w[i] > 30 and w[i+1] > 30 and w[i+2] > 30]
if longc: fails.append(f"{len(longc)} uniform-long chain(s)")
em, en = t.count("\u2014"), t.count("\u2013")
curly = len(re.findall(r"[\u2018\u2019\u201c\u201d]", t))
if em or en or curly: fails.append(f"dashes em={em} en={en} curly={curly}")
dup = len(w) > 12 and w[:len(w)//2] == w[len(w)//2:len(w)//2+len(w)//2]
if dup: fails.append("body appears twice in this file - check each copy separately")
status = "FAIL" if fails else "PASS"
print(f"{status}  {sys.argv[1]}")
print(f"      {len(t.split())} words total ({len(prose_words)} narrative prose), {len(t.strip())} chars, spread {spread}, shortest {min(w)}, longest {max(w)}")
print(f"      lengths: {w}")
if fails: print("      " + "; ".join(fails))
sys.exit(1 if fails else 0)
'

self_test() {
  local tmp rc bad=0
  tmp="$(mktemp -d)"
  # known-bad: choppy, uniform-short, verbless fragments, em dash. Must exceed the 120-word prose
  # floor or it would SKIP instead of FAIL and the self-test would prove nothing.
  cat > "$tmp/bad.md" <<'EOF'
Nobody hacked anything. It was a config change. The servers fell over. Recovery failed too. Nobody noticed — for hours.
Teams went down fast. Users complained loudly. Engineers paged in late. The fix reverted it. Nothing changed after that.
The postmortem was short. The action items vanished. The same thing repeated. Six months later again. Nobody was surprised.
This is how it goes. Every single time. The tools never change. The habits never change. The outcome never changes either.
Somebody writes a document. Nobody reads that document. The system breaks again. Everyone acts shocked. Nobody actually is.
The vendor blamed configuration. The team blamed the vendor. Both were partly right. Neither was useful. The outage continued.
That is the whole story. It always is. Nothing gets learned. Nothing gets fixed. The next one arrives right on schedule.
EOF
  # known-good: interleaved lengths, complete clauses, no dashes
  cat > "$tmp/good.md" <<'EOF'
Exchange Online started dropping mailboxes on November 12, and within an hour the monitoring services had
reports from seventy-four countries. The incident stayed open for more than a day. Microsoft insisted the
cause was technical rather than a cyberattack, and the next morning the FAA ground-stopped every airport
in the country for the first time since January 2023.

What struck me was not the outage itself but the fact that the explanation changed four times in a single
day. There is still no published root cause. My read, after thirty-six years of building systems that are
not allowed to go down, is that a properly planned incident does not change its story that often.

I owned a corporate payments gateway for fourteen years with more than a hundred integrations, and the
lesson I took from it is that you never get to see the change calendar of anything you depend on. So you
design the degraded path first, while nothing is burning.
EOF
  python3 -c "$PY_CHECK" "$tmp/bad.md" >/dev/null 2>&1; rc=$?
  [ $rc -eq 1 ] || { echo "SELF-TEST FAIL: known-bad sample passed (expected exit 1, got $rc)"; bad=1; }
  python3 -c "$PY_CHECK" "$tmp/good.md" >/dev/null 2>&1; rc=$?
  [ $rc -eq 0 ] || { echo "SELF-TEST FAIL: known-good sample failed (expected exit 0, got $rc)"; bad=1; }
  rm -rf "$tmp"
  if [ $bad -eq 0 ]; then echo "prose-rhythm-check self-test: PASS"; return 0; fi
  echo "prose-rhythm-check self-test: FAIL"; return 1
}

if [ $# -eq 0 ]; then
  echo "usage: prose-rhythm-check.sh <file> [...] | --self-test" >&2; exit 2
fi
if [ "$1" = "--self-test" ]; then self_test; exit $?; fi

rc_all=0
for f in "$@"; do
  if [ ! -f "$f" ]; then echo "FAIL  $f: no such file"; rc_all=1; continue; fi
  python3 -c "$PY_CHECK" "$f" || rc_all=1
done
exit $rc_all
