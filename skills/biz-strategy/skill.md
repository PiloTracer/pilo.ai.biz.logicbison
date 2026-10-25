---
name: biz-strategy
description: >-
  Define your niche, unified offer, target buyer, and channel strategy, and
  profile the operator behind them. Produces strategy docs that guide all other
  business development. `design` generates and scores three or more candidate
  plays before one is committed (upstream of greenfield); `greenfield` writes the
  8 elements of the chosen one; `certify` promotes the strategy-ready gate.
  biz-strategy design, biz-strategy greenfield, biz-strategy probe,
  biz-strategy career, biz-strategy amend, biz-strategy reconcile,
  biz-strategy certify, biz-strategy status.
---

# biz-strategy

**Canonical path:** `.ai.biz/skills/biz-strategy/skill.md`

Define your niche, unified offer, target buyer, channel plan, and pricing range. This is the foundational Business OS skill — every other skill depends on the strategy docs this skill produces. Run before anything else.

**Design before you commit.** `greenfield` tests ONE idea; if the operator's first idea is weak, the whole strategy inherits the weakness and certification only measures internal consistency. `design` (I1b) generates five or more plays, scores them on graded evidence, kills the weak ones, and writes the pre-mortem before anything is launched. Run it first whenever more than one direction is plausible — the playbook is `concepts/strategy-design/prompt.md`.

**Why specialize (directional, not measured):** specialists generally command higher rates than generalists, convert better against a narrow buyer, and a single offer reduces choice overload (Hick's Law). Treat these as the *rationale* for the skill, not as citable figures: the framework has no sourced study behind them, so do not repeat percentages to the user as fact. When a project needs real numbers for its own niche, gather them with `@biz-market-validate test` and record them in `.work.biz/strategy/assumption-ledger.md` with citations.

---

## Core Frameworks

### One Block Method (5 Elements)

| Element | Question | Clarification |
|---------|----------|---------------|
| **One Person** | Who is the target buyer? | A specific person with a title, context, and pain. Not a demographic. |
| **One Problem** | What is the real problem? | The root cause, not the symptom. What keeps them up at night. |
| **One Offer** | What is the unified service? | One service that bundles expertise, guidance, and execution. Not a menu. |
| **One Channel** | Where do they look for help? | Primary channel to reach them. Not every possible channel. |
| **Price range** | What do they expect to pay? | Value-aligned range. Not hourly. Not too wide. |

The 5 elements must be internally consistent — each constrains the others. A $80k platform buyer does not discover you on TikTok. A local service business owner does not pay $20k for a landing page.

### Assumption Ledger

Every strategy decision rests on a mix of:

| Category | Meaning | Action |
|----------|---------|--------|
| **Confirmed** | Direct evidence exists | Document the evidence. Use as foundation. |
| **Inferred** | Reasonable but unverified | Flag for probe mode. Test before certifying. |
| **Unknown** | No evidence either way | Gap to fill. May block certification. |

Every row is graded twice more, because "how sure are we" is not the same question as "how much does it matter":

| Field | Question | Why it exists |
|-------|----------|---------------|
| **Load-bearing** | Does this anchor the buyer, the problem, the offer, the primary channel, or the price? | A load-bearing Unknown is disqualifying however few there are; a peripheral Unknown is tolerable. Counting unknowns weights a trivial gap and an existential one equally. |
| **If wrong** | What breaks if this is false? | The sensitivity pass. The row with the largest blast radius is the one to test first, however confident it feels. |
| **Evidence grade** | `A` / `B` / `C` / `D` per `CONVENTIONS.md` § Evidence grades | A citation is not a source quality. A grade-C claim cannot be the foundation of a certified strategy. |

Rule of thumb: run `@biz-strategy probe` before certifying whenever a **load-bearing** assumption is Unknown, or rests on grade-C/D evidence. A peripheral unknown count above 30% is a smell, not a blocker.

### Geography (Where You Operate)

| Scope | Implication |
|-------|-------------|
| Local | Same-city only. High trust. Limited deal size. |
| Regional | Multi-city within country. Moderate trust. Moderate scale. |
| Global (remote) | Anywhere. English-working. Timezone-flexible. Lowest trust overhead but highest competition. |

Choice constrains channel, price, and offer structure.

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-strategy design` | Generate and score candidate plays, pick one, write the pre-mortem and the bets. Upstream of greenfield; writes `strategy/situation-audit.md` + `strategy/design-record.md`. Aliases: `options`, `blueprint`. |
| `@biz-strategy design - <situation>` | Same, seeded with the operator's situation text. |
| `@biz-strategy greenfield` | Generate full strategy from scratch. Walk through all 8 elements. |
| `@biz-strategy greenfield - from <file>` | Generate strategy using an existing document as seed. |
| `@biz-strategy probe` | Adaptive gap-filling questioning. Targets unknown/inferred assumptions. |
| `@biz-strategy probe - <element>` | Probe a specific element (person, problem, offer, channel, price, geography). |
| `@biz-strategy career` | Probe the operator (skills, proof points, constraints, risk, career stage); fill `reference/OPERATOR_PROFILE.md`; produce a career-direction read. Runs before or after certification. |
| `@biz-strategy career - <block>` | Probe one profile block only (skills, proof, constraints, risk, stage, direction). |
| `@biz-strategy amend - <what changed>` | Record a strategy change made outside greenfield, fold out-of-tree strategy docs back in, and flag dependent artifacts stale. Requires re-certify afterward. |
| `@biz-strategy reconcile - <what is inconsistent>` | Make a canonical file carry a decision the certified record **already** asserts. Changes no positioning, so it moves no gate and needs no re-certification. Strictly bounded — see I2c. |
| `@biz-strategy certify` | Deep consistency check. Promotes strategy-ready gate on pass. |
| `@biz-strategy certify - why` | Explain why current strategy would fail certification (without attempting it). |
| `@biz-strategy status` | Read-only state report. What's defined, what's missing, gate status. |

**Default:** `status` if no verb matches.

---

## Work tree

All strategy files live under `{WORK_BUSINESS_ROOT}` (`.work.biz/`):

| File | Purpose |
|------|---------|
| `strategy/one-pager.md` | Single-page summary of all 6 elements |
| `strategy/assumption-ledger.md` | Full assumption ledger with evidence |
| `strategy/offer-scope.md` | Detailed offer definition, what it IS and IS NOT |
| `strategy/target-buyer-profile.md` | Detailed buyer persona |
| `strategy/channel-plan.md` | Primary channel + supporting channels |
| `strategy/pricing.md` | Distilled price range from the Price element |
| `strategy/situation-audit.md` | Design mode: six graded lenses (assets, demand, constraints, traction, timing, identity) |
| `strategy/design-record.md` | Design mode: plays, pre-set weights, scores with grades, ranking, sensitivity, WWHTBT, pre-mortem, moat, breakeven worksheet, rejected plays with re-entry conditions |
| `strategy/certification.md` | Gate certification record (certify mode writes here) |
| `strategy/changelog.md` | Append-only record of strategy changes (amend mode writes here; reconcile mode appends entries marked **(correction)**) |
| `decisions/DECISIONS.md` | Decision ledger — outside `strategy/` on purpose, because it records judgment rather than positioning. `certify` appends the certified strategy as a decision; `amend` appends the superseding row (CONVENTIONS § Decision loop) |

- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

Every file this skill writes (the strategy docs above, `strategy/certification.md`, `strategy/changelog.md`, `reference/OPERATOR_PROFILE.md`) opens with the ≤4-line Status/Needs header (What / Status + date / Needs) and closes with exactly one `## Next action` section (or one line `Next action: none — <reason>`).

---

## I0 — Pre-checks

| Condition | Action |
|-----------|--------|
| `{WORK_BUSINESS_ROOT}` does not exist | **Block**: "Run `@biz-bootstrap init` first to scaffold the work tree." |
| Strategy files exist and mode is `greenfield` | Warn: "Strategy already exists at `{WORK_BUSINESS_ROOT}/strategy/`. Run `@biz-strategy probe` to refine, or overwrite with `greenfield - force`." |
| Mode is `certify` and no strategy files exist | **Block**: "No strategy defined. Run `@biz-strategy greenfield` first." |

---

## I1 — Greenfield mode

Walk through all 8 elements in sequence. Each produces a section for `strategy/one-pager.md`. After each element, summarize the choice before proceeding.

**Operator profile first:** if `{WORK_BUSINESS_ROOT}/reference/OPERATOR_PROFILE.md` exists, read it before starting; it constrains the offer (what the operator can deliver), the channel (available hours), and the price (runway floor). If it does not exist, offer `@biz-strategy career` before Element 1 and proceed either way: greenfield works without it, but every element is sharper with it.

### Element 1: One Person (Target Buyer)

Walk the user through:

1. **Job title / role** — Who writes the check? (Not the user, the buyer.)
2. **Company context** — Stage (seed, growth, enterprise), size (revenue, headcount), industry.
3. **What they already tried** — Before coming to you. What alternatives have they explored?
4. **What they value most** — Speed? Quality? Trust? Cost? Expertise?
5. **What they fear most** — What goes wrong if they pick the wrong person?

**Audience hierarchy (required):** One primary buyer is not always the whole picture. Record three tiers:
1. **Primary buyer** - singular; the sharpness test below applies to this tier.
2. **Secondary buyer** - served by the same offer, lower priority (e.g. non-technical founders when the primary is ops leaders).
3. **Opportunistic audiences** - never targeted, but the door stays open (e.g. employers/recruiters for a solo operator open to a great job).
Then answer the fork question: "Given these audiences, what must your static profile (headline, About, website hero) never say?" Example: slot-scarcity ("I take 2 clients") closes the employment door - keep it out of permanent fields; time-boxed posts only.
Include the hierarchy and the fork answer in `strategy/target-buyer-profile.md`.

**Output:** Write `strategy/target-buyer-profile.md` with the detailed persona.

**Sharpness test:** Can you name 3 real people who fit this description? If not, the persona is too vague.

### Element 2: One Problem (The Real Problem)

Walk through:

1. **Surface request** — What they say they want ("I need a website").
2. **Real problem** — What they actually need ("I need leads before I run out of runway").
3. **Why current solutions fail** — Consultants advise but don't ship. Freelancers ship but don't think. Agencies are expensive and slow.
4. **Cost of inaction** — What happens if they don't solve this in 90 days?

**Output:** Append to `strategy/one-pager.md`.

**Sharpness test:** If the problem can be stated in under 14 words, it's sharp enough. "I need someone who can design and build my platform, not just one or the other."

### Element 3: One Offer (The Unified Service)

Walk through:

1. **The headline** — One sentence that packages strategy + architecture + delivery.
2. **What it IS** — Specific deliverables, outcomes, process.
3. **What it is NOT** — Explicitly list the adjacent offers you are NOT selling (critical for focus).
4. **Proof** — What existing work demonstrates you can deliver this.

**Output:** Write `strategy/offer-scope.md`.

**Format example:**

| What this IS | What this is NOT |
|--------------|------------------|
| Custom platform development (strategy + build) | Fractional CTO (consulting-only) |
| Fixed-price, milestone-gated | Hourly billing or retainer |
| End-to-end delivery | Code review of someone else's work |
| Single point of contact | Team management layer |

**Sharpness test:** Can a stranger read the headline and know within 5 seconds whether they're the right buyer? If they say "wait, do you also do X?", the offer is fuzzy.

### Element 4: One Channel (Primary Channel)

Walk through:

1. **Where the buyer looks** — When they need this problem solved, where do they start?
2. **Where the buyer trusts** — Which platform/community has their attention and trust?
3. **Your existing footprint** — Where do you already have presence, network, or content?
4. **Channel fit** — Does the channel support the price range? (LinkedIn for $20k+ B2B. Referrals for high-trust. Cold email for low-ticket. YouTube for broad awareness.)

**Output:** Write `strategy/channel-plan.md`.

**Channel fit criteria:**

| Channel | Minimum production capacity required |
|---------|--------------------------------------|
| LinkedIn | 3–4 posts/week, 10–15 min/day engagement |
| Communities | 10+ meaningful comments/week across 2–3 communities |
| Content marketing (blog/newsletter) | 1 long-form piece/week or 1 newsletter/week |
| Cold outreach | 20–50 personalized touches/day with follow-up system |
| **YouTube (as primary channel)** | **1 long-form video/week OR 4–7 Shorts/week; thumbnail/title system; 6-month commitment** |

If the operator cannot meet the minimum production capacity for a channel, that channel is not a viable **primary** channel. It can still be a secondary or experiment channel at a lower cadence (see `@biz-youtube plan` for capacity-appropriate schedules).

**Channel credibility (source: validated research):**

| Channel | Best for | Trust path | Notes |
|---------|----------|------------|-------|
| LinkedIn + warm referrals | High-ticket B2B ($20k+) | Warm introduction → case study → call | Fastest trust path for high-ticket services |
| Community engagement | Mid-ticket expertise plays | Helpful answers → profile → DM | Requires consistent presence |
| Content marketing | Inbound positioning | Post → profile view → website → call | Blog + newsletter play |
| Cold outreach | Volume plays under $5k | Message → call (low conversion) | Low trust, high volume |
| YouTube / podcast | Long-term brand building + search discovery | Video → subscribe → deeper video → lead → call | YouTube is the second-largest search engine (~2.5–2.7B MAU); 68% of B2B buyers watch long-form video before purchasing ([Digital Applied 2026](https://www.digitalapplied.com/blog/video-marketing-statistics-2026-data-points)) |

**Rule:** Pick ONE primary channel. Everything else is secondary. Split channel focus kills momentum.

**YouTube as primary channel:** Only choose YouTube as primary if the operator can sustain 1 long-form video/week or 4–7 Shorts/week for at least 6 months. YouTube rewards consistency and multi-format creators (long-form + Shorts + Community Tab). The typical B2B trust path is: viewer → subscriber → lead magnet → email nurture → call. Expect 6–18 months before meaningful inbound. If capacity is lower, make YouTube secondary and run `@biz-youtube plan` for a sustainable cadence.

### Element 5: Price Range

Walk through:

1. **Value-based floor** — What is the problem costing the buyer per month/quarter? Your price should be a fraction of that.
2. **Effort-based ceiling** — At your minimum viable rate ($X/hr), what does the effort cost? That's your floor, not your price.
3. **Market alternatives** — What would an agency charge? A freelancer? A hire?
4. **Research benchmarks:** For custom platform development, solo operators charge $20k-$80k per engagement. Senior developer hourly: $100-$180/hr. SaaS MVP: $25k-$80k. Enterprise web apps: $50k-$250k+.
5. **Range shape** — Fixed-price, milestone-gated. 50% upfront standard.

**Output:** Append price range to `strategy/one-pager.md` and write the distilled price range to `strategy/pricing.md`.

**Rule:** Price range should be a 2-4x spread, not 10x. "$20k-$80k" is good. "$5k-$200k" means you don't know who you serve.

### Element 6: Geography

Walk through:

1. **Where can you legally work?** — Visa, tax, entity constraints.
2. **Where does your buyer expect you to be?** — Local buyers may require local presence. Global buyers may not care.
3. **Timezone compatibility** — 4+ hour overlap minimum for synchronous work.
4. **Language** — Primary business language of engagement.

**Output:** Append geography to `strategy/one-pager.md`.

**Common defaults:**
- Technical solo operators: Global (remote), English-working
- Local service agencies: Same metro area
- Niche consulting: Regional or same-country

---

### Element 7: Assumption Ledger (Build)

After the first 6 elements are drafted, build the assumption ledger:

1. For each element, list every factual claim underpinning the decision.
2. Grade each: **Confirmed** (direct evidence), **Inferred** (reasonable but not verified), **Unknown** (no evidence).
3. Mark each **load-bearing** (yes/no): does it anchor the buyer, the problem, the offer, the primary channel, or the price?
4. Record **If wrong** — what breaks if the claim is false. This is the sensitivity ranking: test the largest blast radius first.
5. Grade the **evidence**: `A`/`B`/`C`/`D` per `CONVENTIONS.md` § Evidence grades.
6. Write to `strategy/assumption-ledger.md`.

**Ledger format:**

```markdown
| Category | Assumption | Load-bearing | If wrong | Evidence | Grade | Element |
|----------|-----------|--------------|----------|----------|-------|---------|
| Confirmed | [assumption] | yes/no | [what breaks] | [file, source, or observation] | A | [element] |
| Inferred | [assumption] | yes/no | [what breaks] | [what makes it reasonable] | C | [element] |
| Unknown | [assumption] | yes/no | [what breaks] | [gap description] | — | [element] |
```

---

### Element 8: Reality Check (arithmetic + outside view)

A strategy can be internally consistent and still be arithmetically impossible. This is the element that decides whether the other seven are a plan or a wish. Both parts are mandatory and both live in `strategy/one-pager.md` under `## Reality check`.

**A. Does the math close?** Show the arithmetic, not a conclusion:

| Line | Calculation | Figure | Tag |
|------|-------------|--------|-----|
| Capacity | available hours/week × weeks per quarter ÷ delivery hours per engagement | | |
| Revenue ceiling | concurrent engagements × price at the **floor** of the range | | |
| Required deals | target revenue ÷ average deal size | | |
| Required proposals | required deals ÷ close rate | | |
| Required conversations | required proposals ÷ proposals-per-conversation rate | | |
| Required prospects/week | required conversations ÷ weeks ÷ conversation rate | | |
| Channel capacity | prospects/week the primary channel can actually produce (compare against the channel minimums in Element 4) | | |
| Runway | months to first revenue vs the runway recorded in `reference/OPERATOR_PROFILE.md` | | |

Every figure carries its Document clarity tag: `measured` (you have the number), `estimated` (reasoned from something real), `assumption` (a guess), `unknown` (no basis). Conversion rates that come from the operator's own pipeline are grade A; ones borrowed from a blog are grade C and must be labeled as such.

**The strategy fails certification** when the required prospects exceed the primary channel's realistic capacity, or the revenue ceiling at the floor price does not cover the income target before runway ends. The fix is `@biz-strategy probe` on the buyer, price, or channel — not certifying anyway.

**B. Outside view (base rate).** Name the reference class — operators attempting this shape of business, at this price band, through this channel. State what normally happens to them: time to first revenue, typical overrun against plan. Grade the evidence, or mark it `directional` when you can only reason about it. Then reconcile your own timeline against it: if your plan is materially faster than the base rate, say why with something better than optimism; if slower, say what you are trading away.

The outside view is the antidote to the planning fallacy. An inside view assembled from your own plan always looks achievable, because it is built entirely out of your own intentions.

**Output:** append `## Reality check` (parts A and B) to `strategy/one-pager.md`.

### Greenfield completion

When all 8 elements + ledger are written:

```text
✓ Strategy one-pager:    {WORK_BUSINESS_ROOT}/strategy/one-pager.md
✓ Target buyer profile:  {WORK_BUSINESS_ROOT}/strategy/target-buyer-profile.md
✓ Offer scope:           {WORK_BUSINESS_ROOT}/strategy/offer-scope.md
✓ Channel plan:          {WORK_BUSINESS_ROOT}/strategy/channel-plan.md
✓ Pricing:               {WORK_BUSINESS_ROOT}/strategy/pricing.md
✓ Assumption ledger:     {WORK_BUSINESS_ROOT}/strategy/assumption-ledger.md
✓ Reality check:         {WORK_BUSINESS_ROOT}/strategy/one-pager.md § Reality check
                         (arithmetic closes + outside view stated)

Next: @biz-strategy certify  (validate consistency and promote gate)
```

---

## I1b — Design mode

`design` is the **generation and selection** half of strategy: it decides *which* play to run before greenfield decides *how* to run it. Greenfield is a coherence test on one idea; design is the search that produces the idea worth testing. Without it the framework can certify a strategy it never compared anything against, and the operator's first guess becomes the strategy by default.

**Playbook:** read `concepts/strategy-design/prompt.md` before running. It carries the six lenses, the archetype table, the scoring anchors, the moat taxonomy, the pre-mortem prompt bank and the breakeven worksheet. This section defines the **procedure and the files**; the playbook defines the **content**.

**IT-shaped offers add a lens:** when the deliverable is software, platform, data, security, or technical leadership, also read `concepts/it-services-strategy/prompt.md` (BIZ-12) during D2/D3/D4 — the **buying motion** (capability gap · bounded outcome · accountability gap · risk reduction · operational continuity) decides the offer shape, the proof and the sales cycle more than the technology does. An offer that does not name its buying motion is a capability list.

### When design is the right mode

| Situation | Run |
|-----------|-----|
| More than one plausible direction, nothing ranking them | `design` |
| Niche chosen by intuition, never compared to an alternative | `design` (the current play enters the ranking as a candidate) |
| 90 days elapsed with no traction and the buyer or offer may be the wrong shape | `design`, then `greenfield` |
| A new asset or constraint appeared (job, runway, proof, obligation) | `design` — the audit changed, so the ranking must be re-run |
| Re-certification blocked by load-bearing C/D evidence | `design` — re-select around the evidence instead of arguing harder |
| One direction already chosen, evidenced, and consistent | skip to `greenfield` |
| Certified strategy, one element fuzzy | `probe`, not design |

**The incumbent play competes; it is not replaced silently.** When a strategy already exists, its play joins the candidate set as one of the plays, scored on the same rubric. Design may only conclude "keep the current play" or "replace it with X, because the ranking says so", and either conclusion is written to the record. Re-running design is not a licence to relitigate a certified decision by fiat — it is a licence to compare.

### Workflow

| Step | Do | Write to |
|------|----|----------|
| **D1 — Situation audit** | Six lenses (assets, demand signals, constraints, traction, timing, identity); each row graded A–D with its artefact. Contradictions recorded, not smoothed. If no row reaches A/B, say so in the first line and label everything downstream `provisional`. | `strategy/situation-audit.md` |
| **D2 — Model the money** | Assign a business-model archetype per candidate (playbook §3) with its cash timing and capacity ceiling. Fixed price only; hourly is banned by `standards/20260621-PRICING-STANDARD.md`. | `strategy/design-record.md` § Archetypes |
| **D3 — Alternatives map** | Per candidate: what the buyer uses today — do nothing first, then DIY + AI, hire, freelancer, agency, incumbent product — with cost, speed, why it fails, and our wedge. If the cost of doing nothing is not demonstrably above the price, the play cannot score above 2 on speed to revenue. | `strategy/design-record.md` § Alternatives |
| **D4 — Generate plays** | 5–8 plays, distinct on buyer, offer, or channel. Six fields each: buyer, problem (root cause, ≤14 words), offer shape, one primary channel, price band (2–4x, fixed), business model. Each cites the audit row that produced it. Banned shapes refused at generation, with the reason recorded. | `strategy/design-record.md` § Plays |
| **D5 — Score** | Six criteria (speed to revenue 25 · asset fit 20 · buyer accessibility + budget 20 · defensibility 15 · evidence strength 10 · capacity fit 10). Weights are written down **before** any score is visible; if a weight moves after a score exists, restart. Every score carries a one-line justification **and** an A–D grade; a 4–5 resting on C/D evidence is capped at 2; an unevidenced criterion scores 1. | `strategy/design-record.md` § Scores |
| **D6 — Select** | Forced ranking, no ties (break on evidence strength, then speed). A winner must beat the runner-up by ≥5 weighted points; below that, the 2-point sensitivity swing decides and the record names the criterion that decided it. | `strategy/design-record.md` § Ranking |
| **D7 — WWHTBT** | For the winner only: ≤5 numbered conditions that must be true, each mapped to an assumption-ledger row, the cheapest test, and a fail-by date. Ordered by blast radius. | `strategy/design-record.md` § What would have to be true |
| **D8 — Pre-mortem** | ≥10 failure modes with likelihood (H/M/L, `directional`), an **observable** earliest signal with a number and a window, and a pre-committed response. Carry them into the bets and the decision row as kill signals. | `strategy/design-record.md` § Pre-mortem |
| **D9 — Moat** | Name the one moat the winner builds first, with its evidence artefact and the action that builds it. A moat whose evidence cell is empty is deleted, not softened. "No moat — two-way trade" is an allowed answer only with a short review date. | `strategy/design-record.md` § Moat |
| **D10 — Arithmetic** | Run the breakeven worksheet for the top two plays (never only the winner): price, deals/month, capacity, contribution, fixed cost, breakeven, months to first revenue vs runway, pessimistic / base / optimistic revenue, most-sensitive variable, and the value at which the strategy stops working. | `strategy/design-record.md` § Worksheet |
| **D11 — Record and hand off** | Write `## Strategy bets` into `strategy/one-pager.md`; append ONE decision row to `decisions/DECISIONS.md` (the choice of direction, with the rejected plays listed and their re-entry conditions). | `strategy/one-pager.md`, `decisions/DECISIONS.md` |

### Output contracts

- **Rejected plays are kept, with re-entry conditions.** Every play that lost stays in `design-record.md` with its score and the observable event that puts it back on the table ("if the buyer segment proves unwilling to pay the floor price, the productized-diagnostic play re-enters"). Deleting the runner-up means a failed winner restarts the whole search.
- **Design shapes, greenfield fills.** Design does not write the six canonical strategy files, does not write `certification.md`, and does not promote a gate. Its record is the seed: `@biz-strategy greenfield - from strategy/design-record.md`.
- **The decision row is the record of the call, not of the analysis.** Expected outcome with a number and a date, confidence %, reversibility, kill/review trigger, review by — per `CONVENTIONS.md` § Decision loop. A design run with no row cannot ever be scored.
- **Every world-claim carries a grade.** A play whose demand, price, or channel claim rests on D-grade memory is labelled `Unverified` and becomes WWHTBT condition 1, not a reason to proceed.
- **Document clarity:** `situation-audit.md` and `design-record.md` open with the ≤4-line Status/Needs header and close with exactly one `## Next action` section.

### Design completion gate (cannot be skipped)

Design is complete only when all are true:

1. `strategy/situation-audit.md` exists and every lens has at least one row, graded, with its artefact named.
2. `strategy/design-record.md` contains ≥3 scored plays (5+ unless the audit constrains the space and the reason is recorded), the pre-set weights, the ranking, the sensitivity answer, WWHTBT, the pre-mortem, and the moat.
3. The incumbent play is present in the ranking whenever a strategy already existed (or the absence is explained — e.g. first certification).
4. The rejected plays carry their re-entry conditions.
5. `## Strategy bets` is in `strategy/one-pager.md` with a kill signal and review date per bet.
6. Exactly one decision row is appended to `decisions/DECISIONS.md`.
7. The next command is stated: `@biz-strategy greenfield - from strategy/design-record.md` (or `probe - <element>` when the ranking exposed a specific gap).

If any item is missing, say which one and do not present the design as complete.

---

## I2 — Probe mode

Adaptive questioning to fill gaps. When assumptions are "inferred" or "unknown", or when an element feels fuzzy.

**Probe behavior:**

1. If no element specified, pick the highest-severity gap in this order: a **load-bearing** assumption before a peripheral one, then the largest `If wrong` blast radius, then Unknown before Inferred. Probe that.
2. If element specified (`@biz-strategy probe - person`), probe only that element.
3. Ask ONE question at a time. Wait for answer before next question.
4. After 3-5 answers, summarize the updated picture and propose a revision.

**Probe question bank (by element):**

| Element | Probe questions |
|---------|----------------|
| **Person** | "Who specifically has this problem and the budget to solve it?" "Have you talked to 3 of them?" "What title do they have on LinkedIn?" "What did they try before finding you?" "What would make them say 'not now'?" "Is employment a target, a fallback, or excluded for you personally?" "What must your static profile never say because of that?" |
| **Problem** | "What happens if they do nothing for 6 months?" "Is the problem painful enough to pay $X for?" "Who else is solving this, and why isn't it working?" "Is this the real problem or a symptom?" |
| **Offer** | "If you could only offer ONE thing, what would it be?" "What adjacent offers are you willing to walk away from?" "Does the offer fit a fixed-price milestone model?" "What does success look like for the buyer after delivery?" |
| **Channel** | "Where does your buyer currently get advice?" "Which platform have you been most active on historically?" "What content format does your buyer consume?" "If you could only do ONE channel for 90 days, which?" "If YouTube is primary, can you produce 1 long-form video/week (or 4–7 Shorts/week) for 6 months?" |
| **Price** | "What number would make you excited to take the project?" "What number would make them say yes without negotiation?" "What does the alternative (agency / hire / build in-house) cost?" |
| **Geography** | "Where are your last 5 clients or employers based?" "Can you legally invoice a client in that country?" "What timezone overlap do you need for the work style you prefer?" |
| **Reality** | "How many hours a week are genuinely available for billable delivery, not business development?" "How many weeks does one engagement actually take you, end to end?" "What close rate have you actually observed, not hoped for?" "How many qualified prospects per week can your primary channel realistically produce?" "How many months of runway, and by when do you need the first invoice?" "What normally happens to operators attempting this shape, at this price band, through this channel?" |

**Probe completion:** When all assumption-ledger gaps tagged "unknown" are resolved to at least "inferred", or when remaining unknowns are explicitly flagged as acceptable risk.

### YouTube channel probe (additional)

If YouTube is primary or secondary, verify:

| Question | Why it matters |
|----------|----------------|
| "What is the one video topic you could make 20 versions of without repeating yourself?" | Tests niche depth and long-term content supply |
| "What proof do you have on camera?" (demos, screen shares, case studies, client results) | YouTube B2B audiences trust show-don't-tell proof |
| "Can you commit to one publish slot weekly for 6 months?" | Consistency is a ranking signal; sporadic uploads kill momentum |
| "What is the lead magnet that moves a subscriber off-platform?" | YouTube alone is rarely the converter; email/resource bridge is required |
| "Are your target buyers on YouTube to learn or to be entertained?" | Determines format (tutorial vs. story) and tone |
| "What is your repeatable thumbnail/title system?" | CTR is the primary discovery gate; ad-hoc thumbnails fail |

**YouTube viewer persona note:** The B2B YouTube viewer is typically in "research mode" — they searched for a specific problem or clicked from a related technical video. They are patient with depth (8–15 minutes) if the first 30 seconds prove relevance. They subscribe only after 2–3 videos that consistently deliver. The conversion path is slower than LinkedIn but compounds.

---

## I2b - Amend mode

Strategy changes between certifications: an owner grill locks new positioning, a new offer shape appears, an audience fork is resolved. Amend records the change properly instead of letting it scatter across non-canonical docs.

1. **Apply the change** to the canonical files under `{WORK_BUSINESS_ROOT}/strategy/`. Do not leave the new positioning only in `ideas/`, `plans/`, or session notes.
2. **Log it** in `strategy/changelog.md` (create if missing): date, what changed, why, source (session/skill).
3. **Detect out-of-tree strategy docs.** Glob for `ideas/positioning_*.md`, `plans/strategy_*.md`, and any file asserting positioning authority (buyer, offer, pricing claims). For each: fold its content into `strategy/` and mark the original with an amendment banner pointing at `strategy/` as canonical, or delete the stale claims.
4. **Flag dependent artifacts stale.** List what must be reviewed against the new strategy: LinkedIn headline/About, website copy, pricing, queued-content buyers and CTAs, `plans/strategy_*.md`. Record the stale list in `{WORK_BUSINESS_ROOT}/plans/NEXT.md`.
5. **Require re-certification.** Amend never certifies. Downstream gated work (brand, pricing, content publish) pauses until `@biz-strategy certify` passes again.
6. **Demote the gates.** In `{WORK_BUSINESS_ROOT}/gates.md`, set `strategy-ready` to `NOT MET` with `**Certified:** —`, and cascade: every downstream gate (`brand-ready`, `pipeline-ready`, `sales-ready`) also demotes to `NOT MET`, because each one rests on the positioning that just changed. Leave `active-deal` alone — a live deal survives a positioning change. Without this step the gate ledger keeps asserting PASS against superseded strategy, and gated skills run on stale positioning.
7. **Supersede the decision row.** Append a new row to `decisions/DECISIONS.md` for the amended direction, and set the superseded strategy row's `Outcome` to `superseded by D-{nnn}`. The old row is never rewritten: the point of the ledger is that you can see what you used to believe and what it cost. The next `@biz-strategy certify` appends its own row per check 13.

---

## I2c - Reconcile mode

Sometimes a canonical strategy file contradicts the certified record, not because positioning changed but because a decision was never transcribed into that file. `amend` is the wrong instrument: it demotes `strategy-ready` and cascades to three downstream gates, so a pure consistency repair would pause gated work in order to record something the certification already asserts. That asymmetry pressures operators to leave inconsistencies unrecorded, which is the opposite of what the gate system is for.

Reconcile exists for exactly that case, and it is deliberately hard to qualify for.

### Eligibility test (all four must hold — otherwise this is an amend)

| # | Condition | How to prove it |
|---|-----------|-----------------|
| 1 | **The decision is already in the certified record** | Quote it from `strategy/certification.md`, or from another file that was binding at the time of the last passing certification. A quote is mandatory; a recollection is not evidence |
| 2 | **No certification element changes** | Person, problem, offer, price, channel hierarchy, and geography are all untouched. Adding a *secondary* or *supporting* item that the certification already named is in scope. Naming a **new** primary channel is not |
| 3 | **The fix is transcription, not judgment** | You are copying an existing decision into a file that lacks it. If you must decide anything the record does not already settle, stop |
| 4 | **No downstream artifact becomes stale** | Nothing that was correct before the fix becomes wrong after it. If the profile, website, pricing, or queued content would need rework, it is an amend |

**If any condition fails, stop and run `@biz-strategy amend` instead.** Say which condition failed and why. Reconcile must never become the path of least resistance for a real strategy change; that would let positioning drift while the ledger keeps asserting PASS, which is the precise failure the gate system exists to prevent.

### Workflow

1. **Prove eligibility.** Emit the four conditions with evidence before editing anything. Quote the certified source.
2. **Apply the transcription** to the canonical file under `{WORK_BUSINESS_ROOT}/strategy/`. Add a short inline correction note stating what was missing, which files already carried the decision, and that no gate moves.
3. **Log it** in `strategy/changelog.md` marked **(correction)**, with the certified quote, the eligibility reasoning, and an explicit statement that no re-certification is required.
4. **Do not touch `gates.md`.** No promotion, no demotion. Say so in the report.
5. **Do not flag artifacts stale.** By condition 4 there are none. If you find one, you ran the wrong mode; stop and escalate to amend.
6. **Report** what was inconsistent, what now matches, and the gates you deliberately left alone.

### Output

```
RECONCILE — {PROJECT_NAME}

INCONSISTENCY
  File missing the decision: <path>
  Decision:                  <one line>

CERTIFIED SOURCE
  <path> — "<direct quote>"

ALSO ALREADY CARRIED BY
  <paths that had it right>

ELIGIBILITY
  1 In certified record:      PASS — <evidence>
  2 No element changes:       PASS — <which elements checked>
  3 Transcription only:       PASS — <what was copied>
  4 No artifact goes stale:   PASS — <what was checked>

APPLIED
  <path> — <what changed>
  strategy/changelog.md — correction logged

GATES
  Unchanged. No re-certification required.

Next: nothing - work complete
```

---

## I2d — Career mode

`@biz-strategy career` models the one thing every other skill assumes but nothing records: the operator. Skills, proof points, constraints, risk tolerance, career stage. Strategy advice that ignores what the operator can actually deliver and prove is fiction, and content written without real proof points is generic by construction.

The output lives at `{WORK_BUSINESS_ROOT}/reference/OPERATOR_PROFILE.md` (template: `templates/work/reference/OPERATOR_PROFILE.md.template`). It is deliberately a **reference** artifact, not a strategy file: it is input to positioning decisions, not a positioning decision itself, so it neither promotes nor demotes any gate and never trips the weekly drift check.

### Workflow

1. If `{WORK_BUSINESS_ROOT}/reference/OPERATOR_PROFILE.md` is missing, create it from the template. When it exists, read it first and update rather than restart.
2. Probe the operator one block at a time. Ask one question at a time; wait for the answer. Skip blocks already filled with content that is still true. A `- <block>` invocation probes only that block.

| Block | Probe questions |
|-------|-----------------|
| **Skills** | "What can you do better than most people you've worked with?" "What do people ask you for help with?" "Which of your skills are current, and which are stale?" |
| **Proof points** | "Name three things you built or led, with numbers: size, timeline, outcome." "What would a former client or manager vouch for?" |
| **Constraints** | "How many hours per week are actually available for business development?" "What is your runway in months before income pressure forces decisions?" "Anything you will not do: travel, cold calls, on-camera?" |
| **Risk tolerance** | "What does failure cost you, concretely?" "What bet feels too big right now? What bet feels too small?" |
| **Career stage** | "Employed, transitioning, or fully independent?" "Is employment a fallback you keep open or a door you are closing?" |
| **Direction** | "Do you want more of what you do now, a different buyer, a different offer, or a different life shape?" |

3. Fill the profile in place. Proof points must carry numbers and dates; a proof point without a number is a claim, not proof. If the operator cannot name three, say so plainly in the profile and in the report: that gap is the single biggest constraint on credible content and pricing.
4. Produce a career-direction read grounded in the profile and, when it exists, the certified strategy:

| Read | Meaning |
|------|---------|
| **Hold** | Current direction fits skills, proof, and constraints. Keep executing. |
| **Sharpen** | Direction is right, but the offer or buyer is looser than the proof supports. Route to `@biz-strategy probe` on the named element. |
| **Transition** | Evidence points at a different buyer, offer, or stage. Route to `@biz-strategy amend` (or `greenfield - force` before first certification). |

Grade every load-bearing statement in the read as Confirmed / Inferred / Unknown, the same discipline as the assumption ledger.

5. If strategy docs exist, cross-check them against the profile: does the offer match what the operator can deliver? Does the channel fit the constraints (an operator with 5 hours a week cannot hold LinkedIn at 3–4 posts/week)? Does the price floor respect the runway? Report mismatches as findings; fixing them is `@biz-strategy amend`'s job, not this mode's.

### Rules

- Career mode writes `reference/OPERATOR_PROFILE.md` and nothing else. It never edits `strategy/`, never touches `gates.md`, and never certifies.
- A career direction that changes the offer is a strategy change. This mode reports it; `@biz-strategy amend` records it.
- Proof points are evidence, not marketing. No inflation, no borrowed numbers.

---

## I3 — Certify mode

Deep consistency check. Produces a pass/fail verdict and promotes the **strategy-ready** gate on pass.

### Certification checklist

Each check must pass. First failure stops the check.

| # | Check | What it verifies | Fail if |
|---|-------|------------------|---------|
| 1 | **Files exist** | All 6 strategy files present | Any file missing |
| 2 | **Ledger complete** | All elements have at least one assumption recorded | An element has zero entries |
| 3 | **Load-bearing assumptions** | No load-bearing assumption is Unknown, and none rests on grade-C/D evidence. Peripheral Unknowns are ≤ 30% of all rows. | Any load-bearing row is Unknown (run `@biz-strategy probe`), or a load-bearing row's only support is a grade-C/D source, or peripheral Unknowns exceed 30% of rows |
| 4 | **Internal consistency** | Each element constrains and is constrained by the others | Person can't afford price. Channel doesn't reach person. Problem doesn't match offer. Geography blocks channel. |
| 5 | **Person specificity** | Primary buyer is a specific person, not a demographic. Secondary/opportunistic audiences are allowed only if the primary stays singular and the rules for them are explicit. | "Small business owners" (too vague) vs "Seed-stage SaaS founders who raised $500k and need their MVP built" (specific). Multiple co-equal buyers with no primary. |
| 6 | **Problem sharpness** | Problem is the root cause, stated in under 14 words | Problem is vague ("they need help with technology") or stated as a solution ("they need a website") |
| 7 | **Offer focus** | Offer is ONE thing with explicit IS / IS NOT | Offer lists 3+ services. No "what this is NOT" section. |
| 8 | **Channel primary** | One primary channel identified. Others are secondary. | 3+ channels listed as equal priority. No primary channel named. |
| 9 | **Price range** | Range is 2-4x spread. Floor covers minimum viable rate. | Range is wider than 4x. Floor below minimum viable rate. |
| 10 | **Geography defined** | Geography is explicit (local, regional, or global). | No geography stated. "Everywhere" without timezone/language constraints. |
| 11 | **Reality arithmetic** | `one-pager.md` § Reality check A is present and closes: capacity → revenue ceiling at the floor price covers the income target; required prospects/week ≤ the primary channel's realistic capacity; first revenue lands inside runway. Every figure carries a `measured`/`estimated`/`assumption`/`unknown` tag. | Section missing, arithmetic absent, numbers do not close, a load-bearing figure is `assumption`/`unknown`, or a conversion rate is used without stating its source |
| 12 | **Outside view** | `one-pager.md` § Reality check B names the reference class, states what normally happens to it (graded, or marked `directional`), and reconciles the plan's timeline against it — explaining any material difference. | Section missing, a timeline asserted with no reference class, or the plan is materially faster than the base rate with no stated reason |
| 13 | **Decision record** | The certified strategy is appended to `decisions/DECISIONS.md` as one row with a falsifiable expected outcome, a confidence, a reversibility class, a kill/review trigger, and a review date (`CONVENTIONS.md` § Decision loop). | No row appended, or the row lacks any of the five required fields |
| 14 | **Alternatives recorded** | The strategy was chosen against something. Passes with `strategy/design-record.md` (≥3 scored plays, rejected plays carrying re-entry conditions) **or** a `## Alternatives considered` section in `one-pager.md` naming ≥2 rejected plays and why each lost. A project certified before design existed may instead record `alternatives: waived — <specific reason>` in `certification.md`; a blanket waiver is not a reason. | No design record, no alternatives section, and no specific waiver — the strategy has nothing it beat, so its selection was never a decision |
| 15 | **Pre-mortem / kill signals** | `one-pager.md` § `## Strategy bets` carries, per bet, a kill signal with a number and a window plus a review date; or `design-record.md` § Pre-mortem carries ≥3 failure modes with observable signals. | No bets table, no pre-mortem, or a signal that cannot be observed inside the review window ("engagement is low") |
| 16 | **Moat / durability** | The winner names one defensibility mechanism with its evidence artefact (case study, method, named relationships, switching cost, audience, delivery record, licence), **or** states `no moat — two-way trade` with a review date short enough that speed must arrive before the moat question does. | Moat asserted with an empty evidence cell, or no statement at all |
| 17 | **Sensitivity & breakeven** | Reality check A carries breakeven deals/month, pessimistic / base / optimistic revenue, the most-sensitive variable, and the value at which the strategy stops working. | Single-point forecast, no breakeven, or no sensitivity — a number with no range cannot fail, so it cannot be managed |

### Consistency check: Element web

Every pair of elements must be consistent:

```
Person ── Problem:  Does this person actually have this problem?
Person ── Offer:    Would this person buy this offer?
Person ── Channel:  Does this person spend time on this channel?
Person ── Price:    Can this person afford this price range?
Person ── Geography: Is this person in the geography?

Problem ── Offer:   Does this offer solve this problem?
Problem ── Channel: Do people with this problem seek help on this channel?
Problem ── Price:   Is the problem painful enough to justify the price?

Offer ── Channel:   Can this offer be sold through this channel?
Offer ── Price:     Does the offer economics support the price?
Offer ── Geography: Can this offer be delivered in this geography?

Channel ── Price:   Does this channel support this price range?
Channel ── Geography: Does this channel reach buyers in this geography?

Price ── Geography: Does the geography's market support this price?
```

### Failure modes (specific)

| Failure | Pattern | Fix |
|---------|---------|-----|
| **The everything shop** | 3+ services listed equally | Cut to ONE. Move others to "case study" or "what I've built" |
| **The demographic trap** | "Small business owners" or "startups" | Add constraints: funded? non-technical? seed-stage? B2B? |
| **The price mismatch** | $5k offer sold on LinkedIn (works) vs $5k offer sold via YouTube (channel too slow) or $80k offer sold via cold email (trust too low) | Adjust channel to match price, or price to match channel |
| **The geography gap** | Global remote but no timezone statement | Add minimum overlap (e.g. "4hr overlap with US Eastern") |
| **The symptom problem** | "They need a website" instead of "They need leads" | Probe deeper. Ask "why do they need a website?" 3x. |
| **The wishful channel** | "I'll use all of them" | Force single primary channel selection. Others are secondary at most. |

### Pass

If all checks pass:

1. Write `strategy/certification.md` with:
   - Date of certification
   - Check results (all pass)
   - Assumption ledger summary (counts: confirmed, inferred, unknown; load-bearing rows and their grades; the largest `If wrong` blast radius)
   - Reality check summary (revenue ceiling at floor price vs target, required prospects/week vs channel capacity, runway verdict, reference class and how the timeline compares)
   - Certified by: `@biz-strategy certify`

2. Append the certification to the decision ledger — one row in `{WORK_BUSINESS_ROOT}/decisions/DECISIONS.md` (create from `templates/work/decisions/DECISIONS.md.template` if missing; self-heal, never skip the record). Required fields per `CONVENTIONS.md` § Decision loop: a falsifiable **expected outcome** with a number and a date, a **confidence** %, a **reversibility** class, a **kill/review trigger**, and a **review by** date. A certified strategy with no falsifiable expectation is a certified opinion; if the operator cannot state one, say so plainly in the report — that is itself a finding.

3. Promote **strategy-ready** gate in `{WORK_BUSINESS_ROOT}/gates.md`, replacing the existing `## strategy-ready` section in place and leaving every other gate section untouched:

```markdown
## strategy-ready
**Status:** PASS
**Certified:** {date}
**By:** @biz-strategy certify
**Evidence:** `.work.biz/strategy/certification.md`
**Next gate:** brand-ready — run `@biz-brand audit` then `@biz-brand overhaul`
```

If `gates.md` does not exist, create it from `templates/work/gates.md.template` first, then promote. Keep all five fields — `scripts/gate-verify.sh` checks the `Evidence` path when `Status` is PASS.

4. Output:

```text
✓ CERTIFIED: strategy-ready
  All 17 checks passed. No critical consistency failures.
  Chosen against: {n} scored plays — {winner} beat {runner-up} by {points} weighted points
  Kill signals: {n} with observable windows · Moat: {mechanism or "none — two-way trade"}
  Breakeven: {deals/month} vs capacity {deals/month} · Most-sensitive: {variable}
  Arithmetic closes: {revenue ceiling at floor price} vs target {target}; {required prospects/week} prospects/week vs channel capacity.
  Reference class: {base rate stated, or "directional"}
  Decision logged: D-{nnn} — expected {expected outcome}, review by {date}
  Next: @biz-brand audit  (audit LinkedIn + website alignment)
         @biz-pricing set  (set specific prices for engagements)
```

### Fail

If any check fails:

```text
✗ FAILED: strategy-ready not certified
  Failed at check #{n}: {check name}
  Reason: {specific failure}
  To proceed: {specific action — e.g., "Run @biz-strategy probe - person to clarify the buyer"}
  Assumption state: {n} load-bearing unknown ({which}) · {n} of {total} peripheral unknown ({pct}%)
  Arithmetic: {closes | does not close — which line}
  For checks 14–17: @biz-strategy design  (produces the alternatives, bets, moat and worksheet
  without re-running greenfield; the current play enters the ranking as a candidate)
```

Do NOT write `certification.md`. Do NOT promote the gate.

### Explain mode (`certify - why`)

Read-only analysis of why the current strategy would fail certification, without modifying any files or attempting certification. Outputs the expected failure point and what to fix.

---

## I4 — Status mode

Read-only state report. Reads existing strategy files and reports:

```
Strategy status — {WORK_BUSINESS_ROOT}/strategy/

  One-pager:            {exists/missing}  ({last modified date if exists})
  Target buyer profile: {exists/missing}
  Offer scope:          {exists/missing}
  Channel plan:         {exists/missing}
  Assumption ledger:    {exists/missing}
  Certification:        {exists/missing}
  Reality check:        {present (arithmetic closes/does not close · reference class stated/directional/missing) / missing}
  Design record:        {present (n plays, winner <play>, margin <points>) / missing — @biz-strategy design ranks alternatives before certification}
  Situation audit:      {present (weakest lens <lens>, A/B rows <n>) / absent}
  Strategy bets:        {n bets with kill signals / none — certify check 15 will fail}
  Decision ledger:      {n decisions — n open, n past review date / missing - the judgment loop is not running}

  Gate: strategy-ready  {PASS / FAIL / NOT ATTEMPTED}

  Operator profile:     {exists (filled/skeleton) / missing} — reference/OPERATOR_PROFILE.md; run @biz-strategy career to build or update

  Out-of-tree strategy docs: {none / list of ideas/positioning_*.md and plans/strategy_*.md found - run @biz-strategy amend to fold in}

  Assumption summary:
    Confirmed: {n}   Inferred: {n}   Unknown: {n}   ({pct}% unknown — {'pass' if ≤30% else 'over threshold'})
    Load-bearing unknown: {n} {('— blocking: <which>' if n>0 else '— none')}
    Weakest evidence: {the load-bearing row with the lowest grade, or none}

  Element summary:
    Person:   {defined/missing} — {one-line summary if defined}
    Problem:  {defined/missing} — {one-line summary if defined}
    Offer:    {defined/missing}
    Channel:  {defined/missing}
    Price:    {defined/missing}
    Geography: {defined/missing}
    Reality:  {defined/missing} — {arithmetic verdict + reference class}

  Quick actions:
    @biz-strategy greenfield        (if missing or wants full rewrite)
    @biz-strategy probe - <element> (to fill a gap)
    @biz-strategy certify           (to promote gate)

Next: <nothing - status read-only | the single applicable quick action>
```

---

## Time budget

| Mode | Estimated time | Notes |
|------|---------------|-------|
| `design` | 60-120 minutes | Generation + scoring + pre-mortem + worksheet. The highest-leverage block in the framework. |
| `greenfield` | 45-90 minutes | Full walkthrough. Schedule a block. |
| `greenfield - from <file>` | 20-40 minutes | Faster if seed doc is detailed. |
| `probe` | 5-15 minutes | Per element. Variable based on gaps. |
| `career` | 20-40 minutes | Full profile. A `- <block>` run is 5-10 minutes. |
| `certify` | 5-10 minutes | Quick if strategy is clean. |
| `status` | < 1 minute | Read-only. Near-instant. |

---

## Gates unlocked

| Gate | Unlocked by | Enables |
|------|-------------|---------|
| **strategy-ready** | `@biz-strategy certify` (pass) | `@biz-brand audit`, `@biz-pricing set`, `@biz-social strategy` / `plan` |
| **brand-ready** | `@biz-brand overhaul` | `@biz-content` (all modes but `status`), `@biz-community engage` |
| — | (strategy-ready must pass before any downstream gate can) | Gated skills read `.work.biz/gates.md` in their I0; they do not infer state from files |

`@biz-content publish` requires **brand-ready**, which itself rests on strategy-ready: publishing drives traffic to a profile and website, so those surfaces must already match the offer or the content converts into a dead end.

See `SKILL_DEPENDENCIES.md` for the full gate graph.

---

## When to re-run

| Situation | Action |
|-----------|--------|
| More than one plausible direction, or the first guess was never compared | `@biz-strategy design`, then `greenfield - from strategy/design-record.md` |
| A certified play failed its kill signal | `@biz-strategy design` with the rejected plays' re-entry conditions — re-enter one rather than inventing a new direction from zero |
| Adding a new service line | `@biz-strategy greenfield - force` (restart from scratch) |
| First 90 days are up and no traction | `@biz-strategy probe - person` (is the buyer real?) then `@biz-strategy probe - problem` (is the problem painful enough?) |
| First client signed but market feels different from strategy | `@biz-strategy probe` (scan for new assumptions from real market feedback) |
| Buyer conversations consistently confuse the offer | `@biz-strategy probe - offer` then `@biz-strategy certify` |
| A positioning decision was made in another skill or session (owner grill, brand session, pricing change) | `@biz-strategy amend` then `@biz-strategy certify` |
| A canonical file contradicts the certification, but only because a decision the certification already asserts was never transcribed into it | `@biz-strategy reconcile` — no gate moves, no re-certification. Prove all four eligibility conditions in I2c first |
| Operator circumstances changed (new job situation, runway shift, new proof points, skill decay) | `@biz-strategy career - <block>` to update the profile; escalate to amend only if the read says the offer must change |
| 6+ months since last certification | `@biz-strategy probe` then `@biz-strategy certify` (re-certify quarterly) |

---

## Related skills

| Skill | When |
|-------|------|
| `@biz-bootstrap init` | Before strategy — scaffolds the work tree |
| `@biz-market-validate test` | After design — tests the WWHTBT conditions before greenfield commits to them |
| `@biz-brand audit` | After certification — align LinkedIn/website to the strategy |
| `@biz-pricing set` | After certification — set specific engagement prices |
| `@biz-content publish` | After brand-ready gate — publish content aligned to strategy |
| `@biz-market-validate test` | Anytime — run experiments to validate strategy assumptions |

---

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

---

## Files to reference

- `{WORK_BUSINESS_ROOT}/strategy/one-pager.md`
- `{WORK_BUSINESS_ROOT}/strategy/target-buyer-profile.md`
- `{WORK_BUSINESS_ROOT}/strategy/offer-scope.md`
- `{WORK_BUSINESS_ROOT}/strategy/channel-plan.md`
- `{WORK_BUSINESS_ROOT}/strategy/pricing.md`
- `{WORK_BUSINESS_ROOT}/strategy/assumption-ledger.md`
- `{WORK_BUSINESS_ROOT}/strategy/certification.md`
- `{WORK_BUSINESS_ROOT}/strategy/situation-audit.md`
- `{WORK_BUSINESS_ROOT}/strategy/design-record.md`
- `.ai.biz/concepts/strategy-design/prompt.md` (design playbook)
- `{WORK_BUSINESS_ROOT}/gates.md`
- `.ai.biz/skills/SKILL_DEPENDENCIES.md`
- `{WORK_BUSINESS_ROOT}/strategy/changelog.md` (append-only amend and reconcile log)
- `{WORK_BUSINESS_ROOT}/decisions/DECISIONS.md` (decision ledger; certify and amend append rows here)
- `{WORK_BUSINESS_ROOT}/reference/OPERATOR_PROFILE.md` (operator skills, proof points, constraints; written by career mode)
