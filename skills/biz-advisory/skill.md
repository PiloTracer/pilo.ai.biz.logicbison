---
name: biz-advisory
description: >-
  Situational business counsel for messy, high-stakes "what should I do?"
  questions: career-to-business transitions, team pivots (e.g. a laid-off team
  considering going independent together), offer reframes, stalled ventures,
  hard either/or decisions. Produces advisor-grade output — asset inventory,
  mandatory reframe pass, ranked options with concrete positioning, market
  precedent evidence, anti-advice (what NOT to do), sequencing tracks, and one
  decisive recommendation. biz-advisory advise, biz-advisory patterns,
  biz-advisory status.
---

# biz-advisory

**Canonical path:** `.ai.biz/skills/biz-advisory/skill.md`

Answer **"here is my situation — what should I do?"** at the level a world-class advisor would: not a generic list of options, but a reframed reading of the situation, ranked concrete approaches with real positioning language, honest anti-advice, and a decisive recommendation with a 30-day next step.

The bar this skill holds (calibration example — a laid-off architect + QA + junior dev asking whether to job-hunt separately): the weak answer is "here are job boards and freelance sites." The advisor-grade answer reframes three CVs as a **pre-existing delivery unit**, ranks approaches (product-rescue team, fractional squad for companies that can't afford three hires, fixed-price 30-day stabilization as the entry offer, AI-codebase rescue, agency overflow partnerships, former employer as first channel), says what NOT to do (no LLC, logo, or website before customers), sequences two parallel tracks (individual employment + team venture), and ends with a decisive "what I would actually do." Anything below that bar is a failure of this skill.

This skill is **model-agnostic**: it enforces project-context loading, a mandatory reframe pass, evidence-first reasoning, an assumption ledger, and a completion gate, so output quality holds across any LLM.

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-advisory - <situation>` | Full advisory pass on the described situation. |
| `@biz-advisory advise - <situation>` | Same as above (explicit verb). |
| `@biz-advisory patterns` | List the advisory pattern library (`concepts/advisory-patterns/`, BIZ-10) with when-each-applies. |
| `@biz-advisory patterns - <pattern name>` | Apply one pattern to the operator's current situation. |
| `@biz-advisory status` | Read-only: report loaded context and advisory readiness. |

**Default:** `advise`. A free-text request like "we just lost our jobs, should we freelance or team up?" is treated as `advise - <that text>`.

**Routing boundary:** `biz-advisory` answers *what should I do in this situation*. It does not replace `biz-ideas` (generate venture concepts from a domain), `biz-strategy` (formalize the chosen direction into certified strategy), or `biz-review` (periodic health check). When the advice converges on a direction, hand off to those.

---

## I0 — Project Context Contract (run before advising)

Advice must fit the real operator, not a hypothetical one. Load in **priority order**; stop when you have enough.

### Priority 1 — Operator profile & constraints (host project memory)

| File | What it gives you |
|------|-------------------|
| `.work.biz/strategy/one-pager.md` | Active niche, offer, buyer, channel, price range — advice must build on or deliberately break from it |
| `.work.biz/strategy/assumption-ledger.md` | What's confirmed vs inferred vs unknown — reuse confirmed facts, don't re-litigate them |
| `.work.biz/reference/OPERATOR_PROFILE.md` | Skills, proof points, constraints, risk tolerance, career stage |
| `.work.biz/context/HANDOFF.md` | Recent direction; don't advise against it without saying so explicitly |
| `.work.biz/plans/UNKNOWNS.md` | Open unknowns and blocked decisions |
| `.work.biz/decisions/DECISIONS.md` | What was already decided and what it was expected to produce — never contradict a live decision without saying so explicitly |
| `.work.biz/pipeline/pipeline_tracker.md` | Real commercial evidence — where the operator already wins |

### Priority 2 — Project identity

Read the project root `.cursorrules` / `AGENTS.md`. Resolve `REPLACE:` tokens: `PROJECT_NAME`, `UNIFIED_OFFER`, `TARGET_BUYER`, `PRICE_RANGE`.

### Priority 3 — Capability fingerprint (mandatory)

Establish what the operator (and any team named in the situation) can actually deliver: stack manifests, `README.md`, portfolio/case-study folders, stated work history. Advice that requires capabilities nobody has is not advice — it's fiction.

### Priority 4 — Standards

Read `standards/*BUSINESS-CONVENTIONS*` and `standards/*PRICING-STANDARD*` if present (binding — e.g. fixed-price, milestone-gated, no hourly).

### Context summary (emit before advising)

```
LOADED CONTEXT
  Operator:     <solo / team — composition, or "unspecified">
  Situation:    <one line — the decision at stake>
  Assets:       <confirmed assets incl. underpriced ones>
  Constraints:  <runway / time / obligations — or "unspecified">
  Active strategy: <one line or "none">
  Live decisions:  <open ledger rows this advice must respect, or "none">
  Gaps:         <what would materially change the advice>
```

Ask **one** consolidated question only if an unknown would materially change the advice (e.g. runway length, contractual restrictions with a former employer). Otherwise proceed and grade the gap in the assumption ledger.

---

## I1 — `advise` mode

Run all eight steps in order (step 4b is part of the evidence pass, step 8 closes with the decision record). Skipping the reframe pass (step 2), the anti-advice (step 6), or the decision record (step 8) is the most common way this skill degrades — the first two into generic listicle output, the last into advice nobody can ever score.

### Step 1 — Frame the situation

State in ≤3 lines: the decision at stake, who is involved, the real constraint (usually runway, not ideas), and the cost of a wrong call. If the stated question is the wrong question ("which job board?" when the real question is "employment vs independent team?"), say so and answer both.

### Step 2 — Asset inventory + reframe pass (mandatory)

List every asset, including the ones the operator is underpricing:

- **Capabilities** — skills, stack, domain proof.
- **Relational assets** — former employer, ex-colleagues, vendors, clients, community presence. A shared work history is a *channel*, not just a memory.
- **Structural assets** — an existing team that already knows how to work together, an audience, a pipeline, a reputation.
- **Tooling leverage** — e.g. AI fluency, positioned as a *control layer* (judgment + QA over AI acceleration), never as "we know tool X".

Then attempt **at least 2 reframes** using the pattern library (`concepts/advisory-patterns/`, BIZ-10). The canonical reframe moves: individuals → delivery unit · skill → productized outcome · history → first sales channel · competitor → complementor channel (agencies as overflow) · tool fluency → governed acceleration. State each reframe as **"don't sell X — sell Y"** with the actual sentence the operator could use.

### Step 3 — Option generation

Produce **≥5 genuinely distinct approaches**, ordered most → least promising. Distinct means different buyers, different offers, or different channels — not five wordings of one idea. For each:

```
### N. <Approach name>

**Positioning:** <the sentence to say — concrete, outcome-first>
**Target buyer:** <specific role + company type + situation trigger>
**Why it fits:** <trace to the confirmed assets, not hopes>
**Base rate:** <what normally happens to operators attempting this shape — graded, or marked directional>
**Math:** <does it close? price × volume vs the income target before runway ends; prospects/week vs channel capacity>
**Evidence:** <market precedent or demand signal — researched with an A–D grade, or marked Unverified>
**First step:** <the smallest action that tests it this week>
```

### Step 4 — Evidence pass

Every non-trivial market claim (demand exists, price ranges, "companies buy this") needs a citation from web research (competitor/marketplace pages, pricing pages, job-market signals) or an explicit **Unverified** mark, **and** an evidence grade from `CONVENTIONS.md` § Evidence grades: `A` first-party/primary (the operator's own pipeline, call notes, publish results) · `B` named third-party research with a stated method · `C` vendor/consultancy/media claim or single anecdote · `D` model memory or undated. Grade-C claims need an independent second source before they carry a recommendation; grade-D claims may never carry one alone.

Precedent matters: advice is stronger when it can say "this purchasing model already exists — here are firms selling it." Precedent also needs a date, because a 2023 marketplace page is not evidence about 2026 pricing.

### Step 4b — Outside view (base rate)

Before ranking, name the reference class: operators in roughly this position attempting roughly this shape of move. State what normally happens to them — time to first revenue, share that never get paid, typical overrun against plan — with a grade, or explicitly marked `directional` when you can only reason about it. Then check the recommendation against it. A recommendation that requires beating the base rate is acceptable, but only with a stated reason: an unusual asset, a warm channel, an existing buyer relationship. "This time will be different" is not a reason.

### Step 5 — Rank + decide

Rank the options by: speed to first revenue · fit with confirmed assets · buyer accessibility · defensibility. Then commit: **"What I would actually do"** — one primary direction, stated in ≤5 lines with the reasoning. Hedged "it depends" endings are a failure. If two tracks should run in parallel (e.g. income hedge + venture), say which is primary and why.

State the decision's **reversibility** (one-way or two-way). A two-way door warrants speed; a one-way door warrants the evidence pass and the base rate before committing. Then state a **confidence** percentage — the number you would bet — because that is what makes the recommendation scoreable later.

**Does the math close?** For the primary direction, show the arithmetic: price × realistic volume against the income target, and required prospects per week against the channel capacity the operator actually has. If it does not close, say so plainly and name the constraint that fails — a recommendation that cannot pay before runway ends is not a recommendation, it is a hope with a plan attached.

### Step 6 — Anti-advice (mandatory)

A short **"Do NOT"** list: the tempting moves that waste the next month — premature incorporation, logo/website polish before customers, offering 25 services instead of 3, selling people instead of outcomes, waiting for the perfect plan. Name the ones this specific operator is most likely to fall for.

### Step 7 — Sequencing

What happens in what order, and what runs in parallel. End with a concrete **30-day frame**: week-by-week actions across positioning, first-50-prospect outreach, entry-offer pricing, and (for teams) who sells. Offer to expand it into a full plan via `biz-strategy` / `biz-proposal` as applicable.

### Step 8 — Assumption ledger, risks, and the decision record

Grade load-bearing assumptions Confirmed / Inferred / Unknown, and mark the largest `If wrong` blast radius. List residual risks and the cheapest test for the riskiest one.

Then **record the recommendation as a decision** — a `pending` row would be worse than useless, so this is the last thing you do, not an optional extra. Append one row to `.work.biz/decisions/DECISIONS.md` (create it from `templates/work/decisions/DECISIONS.md.template` if missing — self-heal, never skip the record):

| Field | What goes in it |
|-------|-----------------|
| Decision | the primary direction, one line |
| Options considered | the ranked alternatives |
| Rationale | why this one, traced to a confirmed asset or a graded evidence row |
| Expected outcome | falsifiable — a number and a date, or an observable event |
| Confidence | the percentage stated in Step 5 |
| Reversibility | one-way / two-way |
| Kill / review trigger | the evidence that would prove it wrong, and the action then |
| Review by | when the expected outcome should be visible |

Do not decide the trigger after the fact. The whole value of writing it now is that it cannot be quietly relaxed later.

### Output framing

Frame the deliverable per the Document clarity contract: Status/Needs header (`Status: Draft — <date>`; one-line Needs), Decisions and Open questions as separate numbered lists (never mixed), exactly one `## Next action` section, no leftover scaffolding.

---

## I2 — `patterns` mode

Read `concepts/advisory-patterns/prompt.md` (BIZ-10). Bare `patterns`: list every pattern with its when-to-apply trigger. `patterns - <name>`: apply that one pattern to the operator's loaded context — the reframe sentence, the concrete offer it implies, the first step, and the evidence to gather.

---

## I3 — `status` mode (read-only)

Report: operator/team profile as loaded, active strategy presence, pipeline evidence availability, and which context gaps would most improve advice quality. Close per the Operator handoff contract (Form A when nothing is needed; Form B otherwise).

---

## Quality check before delivering (run internally)

- [ ] Did I reframe at least twice, with usable "don't sell X — sell Y" sentences?
- [ ] ≥5 distinct approaches, ranked, each traced to confirmed assets?
- [ ] Every market claim cited from research **and graded A–D**, or marked Unverified?
- [ ] Did I name the reference class and what normally happens to it — before ranking?
- [ ] Does the primary direction's arithmetic close (price × volume vs target, prospects/week vs channel capacity)?
- [ ] A decisive "what I would actually do" — no hedging mush — with a confidence % and a reversibility class?
- [ ] Anti-advice section present and specific to this operator?
- [ ] Sequencing + parallel tracks where risk demands hedging?
- [ ] Assumption ledger graded; cheapest test named for the riskiest unknown?
- [ ] Decision row appended to `decisions/DECISIONS.md` with a falsifiable expected outcome and a review date?
- [ ] Exactly one concrete next action?
- [ ] Does the whole answer clear the calibration bar in the header (team-rescue example)?

If any box is unchecked, fix it before delivering.

---

## Completion gate (cannot be skipped)

You may only claim the task complete when all are true:
1. Context loaded per I0 (including open ledger rows) and the summary emitted.
2. Reframe pass, ≥5 ranked options, evidence pass with grades, outside view, anti-advice, sequencing, and assumption ledger all delivered.
3. The primary direction's arithmetic is shown and closes — or the failing constraint is named plainly.
4. One decisive recommendation with reasoning, a confidence percentage, and a reversibility class.
5. A concrete 30-day next step proposed.
6. The decision row is appended to `.work.biz/decisions/DECISIONS.md` with a falsifiable expected outcome, a kill/review trigger, and a review date (CONVENTIONS § Decision loop).
7. Handoff offered to the right follow-on skill (`biz-strategy`, `biz-market-validate`, `biz-proposal`) when the advice converges.

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

---

## Time budget

| Mode | Time |
|------|------|
| `advise` | 35–75 min (incl. evidence pass, outside view, arithmetic) |
| `patterns` | 5–15 min |
| `status` | < 2 min |

---

## Gates & dependencies

No hard prerequisite gate. Runs any time, including before `biz-bootstrap init`. Output improves sharply when the host project is strategy-certified, because assets, constraints, and proof points load from project memory rather than from the user's message alone.

Feeds naturally into:
- `@biz-strategy greenfield` / `amend` — formalize the recommended direction.
- `@biz-market-validate test` — cheaply test the riskiest assumption.
- `@biz-ideas generate` — when the advice is "explore a different space entirely."
- `@biz-proposal write` — when the advice converges on a productized entry offer.

---

## Related skills

| Skill | When |
|-------|------|
| `@biz-ideas` | Generate venture concepts from a domain, not a situation |
| `@biz-strategy` | Formalize and certify the chosen direction |
| `@biz-market-validate` | Test the top option before committing |
| `@biz-sources` | Curate the advisory sources that keep this skill's evidence base current |
| `@biz-review quarterly` | Scores the decision rows this skill writes — the loop that turns advice into calibration |
