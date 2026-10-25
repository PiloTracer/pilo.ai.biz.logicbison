# process-router — Business OS operator guide

**Purpose:** Read-only signpost that answers: *"Which skill should I run for this business question?"*

> **Don't know which skill?** Use `@biz-director - <describe what you want>` and let it route for you. If the work spans `.ai` + `.ai.ui` + `.ai.biz`, use `@x-director - <describe what you want>`.

## How to invoke

```text
@process-router - how do I find my niche?
@process-router - what do I do after defining my offer?
@process-router - how do I handle price objections?
@process-router - I'm stuck, what should I do next?
@process-router help
```

## Routing table

| If you want to... | Run this skill |
|---|---|
| Bootstrap `.work.biz/` and `.cursorrules` | `@biz-bootstrap init` |
| Choose between plausible directions; score and compare candidate plays | `@biz-strategy design` |
| Define your niche, offer, and target buyer | `@biz-strategy greenfield` |
| Profile your skills, proof points, constraints; get a career read | `@biz-strategy career` |
| Job search plan, resume/CV elaboration, interview prep, offer evaluation | `@biz-career search` · `resume` · `interview` · `negotiate` |
| Test if your niche/offer works | `@biz-market-validate test` |
| Fix your LinkedIn profile and brand | `@biz-brand overhaul` |
| Publish LinkedIn content | `@biz-content publish` |
| Record a publish / mark a piece live | `@biz-social log - <piece> - <platform>` |
| Archive published content pieces (`ideas/` → `ideas.archive/`) | `@biz-archive run` (dry run: `@biz-archive status`) |
| Create a YouTube video | `@biz-social write youtube` · `@biz-youtube publish` |
| Plan YouTube content strategy / calendar | `@biz-youtube plan` |
| Audit / rebrand a YouTube channel | `@biz-brand audit` (YouTube section) |
| Plan YouTube Shorts strategy | `@biz-social write youtube shorts` |
| Price an engagement | `@biz-pricing set` |
| Run a discovery call | `@biz-discovery run` |
| Write a proposal | `@biz-proposal write` |
| Handle a sales objection | `@biz-objections handle` |
| Ask for referrals | `@biz-referrals ask` |
| Engage in communities | `@biz-community engage` |
| Diagnose pipeline bottlenecks | `@biz-pipeline-diagnosis run` |
| Review weekly progress | `@biz-review weekly` |
| Re-validate the strategy's assumptions | `@biz-review monthly` |
| Close your session | `@biz-session close` |
| Open a session | `@biz-session start` |
| Commit session work without closing | `@biz-session commit` (add `push` to push; `add` to stage only) |
| Free-text request / don't know skill | `@biz-director - <describe what you want>` · `@x-director - <describe what you want>` (cross-framework) |
| Deploy `.ai.biz/` to another project | `@biz-deploy-files copy - <path>` |
| Write a post / article / case study / landing page / email / thread | `@biz-writing write - <topic>` |
| Build a content calendar / topic plan | `@biz-writing plan - <horizon>` |
| Repurpose one piece into multiple formats | `@biz-writing repurpose - <source>` |
| Critique an existing draft | `@biz-writing audit - <draft or path>` |
| Generate business / venture / pivot ideas | `@biz-ideas generate - <domain>` |
| Stress-test one business idea | `@biz-ideas stress - <idea>` |
| Pivot directions from current business | `@biz-ideas pivot - <situation>` |
| Generate product / service / SaaS / add-on concepts | `@biz-products generate - <space>` |
| Extension concepts for an existing product | `@biz-products extend - <product>` |
| Scope a minimal MVP for one concept | `@biz-products scope - <concept>` |
| Evaluate one product concept (Go/Refine/Kill) | `@biz-products audit - <concept>` |
| Situational business advice ("what should I do?") | `@biz-advisory - <situation>` |
| Advisory reframe patterns (BIZ-10) | `@biz-advisory patterns` |
| Find / curate business-advisory sources | `@biz-sources find - <topic>` · `@biz-sources list` |
| Check whether a plan is realistic / the numbers add up | `@biz-strategy certify - why` (read-only) · `@biz-strategy probe - reality` · `@biz-strategy certify` |
| Ask what normally happens to plans like yours (base rate) | `@biz-strategy probe - reality` · `@biz-advisory - <situation>` |
| Record a decision you've made | append to `decisions/DECISIONS.md` (or `@biz-advisory` to frame it first) |
| Find out whether past decisions were right / your calibration | `@biz-review quarterly` (Decision audit) |
| Check how strong a piece of evidence is | `@biz-sources find - <topic>` (grade + freshness) · `@biz-market-validate design` if it needs a test |

## Readiness states

`strategy-ready → brand-ready → pipeline-ready → sales-ready → active-deal`

Only `@biz-strategy certify` can mark **strategy-ready**. Only `@biz-review status` can mark **pipeline-ready**.

## Judgment loop

Every consequential decision (money, more than a week of time, a price, a buyer, a primary channel, a public position) is recorded in `.work.biz/decisions/DECISIONS.md` with a falsifiable expected outcome, a confidence, a reversibility class, a kill/review trigger, and a review date. `@biz-review quarterly` scores them and reports calibration. Rules: `CONVENTIONS.md` § Decision loop.
