---
name: biz-career
description: >-
  Job search and resume craft for a senior IT professional or operator. Builds a
  targeted search (role archetypes, channel plan, 20-40 company list, weekly
  cadence with a kill signal), elaborates a CV/resume that survives screening
  (evidence-first bullets, quantified scope, honest elaboration of thin
  experience, ATS-safe structure, role-tailored keywords), prepares the interview
  story bank and narrative, and evaluates offers. Reads the operator profile and
  project memory so nothing is invented. biz-career search, biz-career resume,
  biz-career interview, biz-career negotiate, biz-career status. No gate.
---

# biz-career

**Canonical path:** `.ai.biz/skills/biz-career/skill.md`

The rest of Business OS answers **"what should I sell"**. This skill answers **"what should I be hired to do"** — the search, the resume, the interview, and the offer — for an operator whose marketable asset is IT capability: engineering, platform, data, security, or technical leadership.

The two are not separate lives. An operator running or considering independent consulting is usually also in a job market; a resume is a positioning document with the same buyer problem as an offer; and a strong search produces the proof points that make the consulting offer credible. This skill keeps the two records consistent instead of letting the CV contradict the strategy.

**Playbook:** read `concepts/career-search/prompt.md` (BIZ-13) before running — it carries the funnel model, the channel evidence, the resume-reading model, the evidence-recovery ladder, the interview scoring logic and the negotiation findings. This skill defines the **procedure and the files**; the playbook defines the **method**.

**Evidence discipline applies here as everywhere.** Hiring-market claims — salary bands, callback rates, ATS behaviour, recruiter response times — are exactly the kind of numbers that get repeated from memory. They carry a citation or an explicit `directional` marker, and a grade per `CONVENTIONS.md` § Evidence grades. The verified source base is `docs/sources/verified-sources.md` § Job search and § Resume (including its **"what the evidence does not support"** section — no ATS-rejection percentage, no referral-conversion number, no measured callback effect for keyword matching). If a claim is not there or cannot be checked, mark it **Unverified** and say so rather than improving the claim.

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-career search` | Build role archetypes, channel plan, target company list, and a weekly cadence with numbers and a review date. |
| `@biz-career search - <role or field>` | Same, constrained to a named role family (e.g. "staff platform engineer", "fractional CTO"). |
| `@biz-career resume` | Elaborate and restructure the existing CV/resume against the target roles. |
| `@biz-career resume - <role or JD>` | Target one specific role or job description; mirror its vocabulary truthfully. |
| `@biz-career interview` | Build the story bank and narrative; rehearse against the target role's likely questions. |
| `@biz-career interview - <company or JD>` | Rehearse against one company/role. |
| `@biz-career negotiate - <offer>` | Evaluate an offer (comp, level, equity, scope, risk) and prepare the conversation. |
| `@biz-career status` | Read-only state report. |

**Default:** `status` if no verb matches. **Aliases:** `cv`, `job-search` → `search`.

**Routing boundary.** `biz-career` does not replace `@biz-strategy career` (skills, proof points, constraints, career-direction read → `reference/OPERATOR_PROFILE.md`), `@biz-brand` (LinkedIn/website positioning), or `@biz-advisory` (messy "should I take this job or keep consulting?" — that is advice, then this skill executes the chosen path). When the request is really "which of these two lives do I want", route to `@biz-advisory` first.

---

## Work tree

No new directories, no new scaffold files — career work reuses the existing tree so a bootstrapped project needs no re-bootstrap:

| Artifact | Location | Written by |
|---|---|---|
| Operator profile (skills, proof points, constraints, risk, stage) | `reference/OPERATOR_PROFILE.md` | `@biz-strategy career` (this skill reads it; it may append verified proof points) |
| Search plan: role archetypes, channel plan, target list, cadence, kill signal | `plans/career_search.md` | `search` |
| CV/resume draft, per target role | `drafts/draft_cv_<role>.md` | `resume` |
| Interview story bank and narrative | `plans/career_search.md` § Story bank (one file, so the search and the stories cannot drift) | `interview` |
| Offer evaluation | `plans/career_search.md` § Offers | `negotiate` |
| Decision (search primary/parallel, accept/decline, direction change) | `decisions/DECISIONS.md` | the mode that reaches it |
| Gate state | `gates.md` | untouched — this skill promotes nothing |

---

## I0 — Context contract (run before any mode)

Load in priority order; stop when you have enough, and say what you have:

| # | File | What it gives |
|---|------|---------------|
| 1 | `reference/OPERATOR_PROFILE.md` | What can be proven, and the constraints that make a role feasible or not (hours, travel, on-call, location, runway) |
| 2 | `reference/PROJECTS.md` | Delivered work with scope and dates — the raw material for resume bullets |
| 3 | `strategy/one-pager.md`, `strategy/offer-scope.md` | The current positioning; the CV must not contradict it, and must not be a copy of a sales page |
| 4 | `decisions/DECISIONS.md` | Live decisions this search must respect (e.g. "independent consulting primary until Q3") |
| 5 | `plans/career_search.md` | Existing search state; read before rewriting |
| 6 | The resume file the operator names | The artifact under edit — read it in full before proposing changes |
| 7 | `reference/BRAND_STATUS.md`, `reference/CONTENT_STATUS.md` | Public proof of work that a recruiter or hiring manager can see |

**Capability fingerprint (mandatory):** before writing a single resume bullet, establish what the operator can actually claim — a delivered scope, a number, a date, a named system, a reference. A bullet that cannot be traced to one of those is a claim, not evidence. If the operator cannot supply evidence for a role archetype, say so: that is the search's real constraint, not a writing problem.

**One consolidated question** is allowed if a missing fact would materially change the output (target compensation floor, location/work authorisation, whether employment and consulting can run in parallel). Otherwise proceed and grade the gap.

---

## I1 — `search` mode

A job search without a target list degenerates into applying. The output is a plan with numbers, not a pep talk.

### Step 1 — Role archetypes (three tiers)

| Tier | What it is | Example shape |
|---|---|---|
| **Primary** | The role the evidence supports today, at the level the proof justifies | Senior/staff engineer, platform lead, engineering manager of a small team |
| **Adjacent** | Same proof, different buying title or industry | Solutions architect, technical product, developer-experience, pre-sales engineering |
| **Stretch** | One level up or across, winnable only if a specific gap closes | Staff → principal, IC → manager, services → product |

For each: the **hiring manager** (who actually decides), the company shape (size, stage, industry), the three or four requirements that carry the decision, and the proof row that answers each. The archetype table is what turns a resume into a targeted document and a search into a list.

### Step 2 — Channel plan (with capacity, not aspiration)

Name the channels, then state what the operator can actually sustain per week — the same rule as `@biz-strategy` Element 4: a channel the operator cannot hold is not a channel. For each channel record:

```
Channel · evidence grade · volume this operator can sustain · expected first signal · stop rule
```

Channels worth considering, in rough order of trust for senior roles: warm referrals and alumni networks · direct approach to a hiring manager with proof of relevant work · niche communities and specialist boards · recruiters (agency and in-house) · general applications at volume. Do **not** assert conversion rates from memory — the catalog carries whatever is verified; anything else is `directional`.

**Volume caution:** "apply to everything" is a strategy only if the operator's time is worthless. State the weekly hour budget and allocate it; if the arithmetic does not fit the budget, cut a channel rather than thinning all of them.

### Step 3 — Target list (20–40 companies)

`.work.biz/plans/career_search.md` § Targets — one row each:

| Company | Why them (proof/traction/domain) | Role archetype | Route in (who, how) | Status | Next action · date |

Rules: every row has a **route**, not just a name — a company with no route is a wish. Prefer companies where the operator's evidence is directly relevant (same domain, same stack, same problem class). Cap the list at what the cadence can service; a 60-row list nobody touches is decoration.

### Step 4 — Cadence with a kill signal

```
Weekly: n direct approaches · n referral asks · n tailored applications · n conversations booked
Review by: <date>
Kill / change signal: fewer than <n> substantive conversations in <n> weeks → change channel, not effort
```

Record the cadence and the kill signal. If the search commits the operator to a direction — full-time primary vs consulting primary, relocation, a drop in level — append one row to `decisions/DECISIONS.md` per `CONVENTIONS.md` § Decision loop.

---

## I2 — `resume` mode

The resume has one job: make a specific reader, screening fast, conclude that this candidate has already done the thing the role needs. Every rule below serves that, and every rule can be traced to the operator's evidence.

### Step 1 — Choose the frame

Three frames, chosen by the target archetype, never mixed:

| Frame | Lead with | Best when |
|---|---|---|
| **Delivered outcomes** | Measured results and scope | IC engineering, delivery, platform |
| **Owned systems** | The system, its scale, its constraints, its reliability/security posture | Infrastructure, SRE, security, data |
| **Led people/change** | Team size, hiring, roadmap, stakeholders, org outcome | Management, staff/principal, consulting |

### Step 2 — Bullet discipline

Every bullet carries, where the operator can evidence it:

```
<Action> <object/scope> <measured outcome or observable change> <time window> <method, if it proves the claim>
```

- **Numbers first, adjectives never.** "Cut p95 latency from 1.8s to 240ms across 3 services (Q1 2025)" beats "improved performance dramatically". If no number exists, state scope ("owned 14 services, 40 deploys/week") — scope is evidence; drama is not.
- **One claim per bullet.** A bullet with three outcomes reads as three vague claims.
- **Say what you did, not what the team did**, unless the contribution was the team outcome and the role was to lead it — then say that.
- **No unsourced superlatives**: "world-class", "cutting-edge", "passionate" carry no information and cost a line.
- **Length discipline:** a resume is a scanning surface, not a biography. Conventional guidance is one page per ~10 years, two pages maximum for senior IC/management — treat as `directional`, and cut older material that adds no decision for the target archetype.

### Step 3 — Elaborate thin or non-standard experience (honestly)

This is where most career-changers and early-career operators lose credibility, and where invention is most tempting. The legitimate methods:

| Situation | Legitimate elaboration | Never |
|---|---|---|
| Responsibilities were never quantified | Reconstruct from artifacts: ticket systems, deploy logs, dashboards, incident records, budget lines. State the reconstructed scope and its source | Invent a percentage |
| Title did not match the work | Use the industry-standard title with the actual role in parentheses, and let the bullets prove it | Inflate the title |
| Work was internal/confidential | Describe the problem class, the constraint, and the measurable outcome without naming the client or the confidential detail | Claim a client or number you cannot discuss |
| Side projects, open source, teaching | A **Projects** or **Selected work** section with the same bullet discipline; link the repository or artifact | Dress a tutorial as a production system |
| Career break, caregiving, study | One line, factual, no apology; the skills section and projects carry the continuity | Hide it with fake dates |
| Contract/fractional work | Show it as engagements with client type, scope, and outcome; a fractional portfolio is a legitimate work history | Pad a short engagement |

**Truth rule (hard):** every date, title, employer, number, and credential must be verifiable by the operator if asked. A resume that survives an interview loop must also survive a reference check. When a fact is uncertain, omit it or state it as scope — never round up.

### Step 4 — Screening-safe structure

- Single column, standard headings (Summary · Experience · Skills · Education/Certifications · Projects), no text boxes, no tables carrying content, no images for meaning, dates in one consistent format. In a plain-text export it must still read correctly.
- Mirror the target job description's vocabulary for the requirements the operator genuinely meets — the same concept in the employer's words. Mirroring is translation, not addition.
- Put the requirements that carry the decision in the top third of page one.
- Keywords without evidence are a lie the interview will expose. Keyword **and** proof, or neither.
- Export a plain-text/PDF version and check it: if a parser or a human cannot read the section order, fix the file, not the reader.

### Step 5 — Deliver

Write `.work.biz/drafts/draft_cv_<role>.md` (per target role), and report:

- the target archetype the draft serves,
- the bullets rewritten and what evidence each now carries,
- **the gaps**: requirements with no proof — these become interview prep or a deliberate omission, never a fabricated bullet,
- the five probes the resume invites (questions a screener will ask), handed to `interview`.

**Completion:** the draft exists, every bullet traces to evidence or scope, no unverifiable claim remains, and the gaps are listed rather than papered over.

---

## I3 — `interview` mode

### Story bank (8–12 stories, one file)

Each story maps to a **competency the target role tests** and to a **resume bullet** — a story with no resume anchor is either a new bullet or a distraction:

| # | Competency | Story (situation → decision → action → outcome) | Metric | Resume anchor | Likely probe |
|---|---|---|---|---|---|

Rules: one story may serve two competencies, but every competency the job description names must have at least one story with a number or an observable outcome. Failure stories are mandatory — at least two, with what changed afterwards; a candidate with no failures reads as either junior or evasive.

### Narrative (90 seconds)

Who the operator is professionally, the through-line of the work, why this role and this company now, and what they are not looking for. The narrative must be consistent with the resume, the LinkedIn profile (`@biz-brand`), and the strategy offer. Rehearse it aloud; a narrative that only works in writing will not survive a call.

### Likely questions from the JD

Derive from the archetype requirements, not a generic list: for each of the three or four decision-carrying requirements, one technical probe, one scope probe ("what did you own?"), one judgement probe ("what would you do differently?"), one conflict/stakeholder probe. Prepare the honest "I have not done X, here is the nearest thing I have done and how I would close it" answer — it is stronger than a bluff and it is the answer the evidence supports.

**Completion:** story bank covers every decision-carrying requirement with a metric, two failure stories exist, the narrative is rehearsed, and the gap answers are written down.

---

## I4 — `negotiate` mode

### Step 1 — Evaluate before talking

| Dimension | Record | Note |
|---|---|---|
| Base | figure | the number that compounds; treat as the anchor |
| Bonus / variable | target vs guaranteed | separate the guaranteed part |
| Equity | grant, strike, vesting, refresh policy | valuation and strike are **Unverified** unless the operator has the documents; say so |
| Level and scope | title, team size, on-call, ownership | level beats title; ask which level the offer maps to |
| Location/remote | days on site, travel | a hidden cost that changes the effective number |
| Risk | funding runway, layoff signals, restructuring | grade it; a strong base at a company with 3 months of runway is a different offer |
| Non-compete / IP terms | read them | these can cost the consulting fallback |

Compare against the operator's **floor** (from `reference/OPERATOR_PROFILE.md`, which records the runway) and against the compensation evidence in the catalog. State the floor before the negotiation, not after — a floor decided mid-conversation is not a floor.

### Step 2 — Sequence

1. Clarify level and scope **before** negotiating the number; a level change moves more than a base bump.
2. Ask for the full package in writing; never negotiate against an incomplete picture.
3. Make one consolidated counter with a rationale tied to scope and market evidence — not a sequence of small asks.
4. Trade, don't demand: a higher base may cost the sign-on or the remote days — decide which matters and say so.
5. **Never bluff a competing offer.** It is checkable and it destroys the relationship that the reference check depends on.
6. Get the final terms in writing before resigning anything.

### Step 3 — Record

Append one row to `decisions/DECISIONS.md` when the decision is consequential (accept, decline, or a direction change): expected outcome (a number and a date, or an observable event), confidence, reversibility (`two-way` for a declined offer, `one-way` for a signed contract), kill/review trigger, review date. A negotiated offer that was never recorded cannot be scored, and the calibration is how the operator learns whether their floor and their read of the market are right.

**Completion:** the offer table is filled with every unverified figure marked, the floor and the rationale are stated, the counter is written out, and the decision row exists.

---

## I5 — `status` mode (read-only)

Report: profile presence and freshness, search plan presence (archetypes, targets, cadence, kill signal), draft CV count and which archetypes are covered, story-bank coverage against the target requirements, open offers, live decisions the search must respect, and which gap would most improve the next session. Close per the Operator handoff contract.

---

## Quality checks (run before delivering)

- [ ] Every resume bullet traces to evidence or honest scope; no invented number, title, date, or credential.
- [ ] The frame (outcomes / owned systems / led people) is consistent across the document.
- [ ] Target archetype named; the top third of page one answers its decision-carrying requirements.
- [ ] Screening-safe structure verified by a plain-text export, not assumed.
- [ ] Gaps listed explicitly, not converted into claims.
- [ ] Story bank covers every decision-carrying requirement, includes two failure stories, and is anchored to resume bullets.
- [ ] Any hiring-market claim is cited from the catalog or marked `directional`/`Unverified` with a grade.
- [ ] The search has numbers and a kill signal; a channel the operator cannot sustain was cut, not kept as aspiration.
- [ ] Consequential decision recorded in `decisions/DECISIONS.md`.
- [ ] Exactly one next action.

---

## Completion gate (cannot be skipped)

You may only claim a career task complete when all are true:

1. Context loaded per I0 (operator profile, projects, live decisions) and the capability fingerprint stated.
2. The mode's outputs exist at the paths in § Work tree.
3. No claim in the output is unverifiable: numbers are traced or marked as scope; market claims are cited or marked `Unverified` with a grade.
4. Gaps are listed with the cheapest way to close each (a project, a certificate, a reference, a portfolio piece).
5. One decision row appended when the mode reached a consequential decision.
6. Handoff to `@biz-brand` (public profile), `@biz-strategy career` (direction), or `@biz-advisory` (which life) is offered when the work converges.

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

---

## Time budget

| Mode | Time |
|------|------|
| `search` | 45–90 min (archetypes + channels + 20–40 targets) |
| `resume` | 45–90 min per target archetype |
| `interview` | 45–60 min (story bank + narrative + question bank) |
| `negotiate` | 30–45 min (offer table + counter) |
| `status` | < 2 min |

---

## Gates & dependencies

No prerequisite gate — runs any time, including before `@biz-bootstrap init` (it then asks for the resume directly and creates the artifacts on first write). It improves sharply with a filled `reference/OPERATOR_PROFILE.md`, and it feeds `@biz-strategy career` (proof points), `@biz-brand` (public positioning), and `@biz-advisory` (life-direction decisions).

| Skill | When |
|---|---|
| `@biz-strategy career` | Profile the operator first; the search consumes its proof points |
| `@biz-brand overhaul` | Once the target archetype is chosen, align LinkedIn/website to it |
| `@biz-advisory advise` | "Job vs consulting", "should I take this offer", a career fork with no obvious answer |
| `@biz-market-validate test` | Test a consulting offer while the search runs — the two inform each other |
| `@biz-sources find - hiring market` | Keep the hiring-market evidence base graded and current |
