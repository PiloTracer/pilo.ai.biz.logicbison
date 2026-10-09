---
name: biz-proposal
description: >-
  Write a proposal with clear deliverables, milestones, pricing, and scope
  protection. biz-proposal write, biz-proposal review, biz-proposal status.
---

# Skill: biz-proposal — Business Proposal Writing

## Purpose
Turn a discovery call into a written proposal that the buyer can say "yes" to. The proposal must be specific enough to inspire confidence, flexible enough to accommodate negotiation, and structured enough to prevent scope creep.

## Modes

### write — Full Proposal Writing Process
Write a full 5-section proposal from discovery call notes.

### review — Checklist-Based Review
Run the review checklist before sending a proposal.

### status — Proposal Pipeline Report
Report the current pipeline of sent/pending/closed proposals.

---

## I0 — Gate pre-check

Before `write` or `review` executes, read `{WORK_BUSINESS_ROOT}/gates.md`. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine and does not change the verdict.

- If the file does not exist, or `pipeline-ready` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): pipeline-ready not confirmed
  Required state: {WORK_BUSINESS_ROOT}/gates.md with pipeline-ready PASS
  Current state: <what was found>
  To proceed: run `@biz-pricing set`, fill .work.biz/pipeline/outreach-cadence.md
              and the pipeline tracker, then `@biz-review status`
```

A proposal without a settled price range invents a number under deadline pressure, which is how engagements get underpriced.

- Exception: `status` mode is read-only and runs without the gate.

---

## write — Proposal Writing Process

### 1. Gather What You Need

From the discovery call and your notes, extract:

- **The problem** (in their words, not yours)
- **The desired outcome** (measurable — "reconcile 10k transactions/day" not "better system")
- **Constraints** (budget range, timeline, tech preferences, team capabilities)
- **Decision criteria** (who decides, what matters most to them)
- **Competitive alternatives** (what happens if they don't hire you)

### 2. Write the 5-Section Proposal

Keep it to 2-3 pages max. Each section serves a specific purpose.

- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).
- The proposal document opens with a Status/Needs header (≤4 lines: what this is; **Status:** `Draft` | `In review` | `Approved` | `Superseded` + date; **Needs:** one line — the decision or review required, or `none`) and closes with exactly one `## Next action` section holding one action (or one line `Next action: none — <reason>` when nothing is needed).

#### Section 1: The Problem (Your Understanding)

"Based on our conversation, here's what I understand: [2-3 sentences summarizing their situation in their language]."

**Purpose:** Shows you listened. If they disagree with this section, the rest doesn't matter.

#### Section 2: The Approach (How You Solve It)

"The approach I recommend: [2-4 sentences on architecture, methodology, tech decisions]. This is the same approach I used for [similar project], which [outcome]."

**Do:** Name specific technologies, architecture patterns, and deliverables.
**Don't:** Over-explain. They're buying trust, not a technical spec.

#### Section 3: Scope of Work (Deliverables)

**3-column scope table:**

| Deliverable | What's Included | Acceptance Criteria |
|---|---|---|
| **Phase 1 — Foundation** | Setup, auth, database schema, CI/CD | Deployed staging environment, admin can log in |
| **Phase 2 — Core Feature** | Main business logic, API, frontend | Feature handles [specific scenario] |
| **Phase 3 — Delivery** | Testing, deployment, documentation, handoff | Production live, handoff call complete |

**Explicitly list what's NOT included (scope-creep shield):**

> **Out of scope:** Mobile apps, third-party integrations not listed, ongoing maintenance beyond 30-day warranty, content creation, SEO, branding/design beyond standard UI.

When they ask for extras later, you point here.

#### Section 4: Investment

**Pricing options table:**

| Option | Scope | Price | Timeline |
|---|---|---|---|
| **Full build** (recommended) | All 3 phases | $XX,000 | X weeks |
| **Phase 1 only** | Foundation + core feature | $XX,000 | X weeks |
| **Custom** | As discussed | TBD | TBD |

**Format:** Fixed price per phase. "50% upfront, 25% at milestone 1, 25% at delivery."
**Never list an hourly rate.** Your proposal is for outcomes, not time.

#### Section 5: Next Steps

- Sign the proposal (accept the terms)
- Pay the deposit (50% via Wise/Stripe)
- Kickoff call (schedule within 1 week)
- First milestone delivery (X weeks from kickoff)

**Include a 7-day expiration** on the proposal. Creates gentle urgency and keeps you from chasing stale deals.

### 3. Pricing Guidance

Binding pricing rules live in `standards/20260621-PRICING-STANDARD.md` (fixed price only; 50% upfront before work begins; never discount — reduce scope instead; Wire/Wise preferred, +3% for credit card). Apply per proposal:

- **For a clear-scope project:** Fixed price for the full engagement
- **For a fuzzy-scope project:** Fixed price for Phase 1 only; Phase 2-3 priced after Phase 1 completes
- **If they want a discount:** Never discount (standard). Offer Phase 1 only at a lower price point

---

## review — Checklist Before Sending

- [ ] Does it reference specific things they said in the discovery call?
- [ ] Is the problem statement in their language, not yours?
- [ ] Are out-of-scope items explicitly listed?
- [ ] Is the price clearly stated, with payment terms?
- [ ] Is there an expiration date?
- [ ] Is there a clear next step?

---

## status — Proposal Pipeline Report

| Field | Value |
|---|---|
| Proposals this month | Count |
| Sent | Count |
| In review | Count |
| Closed-won | Count |
| Closed-lost | Count |
| Total pipeline value | $ |
| Stale (no response >10 days) | Count |
| Open decision rows | Count, and any past their review date (`decisions/DECISIONS.md`) |

**A count of losses is not a diagnosis.** Every closed-lost row needs a **loss reason** recorded on its decision row: `price` · `scope` · `timing` · `trust/fit` · `no decision` · `went in-house`. "5+ proposals with zero closes" cannot separate a pricing problem from a qualification or proposal problem until the reasons are written down, and the three prescribe opposite fixes. When three losses share a reason, that is the class to act on (CONVENTIONS § Decision loop).

Close per the Operator handoff contract: Form A single line (`Next: nothing - work complete`) when nothing is needed; otherwise Form B — `**Needs your approval:**` with `path:L<n>` cites and/or `**Needs your answer:**`, then exactly one `**Next step:**`. Omit empty sections.

---

## Ongoing Maintenance — What to Offer After Delivery

Offer guidance is canonical in `skills/biz-pricing/skill.md` § Post-Delivery Offers (warranty, monthly/on-call retainers, ad-hoc support). Default offer: a 30-day free warranty, then a monthly retainer if they want ongoing support.

---

## No-Go Criteria — When to Say NO

**Do not take the project if:**
- The client can't clearly describe the problem (they're "exploring" — not ready)
- The budget is less than 50% of your effort-based floor
- They refuse 50% upfront payment
- The timeline is unrealistic and they won't negotiate
- They want to own all IP but pay less than full price
- Your gut says no

**Saying no gracefully:**
> "Based on what I'm hearing, I don't think I'm the right fit for this project. Here's what I'd suggest instead: [alternative approach or referral]. If things change, feel free to reach out."

---

## Contract Review — What to Watch for in Client Contracts

If the client wants to use their contract instead of yours:

1. **Read every clause.** Don't assume it's standard. Pay special attention to:
   - Indemnification (are you liable for their business losses?)
   - IP assignment (when do they own your work? Only after payment?)
   - Termination for convenience (can they fire you with 1 day notice?)
   - Payment terms (net 90 is not acceptable)
2. **Redline and negotiate.** You can change contract terms — they're not set in stone.
3. **Protect your liability:** Never accept unlimited liability. Cap it at the contract value.
4. **If in doubt:** Get a lawyer review. One hour of legal time can save you months of pain.

---

## Non-Negotiables (in any contract)

- 50% upfront (no exceptions)
- Milestone-based payments (not monthly)
- Scope of work is fixed (changes = change order)
- Liability cap = contract value
- IP transfers only after full payment

---

## Time Budget

| Step | Time | Notes |
|---|---|---|
| Gather info from discovery call | Already done | Should have notes ready |
| Write Section 1: Problem | 10 min | In their words |
| Write Section 2: Approach | 10 min | Architecture + methodology |
| Write Section 3: Scope | 20 min | Deliverables + out-of-scope list |
| Write Section 4: Investment | 10 min | Options + payment terms |
| Write Section 5: Next Steps | 5 min | Expiration + timeline |
| Review before sending | 10 min | Checklist above |
| **Total per proposal** | **1-1.5 hrs** | Can be done in one sitting |

---

## Failure Modes

If proposals go out but never close:

1. **The problem statement is wrong.** If they don't immediately agree with Section 1, the rest doesn't matter. Check: are you using THEIR words or YOUR words?
2. **The price is too high for the perceived value.** You may be pricing off effort instead of value. Price off value, not hours.
3. **The risk is too high.** They're afraid to commit. Offer a smaller Phase 1 (lower commitment, same quality).
4. **Your proposal is too long.** 3 pages max. If it's longer, they won't read it. Cut half.
5. **You didn't address the real objection.** Ask "is there anything in the proposal that didn't make sense or felt off?"
6. **The follow-up is wrong.** Don't ask "did you have a chance to review?" Ask "is there anything that didn't make sense?"
7. **You're sending proposals to unqualified prospects.** If you've sent 5+ proposals with zero closes, read the **loss reasons** on the decision rows before changing anything: a majority of `price` means the pitch or the segment, a majority of `scope`/`trust` means pre-proposal qualification is the problem, and `no decision` means follow-up is. One count, three different fixes.

---

## Success Criteria

A proposal is ready to send when:
- The problem statement matches what the client told you (they'll feel heard)
- Out-of-scope items are explicitly listed (this is your scope-creep shield)
- The price is between your effort-based floor × 1.3 and value-based ceiling × 0.3
- There's a 7-day expiration date
- Every proof claim (case study, "we did this before", a metric) traces to a real entry in `reference/PROJECTS.md` with a number. A claim you cannot source is grade D — cut it or de-claim it; a proposal that oversells is a delivery problem with a signature on it
- You'd say yes if you received this proposal

**On send, append a decision row.** A sent proposal is a prediction with a price on it: one row in `.work/biz/decisions/DECISIONS.md` (create from `templates/work/decisions/DECISIONS.md.template` if missing) carrying the quoted number, the expected outcome ("signed by <date>" or "closed-won at $X by <date>"), a confidence %, a reversibility class (`two-way` until it is signed, `one-way` after), a kill/review trigger (when to stop chasing), and a review date. When it resolves, the `Outcome` and the **loss reason** are what make the next proposal better — see the `status` section above.

---

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
