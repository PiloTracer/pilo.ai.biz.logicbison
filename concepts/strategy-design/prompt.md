# Strategy design — playbook

This is the generation and selection half of strategy, upstream of the 8-element greenfield walkthrough. Greenfield tests one idea: person, problem, offer, channel, price, geography, ledger, arithmetic — it either closes or it does not. Design generates five or more different plays, prices their business models, scores them on graded evidence, and kills the weak ones before any earns a walkthrough. The output is a selected play with a ranked alternative behind it, kill signals written in advance, and a record a later reader can audit. Design does not certify; it produces the record that makes certification worth anything.

## 1. When to use

| Situation | Mode | Why |
|-----------|------|-----|
| More than one plausible direction, nothing ranking them | `design` | Selection needs generation first; a single idea has nothing to be selected against. |
| One direction already chosen and evidenced | `greenfield` | Skip design: the walkthrough tests coherence; design would only manufacture alternatives to a settled decision. |
| Certified strategy, one element still fuzzy | `probe` | Gap-filling, not regeneration. |
| Positioning changed outside the skill | `amend` | Record the change; do not re-derive the strategy around it. |
| First 90 days done, no traction, buyer or offer may be the wrong shape | `design`, then `greenfield` | No-traction is a shape failure; probing sharpens a shape already chosen. |
| A new asset or constraint appeared (job, runway, proof, obligation) | `design` | The audit's six lenses changed, so the ranking has to be re-run. |
| A load-bearing claim rests on C/D evidence at certify | `design` | Check 3 blocks; the play must be re-selected around evidence rather than argued harder. |
| Operator cannot name three candidate buyers | `career`, then `design` | The binding constraint is the operator profile, not the market. |

Design never promotes a gate. If the direction is certified and only its wording is in question, the fix is `reconcile`, not another design run.

## 2. Situation audit (6 lenses)

Every play in §5 traces to at least one row here. The audit is about what exists today, not about what the operator hopes to build.

| Lens | Question | Evidence to collect | Grade to aim for |
|------|----------|---------------------|------------------|
| **Assets** | What can be sold before any new work? | Delivered work with scope, number, and date; named referrers; owned audience or list; reusable process, code, dataset, template; tooling fluency plus the QA story that makes the output safe | A on delivered work, B on audience figures |
| **Demand signals** | Who already pays to have this solved? | Live job posts naming the problem; competitor and incumbent pricing pages; invoices or quotes the buyer has already paid; a budget line named on a call | A on a paid artefact, B on dated research of the same population |
| **Constraints** | How many hours, and how many months, are actually available? | Two weeks of calendar; runway arithmetic (cash ÷ monthly burn); contract clauses on notice and non-solicit; care and financial obligations | A on the arithmetic and the contract text |
| **Traction** | What has already been sold, attempted, or answered? | Pipeline rows; inbound messages with dates; proposal outcomes; list replies; clients who re-bought or referred | A on the operator's own records |
| **Timing** | Why now, and which dated change makes now different? | Regulation with an effective date; platform policy change; budget or funding cycle with a date; tool release that changes the cost to serve; incumbent repackaging | B minimum — a "why now" without a date is a mood, grade D |
| **Identity** | What will the operator not do, and not become? | Work already quit or refused; exclusions (travel, cold calls, on-camera); whether employment stays open; reputational limits | A on the operator's own stated exclusion |

- **An audit with no A/B-grade row is a hypothesis set, not an audit.** Say so in the first line of `strategy/situation-audit.md` and label everything downstream `provisional`.
- Grade the claim, not the lens: one lens can be A on its first row and D on the rest.
- Each lens closes with one line of consequence — the asset it contributes, the signal it contradicts, or the play it removes. A lens with no consequence for a play was not needed.
- An asset the demand signals do not pay for is a finding, not a footnote. It removes plays; it does not get argued back in.
- Contradictions are recorded, not resolved in prose. They are the raw material of the ranking.

## 3. Business-model archetypes

The archetype fixes the cash timing and the capacity ceiling of a play. Revenue shapes are formulas, not forecasts: fill them from §10.

| Archetype | Revenue shape | Cash timing | Capacity ceiling | When it fits | Typical failure |
|-----------|---------------|-------------|------------------|--------------|-----------------|
| **Solo services (fixed price)** | One fixed price per engagement | 50% on signature, 50% on completion; 25/25/50 when the engagement exceeds 30 days | Delivery hours per month ÷ hours per engagement | A bounded, provable outcome one person can deliver | Price set from cost, so overruns consume the margin |
| **Productized service** | One written scope, one price, repeated; optional tier with a recommended option | Deposit before start; same 50/50 or milestone split | Concurrency: days in the cycle × clients in flight | The same problem recurs across many buyers and the scope can be written once | Per-client exceptions turn the product back into bespoke work |
| **Retainer** | Fixed monthly fee for a defined scope and response window — never hours × rate | Billed in advance monthly, with a stated exit | Reserved hours per month × clients; support load is the real ceiling | The buyer needs continuity rather than a project | Loose scope turns the month into a subscription to the operator's attention |
| **Product / SaaS** | Seats or usage × monthly price | Monthly in arrears; churn compounds and payback arrives later than services | Support and infrastructure per account, plus acquisition spend per month | The problem repeats without the operator in the loop and a tool is acceptable | Building before a manual version has been paid for |
| **Marketplace / community** | Take rate × transaction volume, or membership fee | Volume first, revenue later; both sides must clear | Liquidity and moderation hours | Both sides already gather somewhere the operator can reach | Cold start: no revenue until the harder side is supplied |
| **Licensing / reselling** | Licence fee × seats, or margin on resale | Upfront or annual; delivery is support, not build | The partner's price list and capacity bound both margin and volume | A proven third-party product the operator can configure or support | The partner reprices, bundles, or sells direct |
| **Hybrid services + product** | Services revenue funds a productised layer (tool, template, dataset) | Services cash first, product revenue later | Delivery hours plus product support | Services prove the problem and the product removes the delivery cost | Two operating models run at once and neither gets enough attention |

- Every archetype is quoted fixed-price, milestone-gated, per `standards/20260621-PRICING-STANDARD.md`. Hourly is not an archetype; it is the absence of one, and it is banned.
- Compare archetypes on contribution, not price: `contribution = revenue − direct cost` (subcontractors, tools, payment fees). Compute an internal effective rate (`price ÷ delivery hours`) to compare them, and never quote it to a buyer.
- Never discount to fit a band; reduce scope. A price band that only works at a discount is not a band.

## 4. Competitive alternatives map

One map per play. The buyer is choosing between these rows, not between us and a named competitor.

| Alternative the buyer uses today | What it costs them (graded) | How fast it can start (directional) | Why it fails | Our wedge |
|----------------------------------|-----------------------------|-------------------------------------|--------------|-----------|
| **Do nothing** | The buyer's own monthly loss from the problem, stated on a call (A); an operator estimate is C at best | No delay, no decision | The cost stays invisible until it becomes a crisis; nothing is owned; the problem grows with headcount or volume | A number for the cost, and a fixed price below it |
| **DIY + AI** | Tool subscription (A from the vendor's live page) plus the buyer's own hours (A when they state them) | Starts today; lands whenever the buyer's attention allows (directional) | The buyer's time is the scarce input; output is unmaintained and untested; the second iteration costs more than the first | Governed delivery: someone accountable for the outcome and its maintenance |
| **Hire in-house** | Salary + benefits + tooling + ramp + management time — A only when the buyer states their number, otherwise C | One to two hiring cycles (directional) | Salary commits before the problem is understood; one hire covers one skill; the context leaves with the hire | Fixed price, defined end, no headcount commitment |
| **Freelancer** | A day rate × their stated hours, or a fixed quote the buyer already holds (A from that quote) | Days to weeks (directional) | One pair of hands, no QA, no escalation path; the buyer manages the work | The same speed with delivery discipline and a second pair of eyes |
| **Agency** | Project fee or retainer plus account overhead (A from a proposal the buyer has seen) | Weeks to months (directional) | Coordination cost, junior execution, and the buyer still owns the outcome | Senior attention at a fixed price with no account layer |
| **Incumbent product** | Subscription + integration + switching effort (A from the live pricing page) | Immediate — already in use | One shape for every customer; the gap is the buyer's to absorb and the roadmap is not theirs | The gap the product will not close |

- **"Do nothing" is always the real competitor.** If the cost of doing nothing is not higher than our price, the deal does not exist: the play moves to an educate-first pile and scores no more than 2 on speed to first revenue.
- The buyer's number beats our model. The cost column reads A only when the buyer said the figure or sent a document containing it.
- A row that cannot be filled for a play is the play's first test, not a gap to paper over.

## 5. Play generation rules

- **Five to eight plays.** Fewer than five means the audit was too narrow to generate options; more than eight means it was too vague to constrain them.
- **Distinctness:** every play differs from every other on at least one of buyer, offer, or channel. Two plays that differ only in price or wording are one play with a range.
- **Six fields per play:** buyer (role plus company context), problem (root cause, under 14 words), offer shape (what is delivered and what ends), channel (one primary, at the Element 4 minimum cadence), price band (2-4x spread, never hourly), business model (one archetype from §3).
- **Parent row required:** each play cites the audit row that produced it. A play whose parent is C/D is labelled `hypothesis to validate` in the design record and cannot win on asset fit alone.
- **Banned shapes:** a multi-service menu (fails certify check 7); any hourly or day-rate construct; an unfunded buyer (no budget line and no nameable cost of doing nothing); a channel the operator cannot hold at the Element 4 minimum cadence; an offer the operator cannot prove with a delivered example or a demonstrable sample.
- **Identity is a filter, not a score.** A play the operator will not execute is removed during generation with the reason recorded; scoring it and then vetoing it discredits the ranking.

| Field | Rule | Filled from |
|-------|------|-------------|
| Buyer | One role, one company context; three real people can be named (Element 1 sharpness test) | Demand signals, traction |
| Problem | Root cause in under 14 words | Demand signals: what buyers already pay to fix |
| Offer shape | What is delivered, what the buyer ends with, what is explicitly not included | Assets: what can be proved |
| Channel | One primary channel that reaches this buyer at a band they accept | Traction: where past conversations came from |
| Price band | Fixed price, 2-4x spread, floor above the internal effective rate | §10 arithmetic |
| Business model | One archetype, with its cash timing and capacity ceiling | §3 |

## 6. Scoring rubric (6 criteria, default weights)

| Criterion | A 5 looks like | A 1 looks like | Weight |
|-----------|----------------|----------------|--------|
| **Speed to first revenue** | A paying buyer can exist inside the operator's runway without new assets; the first invoice is one signed scope away | Revenue depends on an audience, a product, or a proof point that does not exist yet | 25 |
| **Asset fit** | The play sells an asset that already exists — delivered work, relationships, process, audience — and needs no new capability | The play needs a capability, credential, or proof the operator has never produced | 20 |
| **Buyer accessibility + budget** | Reachable on a channel the operator already uses, with a budget line and a named decision-maker | The buyer is a category, has no budget line, or needs a committee the operator cannot reach | 20 |
| **Defensibility** | At least one moat from §9 with evidence behind it — proof, relationships, switching cost | The offer is a price and a promise anyone can repeat | 15 |
| **Evidence strength** | The play's load-bearing claims are A/B rows | Every claim is C/D or unknown | 10 |
| **Capacity fit** | Delivery at the base case fits available hours, with room for one more client | Base-case demand already exceeds capacity | 10 |

- **Weights are set before any score is seen**, and recorded in that order in `strategy/design-record.md`. If a weight moves after a score is visible, the run restarts.
- `weighted total = Σ(score × weight ÷ 5)`, maximum 100. Scores are integers 1-5; no halves, no decimal precision the evidence cannot support.
- **Every score carries a one-line justification and an evidence grade** (A-D). A score without both is not a score.
- **A criterion scored 4 or 5 on C or D evidence is capped at 2.** The cap is applied before totals are summed, and it is shown in the record.
- A criterion the audit cannot evidence scores 1, not 3: the default is not neutral, and 3 is where unevidenced claims get laundered.
- Criteria apply to every play. A criterion written for one play turns the rubric into a justification; add it only if it changes the ranking.

## 7. Selection, sensitivity, and what would have to be true

| Rule | Applied as |
|------|------------|
| **Order** | Every play ranked by weighted total, highest first |
| **No ties** | Equal totals break on evidence strength, then speed to first revenue; record which rule broke it |
| **Margin** | The winner must beat the runner-up by at least 5 weighted points |
| **Inside the noise** | A margin under 5 means the scoring cannot separate the plays: the sensitivity analysis decides, and the record names the criterion that decided it |

**Sensitivity.** For each criterion, move the winner down 2 points and the runner-up up 2, leaving every other score unchanged, then re-total.

- Any criterion whose swing changes the order is a fragile assumption rather than a rounding error. List them.
- Test the largest-weight fragile criterion first, and report each flip as criterion, both totals after the swing, and the resulting winner.
- The answer to "which single score, if off by 2, flips the winner" is that list; one criterion is the answer only when exactly one flips.
- A play that wins only when one criterion is moved is a tie with a favourite.

**What would have to be true (WWHTBT).** Numbered conditions for the winner only. Each maps to one assumption-ledger row, one cheap test, and one date. Cap at five, ordered by blast radius per the ledger's `If wrong` column. A condition with no test is a wish; a test that cannot fail is a demo.

| # | Must be true for the winner | Ledger row | Cheapest test | Fail by |
|---|-----------------------------|------------|---------------|---------|
| 1 | The buyer will pay the floor of the band without a discount | price: willingness to pay | 5 discovery calls; ask what they spent on the problem last quarter; 3 of 5 name a figure above the floor | date |
| 2 | The primary channel produces qualified conversations at the Element 4 cadence | channel: reach and volume | 20 touches or 2 weeks of the cadence, count conversations not impressions | date |
| 3 | The cost of doing nothing exceeds the price for this buyer | problem: cost of inaction | 3 calls; the buyer states a monthly loss above price ÷ payback months | date |
| 4 | Delivery fits available hours at the base case | capacity: hours per engagement | one delivered engagement, hours logged against the quote | date |
| 5 | The moat named in §9 can be evidenced within the review window | moat: evidence row | the artefact or the named reference exists and is dated | date |

## 8. Pre-mortem (kill signals)

Likelihood is `directional`: a judgement for ordering attention, not a forecast. The signals are the instrument; the letters are not.

| Failure mode | Likelihood (H/M/L) | Earliest observable signal | Pre-committed response |
|--------------|--------------------|---------------------------|------------------------|
| Buyer doesn't buy | H | Fewer than 2 discovery calls booked in 30 days, or 5 calls with no request for scope | Stop outreach on this buyer, re-open the runner-up play before the review date |
| Channel doesn't reach | H | First 20 touches produce no reply and no referral; platform data shows the buyer is not there | Cap spend at the test budget, move the offer to the runner-up's channel |
| Price too high | M | The first 5 conversations end on price before scope; a discount is requested before deliverables are seen | Hold price, cut scope, or re-target the buyer; never discount |
| Capacity | M | Delivery passes 60% of quoted hours with 40% of scope complete; two consecutive weeks with no business-development block | Raise the floor, reduce scope per engagement, or decline the next engagement — a waitlist is a price signal |
| Delivery / quality | M | A deliverable is reworked after handover; the operator is the bottleneck on every task | Cut the offer to what one person can prove, and price QA time into it |
| Competitor / incumbent response | L-M | The incumbent ships the equivalent feature; the buyer says the existing provider now covers it | Move the wedge to the gap the incumbent will not close — custom fit, accountability, speed — and record the date |
| Platform / algorithm risk | M | Reach or inbound from the primary channel falls 3 consecutive weeks after a format or policy change | Keep one direct channel warm (list, past clients); re-weight the channel before changing the offer |
| Legal / compliance | L | Counsel or procurement flags a clause; a licence or insurance requirement appears in the contract | Do not start; fix the agreement or walk, and record the constraint in the audit |
| Cash timing | M | The deposit does not arrive before the start date; a milestone slips past 30 days | Stop work at the milestone, invoice per the standard, hold final assets until payment clears |
| Operator energy / commitment | M | Two consecutive weeks of missed business-development blocks, or attention moving to a competing project | Cut to one play at one cadence, or park the strategy with a date instead of letting it decay |
| Proof gap | H | The same proof question appears in 3 of the first 5 calls and cannot be answered with a deliverable, a number, or a reference | Make the first engagement a paid diagnostic sized to produce the missing proof, and price it as one |

- **A kill signal must be observable inside the decision's review window.** "Engagement is low" is not observable; "fewer than 2 discovery calls booked in 30 days" is.
- Each signal carries a number and a window, and each response is an action, not a sentiment.
- Every response lands in the decision row's `Kill / review trigger` before launch (§12).
- A pre-mortem written after launch is a post-mortem with better grammar: none of these responses can be triggered retroactively.
- A response that needs an unfunded decision — hiring, borrowing, relocating — is decided now, not assumed available at the moment of failure.

## 9. Moat / durability taxonomy

| Mechanism | What makes it real | How fast it can be copied (directional) | Evidence it exists |
|-----------|--------------------|------------------------------------------|--------------------|
| **Proof / case studies** | A named client, a number, and permission to cite | One reference call, if the buyer takes it | Case study file with client, scope, result, date; a reference who answers email |
| **Proprietary process or asset** | A documented method, codebase, dataset, or template that shortens the second engagement | One project cycle, if the method is visible in the output | The asset itself, plus the measured time or cost it removes in delivery |
| **Accumulated relationships** | Buyers who take the call because of the last engagement | Not copyable, but it moves with the person | Repeat and referral share of the operator's own pipeline (A), by name |
| **Switching cost** | The buyer's cost to leave: integration, data, training, dependency on a named person | One replacement cycle plus the buyer's internal cost | A renewal or extension already signed; the list of things only this operator maintains |
| **Distribution / audience** | An owned channel holding the buyer's attention | Slowly, and only by buying the same attention | List size and reply rates; inbound attributed to the channel last quarter |
| **Speed / QA discipline** | A delivery promise kept under load, verified by output | Immediately in the claim, slowly in practice | Defect, rework, and on-time records from the operator's own delivery |
| **Regulated trust** | A licence, certification, insurance, or audit right procurement requires | At the speed of the qualification, if at all | The certificate, policy, or register entry, with its expiry date |

- A moat whose evidence cell is empty is an assertion: delete it from the record rather than softening it.
- Name the one moat the winner builds first, and the action that builds it. A moat not being built is a hope with a taxonomy.
- Some plays need no moat — a two-way trade on speed. If the winner has none, say so and set the review date short enough that speed must arrive before the moat question does.

## 10. Sensitivity / breakeven worksheet

Fill every line from evidence, then run the sheet three times: pessimistic, base, optimistic.

| Line | Formula | Tag |
|------|---------|-----|
| Price per engagement (or monthly fee) | `P` | measured / estimated / assumption / unknown |
| Deals or paying accounts per month | `D` | as above |
| Revenue per month | `P × D` | as above |
| Delivery hours per engagement | `H` | as above |
| Available delivery hours per month | `C` | as above |
| Maximum deals per month at capacity | `C ÷ H` (for subscriptions, `C ÷ support hours per account`) | as above |
| Direct cost per engagement | `Dc` (subcontractors, tools, payment fees) | as above |
| Contribution per engagement | `P − Dc` | as above |
| Fixed monthly cost | `F` (draw, tools, insurance, subscriptions) | as above |
| Breakeven deals per month | `F ÷ (P − Dc)`, rounded up | as above |
| Months to first revenue | `T` | as above |
| Runway | `R` (months of `F` funded by cash) | as above |
| Survival | `T < R`, and breakeven ≤ `C ÷ H` | verdict |

| Required output | Produced by | Failure sign |
|-----------------|-------------|--------------|
| Pessimistic / base / optimistic revenue | The revenue formula run three times, changing only inputs that carry A/B evidence | Pessimistic revenue below `F`; breakeven above the channel's realistic deal production |
| Breakeven deals per month | `F ÷ (P − Dc)` | Breakeven exceeds maximum deals at capacity (`C ÷ H`) |
| Most-sensitive variable | Elasticity of breakeven to each input: `(Δbreakeven ÷ breakeven) ÷ (ΔX ÷ X)`; the input with the largest absolute value | The top variable is graded C/D or `unknown` |
| Value at which the strategy stops working | The most-sensitive variable's value at which breakeven exceeds capacity, or `T` reaches `R`, whichever binds first | The walk-away value sits inside the range the operator would plausibly accept — the strategy is already lost |

- Run the pessimistic column with the worst inputs that have evidence behind them, not the base case minus a haircut.
- Every figure carries its Document clarity tag (`measured` · `estimated` · `assumption` · `unknown`), per Element 8.
- If the most-sensitive variable is `assumption` or `unknown`, the worksheet is provisional and that variable becomes WWHTBT condition 1.
- The walk-away value is what makes a decision one-way. If the strategy works only outside the plausible range of its most-sensitive variable, stop before selecting, not after.

## 11. Design anti-patterns

1. **Single-idea anchoring** — the audit is written around the play the operator already wants, so every lens finds support for it. **Fix:** write the plays before the audit summary, and keep one row that argues against the favourite.
2. **Criteria fitted to the favourite** — a criterion is added or reweighted after the scores are visible, so the preferred play wins by construction. **Fix:** fix criteria and weights first; restart the run if either moves.
3. **Scores without grades** — justifications read as reasoning while carrying no A-D grade, so a press release and a call note score the same 4. **Fix:** a score without a grade is not counted, and any score above 3 resting on C/D is capped at 2.
4. **No do-nothing competitor** — the map lists rivals but never the buyer's option to spend nothing, so the deal looks easier than it is. **Fix:** make do-nothing row 1, with the buyer's own cost figure or an explicit unknown.
5. **Moat by assertion** — quality and trust are listed as durable advantages with nothing in the evidence cell. **Fix:** delete any moat whose evidence cell is empty; a mechanism without a file, a name, or a number is not a moat.
6. **Pre-mortem after launch** — the failure list is written once results are known, so it records what happened instead of what to watch. **Fix:** write it before the first outreach, and attach each signal to the decision row before the row is filed.
7. **Forgotten rejects** — the runner-up is deleted after selection, so a failed winner restarts the whole design. **Fix:** keep every play with its score and a re-entry condition — the observable event that puts it back on the table.
8. **Unbounded pilot** — the chosen play is "tested" with no end date, no spend cap, and no pass threshold, so it becomes the business by default. **Fix:** every pilot gets a price band, a spend cap, a review date, and a number that means stop.
9. **Arithmetic only for the winner** — economics are modelled after selection, so the ranking compares a costed winner against uncosted alternatives. **Fix:** run §10 for the top two before the ranking is final.
10. **Grades without artefacts** — an A-grade row has no file, URL, quote, or call note behind it, only a memory of one. **Fix:** every A/B row names its artefact in the audit, and a row that cannot name one is graded C.

## 12. Handoff

| Artifact | Contains | Consumed by |
|----------|----------|-------------|
| `strategy/situation-audit.md` | Six lenses with grades, contradictions, and the no-A/B-row verdict when it applies | `greenfield - from`, `probe`, certify check 3 |
| `strategy/design-record.md` | Plays, pre-set weights, scores with justification and grade, ranking, sensitivity, WWHTBT, pre-mortem, moat, worksheet | `greenfield - from strategy/design-record.md`; re-entry conditions are read by `amend` after a failure |
| `## Strategy bets` in `strategy/one-pager.md` | The winner in one table: play, price band, channel, first test, review date | brand, pricing, and content skills |
| One row in `decisions/DECISIONS.md` | Expected outcome, confidence, reversibility, kill/review trigger, review by | `@biz-review quarterly` |

Flow: `@biz-strategy design` → `@biz-strategy greenfield - from strategy/design-record.md` → `@biz-strategy certify`. The assumptions from §7 go to `@biz-market-validate test` before certification when they are load-bearing and C/D-graded.

- Design never promotes a gate, never writes `certification.md`, and appends exactly one decision row — choosing a direction is consequential per `CONVENTIONS.md` § Decision loop.
- A design record without a scoring table is an opinion list, and certify will not read it as evidence.
- If certification has already passed and the winner changes, that is `@biz-strategy amend` with the design record attached, not a second design run in place.
