# Career search — playbook

The decision models behind `@biz-career`. The skill holds the procedure; this document holds the **method and its evidence**, so a resume or a search plan can be defended rather than asserted. Every market claim here names its source row in `docs/sources/verified-sources.md` § Job search / § Resume, with the grade and date. Where the evidence is thin, it says so — a career decision made on a plausible story and a career decision made on a measured one deserve different confidence.

---

## 1. The shape of the problem

A job search is a **funnel with a fixed weekly budget**, not a lottery. Three numbers decide the outcome:

```
conversations/week  ×  conversion to interviews  ×  conversion to offers  =  offers/quarter
```

The operator controls the first term almost entirely, the second partly, the third least. Most failed searches optimise the term they control least: they increase *applications* (which feed a low-conversion stage) instead of *conversations* (which feed a high-conversion stage).

**What the verified evidence says about volume.** The cleanest peer-reviewed result available — Kuhn & Skuterud, *AER* 94(1), 2004 (grade B, dated) — found that internet job-board searchers looked faster at re-employment but that the advantage **disappeared, and sometimes reversed**, once selection was controlled: the people who search online differ from those who do not. That is a 2004 result about 1998–2000 data; it does not prove today's boards are useless, and it should not be quoted as a current rate. What it does establish is that **"more applications" is not a self-evidently effective strategy**, so it cannot be the default without local evidence.

**What the method literature converges on.** The verified practitioner methods — Dalton's *2-Hour Job Search* (grade A, method page) and Terry's *Never Search Alone* (grade C, practitioner) — are both built around a **small, ranked target list plus human contact**, not application volume. That is method consensus, not measurement. Treat it as the default hypothesis and test it in the operator's own search, which produces grade-A evidence about them.

**Therefore.** The search plan sets a target list (20–40), a route per row, and a conversation quota per week. Applications are the fallback channel, not the engine. The plan carries a **kill signal** — fewer than *n* substantive conversations in *n* weeks changes the channel, not the effort.

---

## 2. Channel selection without invented numbers

| Channel | What we can defend | What we cannot |
|---|---|---|
| Warm referral / alumni network | The mechanism is trust transfer; the method literature and the AER result both point at human contact over board volume | Any conversion percentage — unverified (see catalog § Unverified 5–7) |
| Direct approach to a hiring manager with relevant proof | The mechanism is specificity: relevant evidence shortens the screener's decision | Response rates |
| Niche communities and specialist boards | Reach is concentrated; the operator's own effort is traceable | Whether a given community converts |
| Recruiters (agency / in-house) | They have the requisition; they are a distribution channel for the operator's evidence | That they will represent the operator well; they serve the client |
| General applications at volume | It is the cheapest to start and the most measurable | That volume beats targeting — the AER result is the best available caution |

**Rule.** A channel enters the plan only with (a) a named route and (b) a weekly hour budget the operator can actually hold — the same capacity test as `@biz-strategy` Element 4. A channel with no route is a wish; a channel with no hours is a fiction. If the arithmetic does not fit the budget, cut a channel rather than thinning all of them.

---

## 3. How a resume is actually read

**The verified model is human attention, not machine rejection.** The best available evidence (Ladders eye-tracking, 2018, via HR Dive — grade C, attention data only) is that an initial screen lasts on the order of **7–8 seconds**, and that fixations concentrate where layout gives them somewhere to land: clear section headers, a top-left-to-bottom-right reading path, bold role titles, bulleted accomplishments. Multi-column layouts, dense paragraphs and missing headers lose the eye.

What that model implies, and what it does not:

| Implication | Status |
|---|---|
| Put the decision-carrying requirement in the top third of page one | `directional` — follows from where attention lands, not from callback measurement |
| Use standard section headings and a single column | `directional` — same basis; also plain mechanics for any parser |
| One claim per bullet, with the evidence attached to the claim | `directional` — see §4 |
| "ATS auto-rejects X%" | **Unverified — do not state.** Every figure traced was vendor-published and unreadable |
| "Keyword matching raises callbacks by Y%" | **Unverified — do not state** |

**The honest conclusion:** design the resume for a fast, pattern-seeking human and keep the file machine-readable because that is cheap insurance — not because a specific rejection rate has been measured. A framework that invents the number to justify a layout is doing the same thing bad sales copy does.

---

## 4. Elaboration without invention

"Elaborate my resume" is the request where fabrication happens, usually with good intentions. The line is simple: **elaboration is the work of recovering evidence, not of inventing it.**

### The recovery ladder

When a role feels thin, before writing a single new claim, exhaust these in order:

| Step | Question | Output |
|---|---|---|
| 1 | What artefact exists? (repo, ticket system, dashboard, incident log, budget, org chart, contract) | A scope figure with a source |
| 2 | What did the artefact contain in the period? | Counts: services, users, deploys, tickets, incidents, seats, regions |
| 3 | What changed while you owned it? | Before/after on one metric, or an observable state change |
| 4 | Who can confirm it? | A reference, or a document the operator can show |
| 5 | What did you decide that someone else would not have? | The judgement, which is the part interviews test |

Only what survives step 5 belongs in a bullet. The rest is context, and context is what an interview is for.

### Worked shapes

| Weak (claim) | Legitimate elaboration |
|---|---|
| "Improved system performance" | "Cut p95 checkout latency from 1.8 s to 240 ms over 6 weeks by reindexing the order store and adding a read replica (scope: 3 services, ~40 deploys/week)" |
| "Responsible for cloud infrastructure" | "Owned 14 services across 3 AWS accounts: 99.95% monthly availability, on-call rotation of 5 engineers, ~$38k/month spend" |
| "Worked on data pipeline" | "Rebuilt the nightly ETL from cron + scripts to Airflow; job failures fell from ~6/week to <1/week over one quarter (team of 3)" |
| "Helped migrate to Kubernetes" | "Led the Kubernetes migration for 22 services across two quarters: cut deploy time from 25 min to 4 min, rollback from an hour to under 5 minutes" |
| "Passionate about security" | "Ran the SOC 2 Type II readiness programme: 34 controls closed, zero findings at audit; owned the evidence trail" |

**Scope statements are legitimate when numbers are not recoverable.** "Owned 14 services, 40 deploys/week" is evidence about size and responsibility. "Delivered impactful solutions" is not evidence of anything.

**Never:** a percentage with no basis, a title the employer did not give, a client name under NDA, a date shifted to hide a gap, a credential not held. Each one converts a survivable gap into a disqualifying integrity problem the interview or the reference check will find.

---

## 5. Interview: answer the scoring rubric

Structured interviews score answers against predefined competencies (U.S. OPM, grade A — government assessment guidance). Two consequences:

1. **Prepare by competency, not by question.** For each decision-carrying requirement in the job description, one story that evidences it. A generic "tell me about yourself" answer is the least valuable preparation.
2. **Evidence beats assertion, and work samples beat both.** OPM's assessment-method guidance treats work samples as a distinct, competency-based method; where the employer allows it, a portfolio piece or a take-home artefact competes against someone's claim and wins on the same rubric.

**Story anatomy** (the skill's story bank uses this): situation → the decision you made → the action → the outcome with a number → what you would do differently. The last clause is what separates a senior candidate from a recitation; include two failure stories, because a candidate with no failures reads as either junior or evasive.

**Gap answers.** "I have not done X. Here is the nearest thing I have done, here is how I would close the gap in the first 30 days" is a stronger answer than a bluff, and it is the only answer consistent with a resume that tells the truth.

---

## 6. Negotiation: the barrier is behavioural

The best available experiment (Cullen, Pakzad-Hurson & Perez-Truglia, NBER WP 33903, 2025 — grade B, field experiments, 3,100+ tech job seekers) found that **light-touch encouragement raised both negotiation attempts and compensation gains**, while a substantial discount on negotiation *coaching* did not significantly change attempts.

The practical reading: the binding constraint is usually **whether the candidate asks**, not whether they know the tactics. So the plan is a pre-commitment, not a study session:

1. Write the floor and the ask **before** the offer exists (floor from `reference/OPERATOR_PROFILE.md`; the ask anchored to the catalog's compensation evidence or the operator's own quotes).
2. Clarify level and scope before talking numbers — a level moves more than a base bump.
3. One consolidated counter with a rationale tied to scope and evidence. Trade, don't stack small asks.
4. Never bluff a competing offer: it is checkable and it contaminates the reference relationship.
5. Record the decision (`decisions/DECISIONS.md`) with a falsifiable expected outcome and a review date — the only way the next negotiation is better informed than this one.

Grades matter here: equity valuation and strike are **Unverified** unless the operator holds the documents, and an offer's "total compensation" is a projection, not a number, until the vesting schedule is in writing.

---

## 7. Anti-patterns

1. **Application-volume theatre** — 200 applications, three conversations. **Fix:** conversation quota, target list, route per row.
2. **The generalist resume** — one CV for every role, which fits none. **Fix:** one draft per archetype, mirrored vocabulary, same evidence.
3. **The keyword carpet** — terms added without proof. **Fix:** keyword **and** evidence, or neither.
4. **The invisible senior** — 15 years compressed into responsibilities instead of scope and outcomes. **Fix:** the recovery ladder; lead with scope.
5. **The apology resume** — the gap explained in the summary. **Fix:** one factual line; let projects and skills carry continuity.
6. **Interview improv** — preparing "strengths and weaknesses". **Fix:** competency map from the job description, story per competency, two failures.
7. **Negotiation by hope** — accepting the first number to avoid awkwardness. **Fix:** floor written in advance; one counter; the NBER result says asking is the lever.
8. **The unloved proof** — a portfolio nobody can find, a reference nobody asked. **Fix:** `@biz-brand overhaul` puts the proof where the buyer looks.

---

## 8. Handoff

| Output | Consumed by |
|---|---|
| Role archetypes, channel plan, target list, cadence + kill signal | `@biz-career search`, reviewed weekly |
| Evidence inventory (scope, numbers, references) | `@biz-career resume`, `@biz-brand`, `@biz-proposal` (as proof), `@biz-strategy career` |
| Story bank + gap answers | `@biz-career interview` |
| Offer evaluation + decision row | `decisions/DECISIONS.md`, `@biz-review quarterly` |

Flow: `@biz-strategy career` (profile) → `@biz-career search` → `@biz-career resume` → `@biz-career interview` → `@biz-career negotiate`. The public-facing version of the same evidence is `@biz-brand overhaul`; the consulting-facing version is `@biz-proposal write`. They must not contradict each other — a resume claiming one thing and a sales page another is a credibility problem in both markets.
