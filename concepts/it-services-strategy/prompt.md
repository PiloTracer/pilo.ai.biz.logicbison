# IT services strategy — playbook

This is the **IT-specific** companion to `concepts/strategy-design/prompt.md` (BIZ-11). BIZ-11 decides *which* play to run; this document is what changes when the product is IT capability — software delivery, platform/infrastructure, data, security, or technical leadership. Read it during `@biz-strategy design` when the offer is IT-shaped, and before `@biz-pricing set` for any IT engagement.

Evidence discipline applies in full: every claim about what IT buyers pay, how they buy, or what they compare is cited from `docs/sources/verified-sources.md` § IT services strategy, or marked `directional`/`Unverified` with an evidence grade per `CONVENTIONS.md`. The numbers in this document that are not claims about the world are thresholds and prescriptions — they are advice, and they are labelled as such.

---

## 1. The IT buying motion decides more than the offer

IT work is bought through a small number of motions, and each one has a different budget source, decision-maker, and sales cycle. Choosing the offer without choosing the motion is the most common way an IT strategy fails: a perfectly good fixed-scope build sold through a procurement process designed for staff augmentation will lose to a vendor with a rate card.

| Buying motion | Who owns the budget | What they compare you to | Sales cycle shape | Offer shape that fits |
|---|---|---|---|---|
| **Capability gap** (we need hands) | Engineering manager / delivery lead | Other contractors, a staffing vendor, an existing framework agreement | Short, often days; a CV and a rate | Staff augmentation, placed engineer, embedded consultant |
| **Bounded outcome** (we need X built) | Product or engineering leader with a funded initiative | An agency, an internal team, a freelancer, or doing it themselves | Weeks; a scope, a plan, references | Fixed-scope delivery, productized build, MVP |
| **Accountability gap** (nobody owns this) | CTO / VP / founder | A fractional executive, a consultant, a hire they cannot make yet | Weeks to a quarter; trust, diagnosis, references | Fractional CTO, technical advisory retainer, architecture review |
| **Risk reduction** (something must not break / must pass an audit) | Security, compliance, platform owner | An audit firm, an incumbent vendor, an insurer requirement | Depends on the deadline that triggered it | Assessment, compliance remediation, reliability engagement |
| **Operational continuity** (keep it running) | Ops / platform owner | A managed-service provider, an offshore team, an incumbent | Weeks; SLA, coverage, cost per month | Managed service, retainer with an SLA, on-call coverage |

Rules:

1. **One motion per offer.** A proposal that answers "capability gap" and "bounded outcome" simultaneously reads as a body shop with a project manager attached.
2. **Match the motion to the buyer's urgency, not your availability.** The same operator can run a capability-gap business and a bounded-outcome business, but not as one offer.
3. **The budget source is the constraint.** A team with headcount budget can buy people; only a leader with a funded initiative can buy an outcome. If you cannot name which budget line pays, the deal has no buyer (`§4` of BIZ-11 — the same test as "do nothing" being a competitor).

---

## 2. Offer archetypes specific to IT

These sit under the BIZ-11 archetype table; they are the IT-instantiations, with the operating constraint that decides whether each one is viable for a solo operator or a small firm.

| Archetype | Unit of sale | Cash shape | Capacity ceiling | Viable when | Typical failure |
|---|---|---|---|---|---|
| **Placed engineer / staff aug** | Person-month or person-week | Monthly in arrears; slow to start, steady once placed | Your hours only; one client can consume all of them | A trusted channel already places engineers, and the operator wants income stability over margin | Rate compression over time; no asset built; the client owns the relationship |
| **Fixed-scope delivery** | One project, one price | 50/50, or 25/25/50 over 30 days (`standards/20260621-PRICING-STANDARD.md`) | Concurrency limited by review and integration time, not coding time | The outcome can be specified, and the operator can prove a comparable delivery | Estimation failure on the unknown; scope creep after signature |
| **Productized build** | One named package, repeated | Deposit before start | Clients in flight × cycle days | The same problem recurs and the scope can be written once (e.g. "auth + billing + deploy in 4 weeks") | Per-client exceptions turn it back into bespoke |
| **Technical diagnostic / audit** | Fixed fee, fixed duration, written output | Upfront | A few per month; report-writing bound | The buyer is not ready to commit to a build, and a diagnosis is the natural first purchase | The report becomes free consulting if the follow-on is not scoped in the same document |
| **Fractional CTO / technical leadership** | Monthly retainer with a stated scope and response window | Monthly in advance | Reserved days per month × clients | The buyer needs judgement more than output, and the operator can hold a decision cadence | Loose scope turns it into an expensive help desk |
| **Managed service / retainer with SLA** | Monthly fee for a defined service level | Monthly in advance | On-call load is the real ceiling — it does not scale like project work | The buyer wants the problem to stop being theirs, and the operator can staff on-call | Uptime promises that one person cannot keep on holiday |
| **AI-assisted delivery** | A fixed-scope outcome, priced as an outcome | As fixed-scope | Review and QA time, not generation time | The operator can govern AI output with tests, review, and a defined acceptance standard | Selling "AI" instead of the outcome; output the buyer cannot trust or maintain |

Rules:

1. **Price the outcome, never the hours.** Hourly is banned by the pricing standard, and in IT specifically it converts every efficiency gain into a revenue loss.
2. **The first engagement should be the smallest thing that proves the next one.** A diagnostic that ends with a written recommendation and a fixed-price follow-on is a better first sale than a large build with an unproven client.
3. **Name the maintenance story in the offer.** IT deliverables decay; an offer with no answer to "who fixes this in six months" loses to one that has it.

---

## 3. Pricing architecture for IT work

BIZ-11 and `@biz-pricing` cover value-based pricing. The IT-specific mechanics:

| Decision | Method | Failure sign |
|---|---|---|
| **Floor** | Internal effective rate = `price ÷ delivery hours`. It must clear the operator's minimum acceptable rate with margin for rework and unpaid sales time | The floor is below the rate the operator would accept as an employee, for less risk |
| **Anchors** | What the buyer would pay an agency, a hire, or a product for the same outcome — graded, from the operator's own quotes or a live pricing page | Anchors are from memory ("agencies charge 3x") |
| **Scope units** | Price by the unit the buyer already understands (one service, one integration, one region), not by your internal decomposition | The buyer cannot tell what another unit would cost |
| **Change orders** | Written approval before work on anything outside the stated scope, with the price/time effect stated | Scope grows silently; the discount is your unpaid weekends |
| **Discount policy** | Never discount; reduce scope (`standards/20260621-PRICING-STANDARD.md`) | A "small" discount on a fixed price transfers the entire margin of the overrun |

**Day-rate conversion (advice, not a claim):** when a buyer asks for a day rate, convert rather than quote: estimate delivery days, multiply by the internal effective rate, add a buffer for unknowns, and present that as the fixed price with the assumption list attached. This gives the buyer a number in their familiar unit without adopting their pricing model.

---

## 4. Proof: what an IT buyer accepts

IT buyers discount claims heavily because they have been burned by delivery. Proof that carries weight, in rough order:

1. **A delivered system they can inspect** — a repository, an architecture, a running product, a public write-up with the constraints stated.
2. **A named reference who will take the call** — not a logo, a person.
3. **A number about a system** — latency, cost, uptime, deploy frequency, incident reduction. Scope without a number still counts if it is specific ("14 services, 40 deploys/week, 3 regions").
4. **A case study with the failure path included** — what went wrong and what changed. Buyers read the failure path as evidence of honesty and competence.
5. **Credentials** — certifications, security clearances, insurance. These are gates, not differentiators.

Rules: a portfolio with no constraints reads as a tutorial; a case study without a number reads as marketing; a proof point the operator cannot discuss under NDA is described by problem class and outcome, never invented. `@biz-career resume` and this section use the same evidence — the public profile, the CV, and the proposal should not contradict each other.

---

## 5. Differentiation that is not a slogan

IT services firms converge on the same three claims: quality, speed, and communication. Those are table stakes, not differentiation. Differentiation is a **constraint the operator accepts that a competitor will not**, made credible by evidence:

| Differentiation move | What it costs the operator | Why a buyer values it |
|---|---|---|
| **One narrow problem, done repeatedly** | Refusing adjacent work | Predictable delivery and a scope the buyer can compare |
| **Fixed price with a named assumption list** | Estimating risk sits with the operator | The buyer's downside is capped |
| **Senior-only delivery** | No leverage, no delegation margin | The person who scoped it does it |
| **Written diagnosis before any build** | Sales cycle is longer | The buyer can say no cheaply |
| **Maintenance included for a stated period** | Margin held back | The deliverable will not be abandoned |
| **Proof published, including failures** | Reputational exposure | Evidence the claim is real |
| **A hard cap on concurrent clients** | Revenue ceiling | Attention is a real constraint |

Test any proposed differentiator: **could a competitor say the same sentence without changing their business?** If yes, it is a slogan. The second test is the one BIZ-11 uses for moats: what evidence would a sceptical buyer accept today, and does the operator have it?

---

## 6. The IT sales motion, per archetype

| Archetype | First touch that works | What the first call must produce | Artefact that closes |
|---|---|---|---|
| Capability gap | A referral from someone who has seen the work | Availability, rate, and a start date | A CV tailored to the requirement, sent same day |
| Fixed-scope delivery | A diagnostic conversation about the specific problem | A shared definition of "done" and the constraints | A one-page scope with assumptions and a price |
| Productized build | A named package in front of the right segment | Confirmation the package matches their situation | The package page plus one reference call |
| Fractional CTO | A peer or investor introduction | A diagnosis they recognise and a 30-day plan | A retainer scope with a response window |
| Managed service | An incident, an audit finding, or a failed hire | The service level they actually need | An SLA with exclusions stated |

Rule: **the first artefact is cheap to produce and expensive to ignore.** A one-page diagnosis beats a 20-slide capability deck, because it does the buyer's thinking for them.

---

## 7. Anti-patterns

1. **The full-stack shop** — "we do web, mobile, cloud, data, and AI" makes the buyer unable to decide you are the right choice for theirs. **Fix:** pick one motion and one problem class; list the rest as history.
2. **Portfolio as proof** — screenshots with no problem statement, constraints, or outcome. **Fix:** one case study per archetype, with the failure path and a number.
3. **Rate-card reflex** — answering "what do you charge" with a day rate. **Fix:** convert to a fixed price with assumptions (`§3`).
4. **The free architecture review** — diagnosing for free to win the build, then losing to a cheaper build. **Fix:** the diagnosis is the paid first engagement.
5. **Heroic delivery** — one person absorbing every overrun. **Fix:** price rework and QA into the estimate; state the change-order rule in the proposal.
6. **Proof by credential** — leading with certifications instead of delivered systems. **Fix:** credentials in the footer; the system in the first screen.
7. **Maintenance amnesia** — selling the build and walking away. **Fix:** name the maintenance story in the offer, even if it is "you own it, here is the runbook".
8. **Differentiation by adjective** — "quality, speed, communication". **Fix:** apply the constraint test in `§5`.

---

## 8. Handoff

| Output | Consumed by |
|---|---|
| Buying motion + archetype + proof gaps, recorded in `strategy/design-record.md` § Archetypes | `@biz-strategy greenfield`, `@biz-pricing set` |
| Price architecture (floor, anchors, scope unit, change-order rule) | `@biz-pricing`, `@biz-proposal` |
| Proof inventory and its gaps | `@biz-brand`, `@biz-career resume`, `@biz-writing` case studies |
| Differentiation constraint with its evidence | BIZ-11 §9 moat, `@biz-marketing`-style content pillars |

Flow: `@biz-strategy design` (with this document as the IT lens) → `@biz-strategy greenfield - from strategy/design-record.md` → `@biz-strategy certify`. Price details are `@biz-pricing set`; the public-facing version of the proof is `@biz-brand overhaul`; the employment-facing version is `@biz-career resume`.
