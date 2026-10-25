# START HERE — Business operator decision tree

**Purpose:** Answer one question fast: *"What do I do right now for my business?"*

**Read this file when you sit down, are interrupted, or feel lost.**

**Rule:** If something below contradicts a `skill.md` or a binding standard, the **skill / standard wins**.

**Paths:** In a project repo, prefix with `.ai.biz/`. When Business OS **is** the git root (this repository), use `START_HERE.md`, `skills/`, `standards/` with no prefix.

---

## 0. Three things to know

1. **Truth before speed.** The agent rules in `.cursorrules` (Core Principles 1–7) are non-negotiable. Never claim "good plan" without verifying the logic.
2. **Skills do the orchestration. Standards bind the decisions.** You almost never need to read all at once — pick what your task needs.
3. **.ai.biz vs .work.biz:** skills, standards (`.ai.biz/`) vs business plans, pipeline, HANDOFF (`.work.biz/`).

---

## 1. Decision tree

```text
┌──────────────────────────────────────────┐
│  Where am I right now?                    │
└──────────────────────────────────────────┘
       │
       ├── "Bootstrap / empty .work.biz"  ──► `@biz-bootstrap init` · `bash .ai.biz/templates/bootstrap.sh`
       │
       ├── "I just opened the project / lost"  ──► §2 Resume / orient
       │
       ├── "I want to plan my strategy"         ──► §3 Strategy
       │
       ├── "I want a read on my career / what I can prove"  ──► `@biz-strategy career`
       │
       ├── "I want to fix my brand / online presence"  ──► §4 Brand
       │
        ├── "I want to publish content"           ──► `@biz-content publish` · `@biz-youtube publish`
        │
        ├── "I want social content for Reddit, LinkedIn (posts / carousels / native video), Instagram, X, Facebook, YouTube"  ──► `@biz-social write - <platform>`
        │
        ├── "I want to write an article / post / case study / email"  ──► `@biz-writing write - <topic>`
       │
       ├── "I want business / venture / pivot ideas"  ──► `@biz-ideas generate - <domain>`
       │
       ├── "I want product / service / SaaS concepts"  ──► `@biz-products generate - <space>`
       │
       ├── "What should I do? (situation advice)"  ──► `@biz-advisory - <situation>`
       │
       ├── "Is this plan realistic? / does the math work?"  ──► §3 · `@biz-strategy certify - why`
       │
       ├── "Were our past decisions right? / how accurate have we been?"  ──► `@biz-review quarterly`
       │
       ├── "Record this decision"  ──► `.work.biz/decisions/DECISIONS.md` (or `@biz-advisory` to frame it)
       │
       ├── "I need better sources / where to learn"  ──► `@biz-sources find - <topic>`
       │
       ├── "I have a sales conversation"         ──► §5 Sales
       │
       ├── "I need to review my progress"        ──► `@biz-review weekly`
       │
       ├── "I need to re-check the strategy's assumptions"  ──► `@biz-review monthly`
       │
       ├── "I'm closing for the day"             ──► §6 Close
       │
       ├── "I don't know which skill to use"     ──► `@biz-director <describe what you want>`
│
└── "I want to understand the system"     ──► §7 Reading order
```

---

## 2. Resume / orient (≤5 minutes)

| Need | Command |
|------|---------|
| **Where am I / what's next?** | `@biz-session status` + `.work.biz/gates.md` + `.work.biz/context/HANDOFF.md` + `.work.biz/plans/NEXT.md` |
| Which gates have I passed? | Read `.work.biz/gates.md`, or run `@biz-review status` to reconcile it |
| One-paragraph status (no writes) | `@biz-session status` |
| Free-text request / don't know skill | `@biz-director - <describe what you want>` · `@x-director - <describe what you want>` (cross-framework) |
| Are we still in strategy or executing? | `@biz-strategy status` **or** `@biz-review status` |
| Any decisions due for review? | Read `.work.biz/decisions/DECISIONS.md`, or run `@biz-review weekly` (flags rows past their review date) |

---

## 3. Plan your strategy

| You need… | Run |
|-----------|-----|
| To choose between several plausible directions, or to compare your current play against alternatives | `@biz-strategy design` |
| To start a brand-new business plan | `@biz-strategy greenfield` |
| Agent should ask questions until it truly understands your situation | `@biz-strategy probe` |
| To profile your skills, proof points, constraints and get a career read | `@biz-strategy career` |
| To search for a job, elaborate your resume/CV, prep an interview, or evaluate an offer | `@biz-career search` · `resume` · `interview` · `negotiate` |
| To re-validate the strategy's assumptions (monthly) | `@biz-review monthly` |
| To check if strategy is done | `@biz-strategy status` then `@biz-strategy certify` |
| To find out whether the option you rejected would have been better | `@biz-review quarterly` (counterfactual audit) |
| To set pricing for an engagement | `@biz-pricing set` |
| To test if your offer/niche works | `@biz-market-validate test` |
| To check the plan is arithmetically possible (capacity, demand, runway) | `@biz-strategy certify - why` then `@biz-strategy probe - reality` |
| To know what normally happens to plans like yours (base rate / outside view) | `@biz-strategy probe - reality` |
| To grade how strong a piece of evidence is | `@biz-sources find - <topic>` (`A`–`D` grade + freshness) |

---

## 4. Fix your brand & online presence

| You need… | Run |
|-----------|-----|
| Audit current LinkedIn, website, brand | `@biz-brand audit` |
| Overhaul LinkedIn profile | `@biz-brand overhaul` |
| Publish a LinkedIn post or article | `@biz-content publish` |
| Publish / plan YouTube videos | `@biz-youtube publish` · `@biz-youtube plan` |
| Audit YouTube channel branding | `@biz-brand audit` (YouTube section) |
| Engage in communities | `@biz-community engage` |

---

## 4b. Generate & write (no gate required)

These project-aware generative skills run any time — even before bootstrap. They load the host project's own context automatically; output improves once strategy/brand are defined.

| You need… | Run |
|-----------|-----|
| Write an article, post, case study, landing page, email, thread | `@biz-writing write - <topic>` |
| Build a content calendar / topic plan | `@biz-writing plan - <30 days>` |
| Repurpose one piece into multiple formats | `@biz-writing repurpose - <source>` |
| Critique a draft | `@biz-writing audit - <draft or path>` |
| Research trending topics/gaps on a social platform | `@biz-social research - <platform>` |
| Write platform-native social content (incl. LinkedIn video / YouTube scripts / Shorts) | `@biz-social write - <platform>` |
| Repurpose one asset into multiple platform formats | `@biz-social repurpose - <source>` |
| Plan a cross-platform social content calendar | `@biz-social plan - <30 days>` |
| Record a publish / mark a piece live ("I posted X on Y") | `@biz-social log - <piece> - <platform>` |
| Archive published content pieces (`ideas/` → `ideas.archive/`) | `@biz-archive run` (dry run: `@biz-archive status`) |
| Build a YouTube publishing calendar / 30-day challenge | `@biz-youtube plan` · `@biz-youtube challenge` |
| Business / venture / pivot ideas | `@biz-ideas generate - <domain>` |
| Stress-test one idea (try to kill it) | `@biz-ideas stress - <idea>` |
| Pivot directions from current business | `@biz-ideas pivot - <situation>` |
| Product / service / SaaS / add-on concepts | `@biz-products generate - <space>` |
| Extension concepts for an existing product | `@biz-products extend - <product>` |
| Scope a minimal MVP for one concept | `@biz-products scope - <concept>` |
| Evaluate one concept (Go/Refine/Kill) | `@biz-products audit - <concept>` |
| Situational advice — "what should I do?" | `@biz-advisory - <situation>` |
| Advisory reframe patterns (BIZ-10) | `@biz-advisory patterns` |
| Curate advisory / evidence sources | `@biz-sources find - <topic>` · `@biz-sources list` |
| Record a decision you've made | append to `.work.biz/decisions/DECISIONS.md` (or `@biz-advisory` to frame it first) |
| Score past decisions / see your calibration | `@biz-review quarterly` (Decision audit) |
| Check whether overdue decisions need scoring | `@biz-review weekly` (§ Drift check) |

---

## 5. Sales & conversion

| You need… | Run |
|-----------|-----|
| Prepare for a discovery call | `@biz-discovery prepare` |
| Run a discovery call | `@biz-discovery run` |
| Price the engagement | `@biz-pricing set` |
| Write a proposal | `@biz-proposal write` |
| Handle an objection | `@biz-objections handle` |
| Ask for referrals | `@biz-referrals ask` |
| Diagnose why nothing is moving | `@biz-pipeline-diagnosis run` |

---

## 6. Close for the day

```text
@biz-session close                      # safe default — writes HANDOFF/NEXT/UNKNOWNS to .work.biz/, no git
@biz-session close commit               # + scoped commit (target project: .work.biz/ only; source repo: all changes repo-wide)
@biz-session close commit scoped        # + commit of HANDOFF/NEXT/UNKNOWNS only
@biz-session close push                 # + scoped commit, then git push
@biz-session close commit push          # all three: write state, scoped commit, push

# mid-session checkpoints (no close, no HANDOFF/NEXT writes):
@biz-session commit                     # scoped commit (same role rule), session stays open
@biz-session commit push                # + push, session stays open
@biz-session add                        # stage the commit scope only, no commit
```

---

## 7. Reading order

| Step | File | Why |
|------|------|-----|
| 1 | `.cursorrules` | Identity, core principles, protected items |
| 2 | `README.md` | Canonical map |
| 3 | `.work.biz/gates.md` | Which readiness gates are PASS |
| 4 | `.work.biz/context/HANDOFF.md` | Last session state |
| 5 | `.work.biz/plans/NEXT.md` | Tactical next action |
| 6 | `skills/README.md` | Registered skills |
| 7 | The specific `skill.md` you're invoking | Verbs and gates |
| 8 | The specific standard | Binding rules |
| 9 | `.work.biz/decisions/DECISIONS.md` | Open decisions and their review dates — read before advising, pricing, or routing |

---

## 8. FAQ

| Question | Answer |
|----------|--------|
| Free-text business request / don't know the skill? | `@biz-director - <describe what you want>` · `@x-director - <describe what you want>` (cross-framework) |

---

## 9. Anti-patterns to refuse

- Claiming PASS when analysis shows gaps
- Hand-editing a gate to PASS in `.work.biz/gates.md` instead of running the promoting skill
- Leaving a gate at PASS after its evidence changed (amend or re-audit demotes it)
- Modifying protected files without explicit approval
- AI attribution markers in any artifact
- Logging real client data in planning docs
- Inventing a resolution for a blocker — pause and ask
- Recording a consequential decision as prose with no falsifiable expected outcome — it can never be scored, and unscored advice only gets more confident, never more accurate
- Leaving decision rows past their review date, or letting `@biz-review quarterly` skip the Decision audit
- Certifying a strategy whose arithmetic does not close, or whose timeline is asserted with no reference class
- Grading evidence by "it has a citation" — a citation is not a source quality (`A`–`D`, CONVENTIONS § Evidence grades)
