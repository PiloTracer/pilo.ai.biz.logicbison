---
name: biz-review
description: >-
  Weekly, monthly, and quarterly business review. Assess pipeline, content
  performance, assumption health, overall business health, and — quarterly —
  score the decision ledger to calibrate judgment, audit the rejected strategy
  alternatives (counterfactual), and review the strategy-bet kill signals.
  biz-review weekly, biz-review monthly, biz-review quarterly, biz-review status.
---

# biz-review

**Purpose:** Regular structured review prevents drift. Weekly = tactical. Monthly = assumption truth. Quarterly = strategic, and the only place a past recommendation is scored against what happened.

---

## Entry pre-check

`biz-review` requires at least one strategy doc. Before any mode runs, check `.work.biz/strategy/` for docs. If none exist, stop and redirect:

```text
BLOCKED (prerequisite): no strategy docs found
  Required state: at least one doc in .work.biz/strategy/
  Current state: <what was found>
  To proceed: run `@biz-strategy greenfield`
```

---

## I0 — Status mode (reconciles the gate ledger)

`@biz-review status` is the reconciler for `{WORK_BUSINESS_ROOT}/gates.md`. It checks every gate's evidence against what the ledger claims, and it is the only skill allowed to promote `pipeline-ready`.

| State | Promoted by | Evidence to check |
|-------|-------------|-------------------|
| strategy-ready | `@biz-strategy certify` | `.work.biz/strategy/certification.md` exists, and no **positioning file** under `strategy/` is newer than it (the five decision files: `one-pager.md`, `target-buyer-profile.md`, `offer-scope.md`, `channel-plan.md`, `pricing.md`; ledger, changelog, and ICP are exempt — see the I1 drift check) |
| brand-ready | `@biz-brand overhaul` | `.work.biz/reference/BRAND_STATUS.md` has an overhaul log entry with a passing five-second test |
| pipeline-ready | **this skill** | `.work.biz/strategy/pricing.md`, `.work.biz/pipeline/pipeline_tracker.md` (configured, not an empty template), and `.work.biz/pipeline/outreach-cadence.md` all exist and are filled in |
| sales-ready | `@biz-discovery run` | Pipeline tracker has at least one completed discovery call logged with BANT captured |
| active-deal | `@biz-discovery run` | Pipeline tracker has a deal at Conversation stage or later |

### Reconciliation steps

1. **Read** `{WORK_BUSINESS_ROOT}/gates.md`. If it is missing, create it from `templates/work/gates.md.template` with every gate at `NOT MET`, then continue. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine. Preserve any hand-written annotations and any extra sections the project added (for example a proof-asset table) when you rewrite a gate section.
2. **Verify each PASS claim** against the evidence above. Any gate claiming PASS without its evidence on disk is **demoted** to `NOT MET` and reported as drift — never leave a PASS you could not substantiate.
3. **Promote `pipeline-ready`** when all three of its evidence artifacts exist and are filled in, and `strategy-ready` is PASS. Replace the section in place, leaving other gates untouched:

```markdown
## pipeline-ready
**Status:** PASS
**Certified:** {date}
**By:** @biz-review status
**Evidence:** `.work.biz/strategy/pricing.md`, `.work.biz/pipeline/pipeline_tracker.md`, `.work.biz/pipeline/outreach-cadence.md`
**Next gate:** sales-ready — run `@biz-discovery prepare` then `@biz-discovery run`
```

4. **Do not promote any other gate.** Report what is missing and name the skill that owns it.

Output: a short report of which states are met, which were demoted and why, and the single next command.

---

## I1 — Weekly review (30 min)

### Pull numbers

| Metric | Source | Target |
|--------|--------|--------|
| Posts published | Content tracker | Per content plan |
| Impressions | LinkedIn / blog analytics | Growing week-over-week |
| Inbounds | Pipeline tracker | 3-5 / week |
| Conversations started | Pipeline tracker | 5+ / week |
| Pipeline value | Pipeline tracker | 3x monthly goal |
| Closed this week | Revenue tracker | Per target |

### Pipeline health score

Score each stage 0 (blocked) → 5 (healthy):

| Stage | Score (0-5) | Notes |
|-------|-------------|-------|
| Awareness | | Are people seeing you? |
| Interest | | Are people engaging? |
| Trust | | Are people in conversation? |
| Decision | | Are proposals closing? |

**Total:** ____ / 20. Below 12 means the bottleneck stage needs your ONE change.

### Identify bottleneck

1. Find lowest score above.
2. Trace cause: too few posts? Weak CTA? No follow-up?
3. **Decide ONE change** for next week. Only ONE.

### Drift check (2 min)

1. Compare dates: any **positioning file** under `.work.biz/strategy/` newer than `strategy/certification.md` -> flag "strategy changed since certification; run @biz-strategy certify". Positioning files are the five the certification validates as decisions: `one-pager.md`, `target-buyer-profile.md`, `offer-scope.md`, `channel-plan.md`, `pricing.md`. Exempt by design: `assumption-ledger.md` (monthly re-validation re-grades evidence without changing positioning), `changelog.md` (append-only; reconcile corrections move no gate), and `linkedin-icp.md` (derived artifact written post-certification by `@biz-social icp`). A load-bearing assumption that dies still surfaces: monthly re-validation routes it through `@biz-strategy amend`, which demotes the gate properly.
2. Glob for strategy-bearing files outside `strategy/` (`ideas/positioning_*.md`, `plans/strategy_*.md`) -> flag "out-of-tree strategy docs; run @biz-strategy amend".
3. If anything was published this week, confirm `.work.biz/reference/CONTENT_STATUS.md` was updated. If the file is missing entirely, create it from `templates/work/reference/CONTENT_STATUS.md.template` and backfill the pieces known to be published (self-heal rule, see CONVENTIONS § Content Status Protocol) — a missing tracker means every future session loses the publish record.
4. If anything was published this week, confirm `.work.biz/reference/VOICE_RETRO.md` carries an entry for it (or records the owner pass as waived). A publish with no retro entry means the voice loop did not run and voice convergence is being measured on a partial sample (see CONVENTIONS § Voice loop).
5. Run the I0 reconciliation against `{WORK_BUSINESS_ROOT}/gates.md` -> flag any gate claiming PASS without evidence, and demote it.
6. Read the decision ledger (`.work.biz/decisions/DECISIONS.md`) -> count rows past their `Review by` date still `pending`. Any overdue row is a one-line flag here; three or more means the judgment loop has stopped running and the quarterly audit is the fix. If the ledger is missing while NEXT/HANDOFF show consequential decisions this quarter, flag that too.

Render findings as a short "Drift check" block in the review output (or "clean" if nothing found).

---

## I1b — Monthly review: assumption re-validation (45 min)

Certification is one-shot: it proves the strategy was consistent on the day it was written. Nothing keeps it true afterward. The weekly drift check compares dates, not evidence. Once a month, re-grade the assumptions themselves, because a strategy whose load-bearing assumption died is wrong no matter how clean its paperwork is.

### Inputs

| Source | What it contributes |
|--------|---------------------|
| `strategy/assumption-ledger.md` | The claims under review |
| `pipeline/pipeline_tracker.md` + `pipeline/*-tracker.md` | What buyers actually did since the last re-validation |
| `reference/CONTENT_STATUS.md` (conversations column) | Which strategic messages produced conversations, not just reach |
| `decisions/DECISIONS.md` | Open decisions this quarter's re-grading may have invalidated |
| Discovery call notes logged in the pipeline tracker | What buyers actually said |

### Re-validation steps

1. Walk every row of `strategy/assumption-ledger.md` and re-grade it against evidence accumulated since certification or the last re-validation:
   - **Confirmed** — fresh evidence exists for it. Cite the evidence row: tracker entry, call note, or publish + result.
   - **Inferred** — no new evidence either way. It survives on its original reasoning; say so.
   - **Unknown** — never tested, still untested. Name the cheapest test (`@biz-market-validate test`).
   - **Dead** — evidence now contradicts it: buyers consistently say the opposite, the primary channel produced zero conversations after 6–8 publishes, or real calls rejected the price anchor.
2. Update each row's Evidence column in place and add `Re-validated: <date>` to the ledger's header. Recording the date is what lets the weekly drift check tell a live process from a stale file.
3. For every **dead** assumption, classify it: **load-bearing** (anchors the buyer, the problem, the offer, or the primary channel) or **peripheral**.
4. Verdict:
   - A load-bearing assumption died → route to `@biz-strategy amend` now. Do not wait for the quarterly.
   - Only peripheral assumptions died → record them in `plans/NEXT.md` for the next amend cycle.
   - Nothing died → report the grade counts and set the next re-validation date.
5. **Cross-check the decision ledger.** Any open (`pending`) decision row resting on a dead assumption is now betting on something known to be false. Flag it in the report; if the death was load-bearing, do not wait for the quarterly — the decision needs superseding, not scoring.

### Rules

- Re-validation re-grades evidence; it never rewrites positioning. Any change to buyer, problem, offer, channel, or price goes through `@biz-strategy amend`, which demotes and re-certifies properly.
- Absence of evidence is not confirmation. An assumption with no evidence either way stays Unknown, however long it has sat there.
- A dead assumption is a finding, not a failure. The mode that hides a dead assumption is the one that costs the business its quarter.

---

## I2 — Quarterly review (2 hrs)

### Retrospective questions

- What worked that I should double down on?
- What didn't work that I should stop?
- What did I say I'd do that I didn't? Why?
- What changed in the market / my niche?

### Revenue analysis

| Channel | Rev this Q | Rev prev Q | Trend | Cost (time + $) | ROI |
|---------|-----------|-----------|-------|-----------------|-----|
| LinkedIn content | | | | | |
| Community engagement | | | | | |
| Referrals | | | | | |
| Cold outreach | | | | | |
| Other | | | | | |

### Channel effectiveness

- **Which channel delivered the highest ROI?** → Allocate more time.
- **Which channel consumed time but delivered little?** → Reduce or kill.
- **Which channel is new/unproven?** → Test with small experiment (see `@biz-market-validate`).

### Set next quarter's focus

- One primary growth channel
- One experiment channel
- Revenue target
- Content volume commitment

### Content-strategy alignment (quarterly, ~20 min)

Reach is a vanity metric; conversations are the only column that connects content to revenue. Once a quarter, check which **strategic pillar** actually produced pipeline, so performance flows back into strategy instead of dying inside the tracker.

1. Read `reference/CONTENT_STATUS.md`: the **Items** table (pillar column), the **By pillar** aggregate, and each platform's conversations column. Read `pipeline/*-tracker.md` for the per-platform conversations tables.
2. Aggregate the quarter's conversations by pillar:

| Pillar | Pieces published | Conversations produced | Conversations per piece |
|--------|------------------|------------------------|-------------------------|

3. Verdict per pillar:
   - **Converting** — conversations per piece clearly above the rest. Feed it: more topics on this pillar next quarter, and mine it for case studies (`reference/PROJECTS.md`).
   - **Reaching only** — reach without conversations. It produces authority, not pipeline. Say so plainly; reduce its share or re-shape its CTA toward a conversation.
   - **Silent** — published, no measurable reaction. Test one sharper angle next quarter or drop the pillar.
   - **Untracked** — pieces with an empty pillar column. Assign pillars now; a quarter of untagged pieces is exactly what this section exists to prevent.
4. Feed the result back: a pillar that keeps converting (or keeps failing) across two quarters is strategy evidence. Run `@biz-strategy amend` to let it reshape `channel-plan.md` or the offer emphasis, and record the re-grade in `strategy/assumption-ledger.md`.

---

### Decision audit (quarterly, ~30 min)

Assumptions are re-graded monthly and content is measured by pillar above. **Judgment is measured here or nowhere**: this is the only step in the framework that compares a past recommendation with what actually happened. Skip it and every skill in the framework can only get more confident, never more accurate.

1. Read `.work.biz/decisions/DECISIONS.md`. Select every row whose `Review by` date has passed and whose `Outcome` is still `pending`.
2. For each, gather what actually happened from the sources that can settle it: the pipeline tracker, `CONTENT_STATUS.md` conversations, won/lost records, revenue. Score honestly:
   - `hit` — the expected outcome landed inside its window
   - `partial` — right direction, wrong magnitude or timing
   - `miss` — it did not happen
   - `unclear` — the evidence cannot settle it. Say so rather than scoring a guess. An `unclear` row usually means the expected outcome was never falsifiable, and that is the lesson.
3. Write a one-line `Lesson` per scored row about the **reasoning**, not the market. "We assumed a 5% reply rate with nothing behind it" is a lesson; "the market was slow" is an excuse. Never rewrite a scored row.
4. Update the ledger's **Calibration** table: scored rows, hit rate, mean confidence, and gap per decision class. With fewer than three scored rows in a class, write `insufficient scored rows` and draw no conclusion.
5. **Repeating misses:** three misses in one class is a rule problem, not bad luck. Amend the protocol or the strategy and record it in the ledger's Repeating-misses table. "I'll be more careful" is not a change.
6. Report the debt: rows still `pending` past their review date.

If the ledger is empty while the quarter plainly contained consequential decisions, say that in the report. A decision recorded only as prose can never be scored, and the missing record *is* the finding.

---

### Counterfactual audit (quarterly, ~15 min)

The decision audit scores what was chosen. It cannot answer the question that actually improves strategy design: **was the alternative that lost better?** A framework that never checks its rejects will keep selecting the same way and calling the result experience.

1. Read `strategy/design-record.md` (if absent, report `no design record — strategy was never compared; run @biz-strategy design` and skip this step).
2. For every **rejected play** whose re-entry condition was plausibly triggered this quarter (or whose score was within the 5-point margin), record what would have happened: would the runner-up have sold, reached, or paid better than the winner did? Use the same evidence sources as the decision audit. Where the evidence cannot settle it, say `unclear` rather than inventing a counterfactual.
3. Score the **selection process**, not the plays: did the winning play win for the reason the record gave? Three outcomes are possible and all three are useful:
   - **Predicted** — the winner won on the criterion the record named. The rubric is calibrated; keep it.
   - **Right for the wrong reason** — the play worked, but the criterion that decided the ranking was not the one that mattered. Re-weight that criterion for the next design run and say so.
   - **Wrong** — the runner-up would have won. Re-enter it via `@biz-strategy design` (its re-entry condition is already written) rather than starting from zero.
4. Review the **strategy bets**. For each bet in `one-pager.md` § `## Strategy bets`: is its kill signal triggered? A triggered kill signal with no response is worse than no kill signal, because it now looks managed. Respond or re-date it this quarter, and log the response in the decision ledger.
5. Record the calibration line in the ledger's **Calibration** table under class `strategy-selection`: scored selections, how many were predicted, mean confidence, gap.

If three design selections in a row were scored `wrong`, that is a rubric problem (weights or criteria), not a market problem: amend the rubric in `concepts/strategy-design/prompt.md` §6 and record the change in `strategy/changelog.md`.

---

## I3 — Data source

All numbers come from your **pipeline tracker** (a spreadsheet, CRM, or `.ai.biz/` tracker file). If data isn't tracked, the first action is: *set up tracking for next week.*

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | Weekly: all numbers pulled and recorded | |
| 2 | Weekly: bottleneck identified, ONE change set | |
| 3 | Monthly: every assumption-ledger row re-graded with fresh evidence; `Re-validated` date recorded | |
| 4 | Monthly: dead assumptions classified; load-bearing deaths routed to `@biz-strategy amend` | |
| 5 | Quarterly: retrospective answers written | |
| 6 | Quarterly: channel effectiveness scored | |
| 7 | Quarterly: content-strategy alignment aggregated by pillar; winners fed back toward amend | |
| 8 | Quarterly: next quarter focus documented | |
| 9 | Gate ledger reconciled — every PASS in `.work.biz/gates.md` has its evidence on disk | |
| 10 | Weekly: overdue decision rows flagged | |
| 11 | Quarterly: every pending row past its review date scored (`hit`/`partial`/`miss`/`unclear`) with a lesson | |
| 12 | Quarterly: Calibration table updated per class, gap reported, `insufficient scored rows` where true | |
| 13 | Quarterly: repeating miss classes (3+) converted into a recorded rule change | |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

**Next:** `@biz-pipeline-diagnosis run` — deep-dive on the bottleneck you identified.

Close per the Operator handoff contract: Form A (`Next: nothing - work complete`) when nothing is needed; otherwise Form B with `**Needs your approval:**` and/or `**Needs your answer:**`, then exactly one `**Next step:**`. Omit empty sections.
