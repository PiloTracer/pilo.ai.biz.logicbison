---
name: biz-market-validate
description: >-
  Test offers, niches, and channels with low-cost experiments before
  committing substantial time or money. biz-market-validate test,
  biz-market-validate design, biz-market-validate status.
---

# biz-market-validate

**Purpose:** Kill bad ideas fast. Validate good ones with evidence — not gut feel.

---

## I0 — Design a validation experiment

### What to test

| Assumption type | Example question |
|-----------------|-----------------|
| **Niche** | "Do [niche] people actually pay for this?" |
| **Offer** | "Will [specific offer] get a yes?" |
| **Channel** | "Can I reach [niche] on [platform]?" |
| **Price** | "Will they pay $X?" |

### Experiment template

| Field | Value |
|-------|-------|
| Assumption | *Single clear statement* |
| Hypothesis | *If I do X, then I'll see Y* |
| Test method | *Which of the 3 types below* |
| Success criteria | *What result means "go"* |
| Signal grade | *A / B / C / D — how strong the evidence this test can actually produce is (CONVENTIONS § Evidence grades). Behaviour beats opinion: a paid invoice is A, a booked call is B, an enthusiastic "sounds great" is C at best* |
| Cost | *Time + money budget (aim: $0)* |
| Decision deadline | *Date* |

---

## I1 — Three low-cost test types

### Type A: Talk to 5 target buyers

1. Find 5 people who match your ideal client profile (LinkedIn, your network, communities).
2. Ask: *"What's the hardest part about [their problem]?"* — not "would you buy my thing?"
3. Listen for the exact words they use. If 3/5 describe the same pain, you have a market.
4. **Cost:** 2 hrs. **Go signal:** Consistent unsolicited pain language.

### Type B: Offer the service and measure response

1. Write one LinkedIn post offering to solve the problem for 2-3 people for free / reduced price.
2. Count: how many DMs? How many fit your criteria?
3. If you deliver, ask for testimonial + referral.
4. **Cost:** 4 hrs. **Go signal:** 5+ qualified inquiries.

### Type C: Content test on LinkedIn

1. Write 5 posts around the problem you think exists.
2. Track impressions, engagement (comments > likes for signal), and DMs.
3. Compare against your baseline content performance.
4. **Cost:** 2 hrs over 2 weeks. **Go signal:** Posts about this topic outperform average by 2x.

---

## I2 — Make the go / no-go decision

| Result | Decision |
|--------|----------|
| Clear go signal | Proceed to build offer / dedicate channel |
| Mixed signals | Refine assumption, run a 2nd experiment |
| No go signal | **Kill it.** Move to next idea. No sunk cost. |

**A go decision is a decision.** Proceeding to build an offer or commit to a channel is consequential, so it gets a row in `.work.biz/decisions/DECISIONS.md` (create from `templates/work/decisions/DECISIONS.md.template` if missing) per CONVENTIONS § Decision loop: the expected outcome with a number and a date, a confidence, a reversibility class (usually `one-way` once a channel is committed to), a kill/review trigger, and a review date. A kill needs no row — the absence of the thing is already its own record.

**Grade the result before you act on it.** State the grade the evidence actually reached, not the one the test was designed to reach: 3 polite conversations is grade C and does not license a build. If the observed signal is weaker than the design's `Signal grade`, the honest verdict is "run another test", not "go".

**Rule of thumb:** If you can't get 3 strangers to express interest in 5 hrs of work, the idea isn't validated. Treat that as a `directional` threshold, not a measurement — it is a floor for proceeding to a real test, not evidence of demand.

---

## I3 — Status

Read-only. Report where validation stands:

1. **Tests run:** each experiment, its test type (A/B/C), result, and go/no-go decision.
2. **Decisions pending:** assumptions designed but not yet tested, and tests awaiting their decision deadline.
3. **Records:** validation experiments and decisions live in `.work.biz/strategy/validation-log.md` (created on first use if missing); the log opens with a Status/Needs header, keeps Decisions and Open questions in separate lists, and ends with exactly one `## Next action` per the Document clarity contract. Go decisions are additionally recorded in `.work.biz/decisions/DECISIONS.md`; report any that are missing there, since an unrecorded go decision cannot be scored later.

Close the status report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` / `**Needs your answer:**` / exactly one `**Next step:**`).

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | Assumption clearly stated | |
| 2 | Experiment designed with success criteria | |
| 3 | Test executed (one of the 3 types) | |
| 4 | Results recorded and decision made | |
| 5 | Next step documented (go / refine / kill) | |
| 6 | Result graded (A–D); a go resting on grade-C/D signal was challenged | |
| 7 | Go decisions appended to `decisions/DECISIONS.md` with a falsifiable expected outcome | |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

**Next:** If validated → `@biz-strategy greenfield` or build your offer. If killed → test next assumption.
