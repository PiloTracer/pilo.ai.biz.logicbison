---
name: biz-director
description: >-
  Universal orchestrator. Accepts free-text business requests, loads project
  state, maps intent to correct skill(s), checks prerequisite gates,
  orchestrates execution, and ensures proper documentation. Covers the whole
  judgment layer too — recommending, recording, scoring, and arithmetically
  checking decisions — and never dead-ends: when no row matches it asks one
  splitting question and falls back to @biz-advisory. If no skill matches,
  recommends creating one. biz-director <free-text request>
---

# biz-director — Business Request Orchestrator

**Purpose:** You don't need to know which skill exists or what it does. Just describe what you want to accomplish. biz-director reads project state, maps your intent to the right skills, checks gates, chains dependent skills, and ensures every session leaves the project better documented.

**Canonical path:** `.ai.biz/skills/biz-director/skill.md`

---

## Free-text intake contract

When the user invokes `@biz-director` with natural language, follow this write/structure/format/channel discipline so the request becomes the correct `biz-*` skill invocation and is recorded in `.work.biz/` memory.

### 1. Capture
- Preserve the user's exact wording (quote it in `{HANDOFF}`).
- Do not silently rewrite a business request into engineering/UI work.

### 2. Load context
- Read `{HANDOFF}`, `{NEXT}`, `{PIPELINE_TRACKER}`, and `skills/README.md` + `skills/SKILL_DEPENDENCIES.md` before classifying.
- If `.work.biz/` is missing, route to `@biz-bootstrap init` first.

### 3. Classify (intent → skill)
- Match by intent, not keyword. Use the intent mapping table in § I1.
- If the intent is engineering/backend/DB/API, redirect to `@ai-director` or `@x-director`.
- If the intent is UI/design, redirect to `@ui-director` or `@x-director`.
- If the intent spans business + engineering/UI, route to `@x-director`.
- If unclear, run the **no-match default** in § I1 (one splitting question, then the `@biz-advisory` fallback) rather than handing the operator a menu of skill names.

### 4. Channel (intent → skill chain)
- Map the intent to the exact skill chain from § I1 and check `SKILL_DEPENDENCIES.md` gates per § I2.
- Use canonical invocation syntax: `@<skill-id> <mode>` or `@<skill-id> <mode> - <argument>` with ASCII hyphen `-`.

### 5. Structure/format the record
After the workflow completes or changes state, update `{HANDOFF}`, `{NEXT}`, and `{UNKNOWNS}` using this shape:

```markdown
## Latest action (@biz-director)
**Date:** YYYY-MM-DD
**Request:** "<user's original request>"
**Classified intent:** <intent-cluster>
**Executed:**
1. @<skill> <mode> - <arg> → <result>
2. ...
**Blockers:** <any unresolved items | none>
**Next recommended:** @<skill> <mode> - <arg>
```

---

## Parse invocation

Free-text match — no fixed verb. Capture the user's natural language request in full.

| User says | Action |
|-----------|--------|
| `@biz-director I want to get my business ready to attract clients` | Route through full flow: strategy → brand → pricing → content |
| `@biz-director fix my LinkedIn profile` | Route to `@biz-brand overhaul` |
| `@biz-director I need to write a proposal for a prospect` | Route to `@biz-proposal write` (check pipeline-ready gate) |
| `@biz-director help` | Display routing table and this skill's purpose |
| `@biz-director I don't know if my plan is realistic - can I really hit $120k next year?` | `@biz-strategy certify - why` to diagnose, then `probe - reality` for the gaps — the reality check (arithmetic + outside view) is where this is answered |
| `@biz-director were the calls we made last quarter any good?` | `@biz-review quarterly` Decision audit — score the open rows, update calibration, name any repeating miss class |
| `@biz-director we need a new way to track customer onboarding` | Gap detected → recommend new skill |

---

## I0 — Load project state

Before routing, read the following to understand current context:

| File | What it tells you |
|------|------------------|
| `.work.biz/context/HANDOFF.md` | Last session state, pending tasks, key decisions |
| `.work.biz/plans/NEXT.md` | Current tactical next action |
| `.work.biz/plans/UNKNOWNS.md` | Open questions that may affect routing |
| `.work.biz/pipeline/pipeline_tracker.md` | Pipeline status, active deals, bottlenecks |
| `.work.biz/decisions/DECISIONS.md` | Open decision rows and their review dates — routing must not contradict a live decision, and an overdue row is often the real request behind "what should I do next" |

If any of these files don't exist yet (project not bootstrapped), the first recommendation is `@biz-bootstrap init`.

Also read `skills/README.md` to know the full skill registry and canonical verbs, and `skills/SKILL_DEPENDENCIES.md` to know the current gate graph.

---

## I1 — Intent mapping

Parse the user's request against this routing table. Match on intent, not keywords.

| Intent cluster | Example requests | Skill(s) to route | Gate required |
|---|---|---|---|
| **Setup / bootstrap** | "start a new project", "set up my business folder", "create .work.biz" | `@biz-bootstrap init` | — |
| **Strategy / niche / offer** | "figure out my niche", "define my offer", "who should I target", "what should I sell", "certify my strategy", "check if strategy is ready", "how's my strategy looking", "what should I do with my career", "what can I actually prove", "profile my skills", "am I on the right track career-wise" | `@biz-strategy` (design, greenfield, probe, career, certify, or status per parse invocation) | scaffold (design/greenfield/probe/career/status); strategy-ready not required |
| **Job search / resume / interview / offer** | "help me find a job", "rewrite my resume", "elaborate my CV", "I have an interview at X", "should I take this offer", "how do I negotiate salary", "which companies should I target", "I want to move from consulting back to employment" | `@biz-career` (search, resume, interview, negotiate, or status per parse invocation). Profile the operator with `@biz-strategy career` first if `reference/OPERATOR_PROFILE.md` is missing | scaffold (no gate) |
| **Choose between directions / compare options** | "which direction should I pick", "I have three ideas and can't choose", "compare these options", "is my current niche the best one", "should I change what I sell", "score my options", "what's the highest-leverage play" | `@biz-strategy design` — generation and graded scoring of ≥5 plays, forced ranking, pre-mortem, bets. The current play enters the ranking as a candidate; the output is a design record, not a certification | scaffold |
| **Was the option we rejected better** | "did we pick the right direction", "would the other option have worked", "did our bet pay off", "should we re-enter the plan we parked" | `@biz-review quarterly` (counterfactual audit — scores the selection process and re-enters a rejected play through its recorded re-entry condition) | at least one strategy doc |
| **Market validation** | "test if my idea works", "validate my niche", "run an experiment", "design a validation test", "design an experiment" | `@biz-market-validate` (test, design, or status per parse invocation) | — (can run any time) |
| **Brand / LinkedIn / website** | "fix my LinkedIn", "rewrite my profile", "update my website", "make me look professional", "check my brand presence", "how's my LinkedIn doing" | `@biz-brand` (audit, overhaul, or status per parse invocation) | strategy-ready |
| **Pricing** | "how much should I charge", "set my prices", "price this project", "revise my pricing", "is my pricing right", "what's my current price" | `@biz-pricing` (set, revise, or status per parse invocation) | strategy-ready |
| **Content publishing ops (LinkedIn)** | "publish this on LinkedIn", "set up my LinkedIn content tracker", "LinkedIn content calendar", "LinkedIn engagement cadence", "LinkedIn 30-day challenge", "#CreateImpact", "post more consistently on LinkedIn", "LinkedIn consistency program" | `@biz-content` (`publish`, `plan`, `challenge`, or `status` per parse invocation) | brand-ready |
| **YouTube publishing ops** | "publish a YouTube video", "YouTube content calendar", "YouTube upload plan", "YouTube 30-day challenge", "track my YouTube analytics" | `@biz-youtube` (`publish`, `plan`, `challenge`, or `status` per parse invocation) | — (benefits from brand-ready + strategy-ready) |
| **LinkedIn carousel / document post** | "LinkedIn carousel about X", "document post for LinkedIn", "slide deck for LinkedIn", "PDF post LinkedIn" | `@biz-social write linkedin carousel - <topic>` | — |
| **LinkedIn native video** | "LinkedIn video about X", "make a LinkedIn video", "LinkedIn talking head script", "video post for LinkedIn", "coach me on LinkedIn video" | `@biz-social write linkedin video - <topic>` | — |
| **Social media content (platform-specific)** | "write a reddit post about X", "create an instagram post for...", "draft a facebook post", "write something for LinkedIn and Reddit", "make a post for instagram about...", "linkedin post idea", "write a tweet about...", "generate social media content", "draft a twitter thread", "write a Substack piece / issue / newsletter post", "draft a Substack Note", "write a Threads post" | `@biz-social` (write, repurpose, research, strategy, plan, or status per parse invocation) | — (no hard gate for write/research/repurpose; strategy-ready for strategy/plan modes) |
| **Content strategy (which platforms)** | "content strategy", "which platforms should I be on", "platform mix", "should I start a newsletter / YouTube channel", "where should I publish" | `@biz-social strategy` — **but first read `strategy/channel-plan.md`.** If a certified channel plan exists, serve it rather than producing a fresh platform matrix, and say that is what you are doing. Relitigating a certified channel decision requires `@biz-strategy amend`, not a content skill | strategy-ready |
| **Record a publish / content status** | "I published the post", "I posted X on LinkedIn yesterday", "mark this piece published", "log the publish", "what have I published", "what's ready to post" | `@biz-social log - <piece> - <platform>` to record a publish; `@biz-social status` for the cross-platform state. Never leave a reported publish unrecorded — the tracker is how later sessions know what is live | — |
| **Archive published content** | "archive published content", "clean up the ideas folder", "move published pieces out of ideas", "tidy up old posts" | `@biz-archive run` (dry run: `@biz-archive status`). Moves `published` pieces `ideas/` → `ideas.archive/` mirrored, annotates the tracker, never commits | — |
| **Content scripts (spoken / video)** | "write a script for...", "video script", "talking head script", "YouTube script", "Shorts script", "podcast script" | `@biz-social write <platform> video` or `write youtube` / `write youtube shorts`. Ask which platform if the request does not say, since script structure differs sharply per platform | — |
| **Community find & engage** | "join communities", "engage on Reddit", "find my audience", "find communities to join", "where should I participate", "find subreddits for...", "find instagram accounts in...", "find facebook groups for..." | `@biz-community` (find, engage, or status per parse invocation) | — for `find`/`status`; brand-ready for `engage` |
| **Referrals** | "ask for referrals", "get introduced" | `@biz-referrals ask` | — |
| **Discovery / sales calls** | "prepare for a call", "run a discovery call", "I have a prospect meeting" | `@biz-discovery prepare` or `run` | pipeline-ready |
| **Proposals** | "write a proposal", "scope this project", "review my proposal before sending", "check proposal pipeline" | `@biz-proposal` (write, review, or status per parse invocation) | pipeline-ready |
| **Objections** | "client said it's too expensive", "handle objections", "overcome price concerns", "roleplay objection responses" | `@biz-objections handle` or `roleplay` | active-deal for `handle`; — for `roleplay` |
| **Pipeline diagnosis** | "nothing is converting", "find my bottleneck", "why aren't we closing" | `@biz-pipeline-diagnosis run` | pipeline tracker with data |
| **Review / health** | "weekly review", "monthly review", "quarterly review", "how are we doing", "progress check", "re-check my assumptions", "are my strategy assumptions still true" | `@biz-review` (weekly, monthly, quarterly, or status per parse invocation) | at least one strategy doc |
| **Session management** | "start the day", "close the session", "what was I doing", "commit my progress", "checkpoint without closing", "stage my session work" | `@biz-session start` or `close` or `commit` / `add` or `status` | scaffold |
| **Project orientation** | "where am I", "what should I do next", "I'm lost" | `@biz-session status` + `@biz-review status` | — |
| **Deploy to project** | "deploy to my project", "copy .ai.biz to another repo", "deploy a thin client", "bootstrap-basic a project", "update my installed copy" | `@biz-deploy-files copy - <path>` or `@biz-deploy-basic` (<path>, update, or status per parse invocation) | — |
| **Content writing (craft)** | "write me a post about X", "draft an article on Y", "help me write something for LinkedIn", "write a LinkedIn post", "publish an article" (when no integration/ops needed), "case study", "landing page copy", "email sequence", "repurpose this draft", "audit my draft" | `@biz-writing` (write, plan, repurpose, audit, or status per parse invocation) | — (no hard gate; improves with strategy/brand-ready) |
| **Business ideas** | "give me business ideas for...", "what businesses could benefit from...", "how could I monetize...", "I want to start something in...", "pivot my business", "stress-test this idea", "new venture directions" | `@biz-ideas` (generate, stress, pivot, or status per parse invocation) | — (no hard gate; improves with strategy-ready) |
| **Product / service ideas** | "what product could I build for...", "give me SaaS product ideas in...", "what features should I add", "I want a tool that...", "service package ideas", "scope an MVP for", "evaluate this product concept", "extend my platform" | `@biz-products` (generate, extend, scope, audit, or status per parse invocation) | — (no hard gate; improves with strategy-ready) |
| **Business advice / hard decisions** | "what should I do", "should we team up or job-hunt separately", "we lost our jobs, now what", "is this move smart", "advice on my situation", "I'm stuck, need direction", "pivot or persist", "how should we position ourselves" | `@biz-advisory` (advise, patterns, or status per parse invocation) | — (no hard gate; improves with strategy-ready + operator profile) |
| **Advisory sources / learning** | "where can I learn about pricing", "good sources for positioning", "curate business resources", "what should I read", "keep our evidence base current", "find market data on..." | `@biz-sources` (find, list, add, or status per parse invocation) | — |
| **Record a decision** | "log this decision", "record what we decided", "note that we're going with X", "write down why we chose this", "add this to the decision log" | Append one row to `.work.biz/decisions/DECISIONS.md` per CONVENTIONS § Decision loop. If the decision is not yet framed, run `@biz-advisory` first — it reaches the recommendation and records the row (step 8). Never record a decision without a falsifiable expected outcome, a confidence, a reversibility class, and a review date | — |
| **Score past decisions / calibration** | "did our past calls pan out", "review our decisions", "were we right", "how accurate have we been", "are we overconfident", "what does our track record say" | `@biz-review quarterly` (Decision audit). Weekly shows only the overdue count. If the ledger is empty, say so plainly: decisions recorded as prose cannot be scored, and that gap is the finding | at least one strategy doc |
| **Sanity-check a plan / does the math work** | "does this plan add up", "will this actually make money", "sanity-check these numbers", "is this realistic", "can I really hit that revenue", "does the timeline work" | `@biz-strategy` (`certify - why` for a read-only diagnosis, `probe - reality` to fill gaps, `certify` for the full gate). If the number in question is a price, add `@biz-pricing set`. The arithmetic and outside-view steps are `biz-strategy` I1 Element 8 and certify checks 11–12 | scaffold for probe; strategy-ready for certify |
| **Outside view / is this timeline normal** | "what normally happens with plans like this", "is this timeline realistic", "how long does this usually take", "am I being optimistic" | `@biz-strategy probe - reality` (reference class + base rate). For a decision-shaped question rather than a strategy one, `@biz-advisory - <situation>` carries the same outside-view step | — |
| **Evidence strength / can I trust this number** | "how strong is this evidence", "is this source any good", "can I trust this stat", "where did that number come from", "is this just marketing" | `@biz-sources` (grade + freshness; `find` when no source exists). If the claim can only be settled by a test rather than a source, `@biz-market-validate design` | — |

> **Content route disambiguation (three-tier):**
> 
> 1. **Pure writing craft** (blog articles, case studies, landing pages, emails, newsletters as a *format*, technical deep dives) → `@biz-writing` (no gate). Platform-agnostic, quality-gated writing.
> 
> 2. **Platform-specialized social content** (Reddit posts, Instagram captions + visual briefs, LinkedIn posts / carousels / native video, Facebook Group posts, X/Twitter tweets + tweet chains, YouTube scripts / Shorts, Substack posts + Notes, Threads posts, cross-platform repurposing, trending topic research, platform strategy) → `@biz-social` (no gate for write/research/repurpose/icp). Each piece calibrated to platform culture, audience, and format norms.
> 
> **Two naming collisions to resolve deliberately:**
> 
> - **"newsletter" vs Substack.** A newsletter as a *format* (an email to a list, platform-agnostic) is `@biz-writing`. **Substack as a platform** is `@biz-social write substack`, because its guide carries mechanics that the format alone does not: the recommendations network, Notes as a funnel, free-versus-paid economics, and the fact that its readers opted into depth so the usual compression is a downgrade. If the request names Substack, route to `@biz-social` even though the word "newsletter" appears.
> - **"thread" vs Threads.** A "thread" or "twitter thread" means a chain of tweets on X. **Threads** is Meta's platform with its own guide. When the request is ambiguous, ask; the two have opposite register rules, since Threads ranking penalizes the formality X tolerates.
> 
> 3. **Publishing ops** (content tracker, posting calendar, 30-day challenges, engagement cadence, analytics review, video habit coaching) → `@biz-content` for LinkedIn (brand-ready gate) or `@biz-youtube` for YouTube.
> 
> **LinkedIn challenge flow:** `@biz-brand audit` → `@biz-content challenge - createimpact` (or `challenge`) → `@biz-social write linkedin` / `write linkedin carousel` / `write linkedin video` per plan day → `@biz-content status` weekly.
> 
> **LinkedIn video challenge flow:** `@biz-brand audit` → `@biz-social icp` if missing → `@biz-content challenge - video` → `@biz-social write linkedin video` per plan day → `@biz-content status` weekly.
> 
> **YouTube flow:** `@biz-brand audit` (YouTube section) → `@biz-youtube plan` → `@biz-social write youtube` / `write youtube shorts` per plan → `@biz-youtube status` weekly.
> 
> **How they compose:** `@biz-writing write` produces a long-form piece or YouTube source outline. `@biz-social write youtube` produces the full script + packaging. `@biz-social write linkedin video` produces a complete LinkedIn native video production package. `@biz-social repurpose` spins long-form into platform-native posts for Reddit, Instagram, LinkedIn, LinkedIn video, Facebook, X/Twitter, YouTube, Substack, and Threads, limited to the platforms the channel plan sanctions. `@biz-content publish` tracks LinkedIn performance (text, carousel, and video); `@biz-youtube publish` tracks YouTube performance. `@biz-community find` discovers where to post. `@biz-community engage` handles daily comment participation.

If the request spans multiple intents (e.g., "I want to fix my LinkedIn and start posting content"), route through all matching skills in gate order.

> **Judgment-route disambiguation (four requests that sound alike).** The judgment layer has four different jobs, and a lost user phrases all of them the same way ("is this right?"). Route on what they want *done*, not on the words:
>
> | What the user actually wants | Route |
> |---|---|
> | **A recommendation** on a messy situation | `@biz-advisory` — counsel, and it ends by recording the decision row itself |
> | **A record** of a decision already made | append one row to `decisions/DECISIONS.md` — via `@biz-advisory` when the decision still needs framing |
> | **A verdict** on a decision already made | `@biz-review quarterly` (Decision audit) |
> | **A check** that a plan is arithmetically possible | `@biz-strategy` (`certify - why` read-only, `probe - reality` to fill gaps, `certify` to gate) |
>
> If two or more fit, run them in that order. The recommendation and its record are one action, not two — do not route them separately.

### No-match default (never dead-end)

When the request matches no row above, the operator still has to land somewhere useful. Take the first step that applies — never stop at "no skill matches":

1. **Probe, don't hand them a menu.** Ask **one** question that splits the space ("is this a decision to make, a thing to build, or a thing to check?"), then re-classify. Asking the operator to choose between skill names is the failure this skill exists to prevent.
2. **Default to `@biz-advisory`** for any "what should I do / is this right / I'm stuck" phrasing that survives the probe. It is the catch-all counsel skill: it loads the operator's real context and ends by handing off to the executing skill once a direction exists. That handoff *is* the orchestration — you do not have to guess the final skill up front.
3. **Default to `@biz-session status` + `@biz-review status`** when the request is orientation in disguise ("I don't know where to start", "where do things stand").
4. **Reach I4 gap detection** only once the probe shows no existing skill covers the request.

**Verb selection:** After mapping intent to a skill, read that skill's `skill.md` **Parse invocation** table to select the correct verb for the user's phrasing. The verbs listed above are the most common — the skill's own parse table is authoritative. For example, "certify my strategy" maps to `@biz-strategy` intent cluster; the director then reads `biz-strategy/skill.md` to confirm `certify` is the correct verb. If a user asks for something the skill does not support, report the gap.

**Status requests:** Free-text requests asking "how is X doing", "check X", or "what's the state of X" should route to the matching skill's `status` mode (read-only). If the user simply wants orientation ("where am I", "what's next"), use the "Project orientation" row above.

---

## I2 — Gate check

Before invoking any skill, verify its prerequisites against `SKILL_DEPENDENCIES.md`:

```
scaffold → strategy-ready → brand-ready → pipeline-ready → sales-ready → active-deal
```

### Gate-exempt skills (skip the gate check entirely)

These **project-aware generative skills** have **no prerequisite gate** and may be invoked at any time — even before `@biz-bootstrap init` or on an entirely unbootstrapped project. Do **not** redirect to `@biz-bootstrap init` for them, and do **not** emit a `BLOCKED` gate report. They load the host project's own context dynamically and fall back to a bundled example profile when none exists (output improves once strategy/brand are defined).

| Skill | Verb | Note |
|------|------|------|
| `@biz-writing` | `write` · `plan` · `repurpose` · `audit` · `status` | Craft of content; no gate |
| `@biz-social` | `write` · `research` · `repurpose` · `icp` · `log` · `status` | Platform-specialized social content; no gate (`strategy`/`plan` modes require strategy-ready) |
| `@biz-archive` | `run` · `status` | Archive published pieces to `ideas.archive/`; no gate |
| `@biz-ideas` | `generate` · `stress` · `pivot` · `status` | Ideation; no gate |
| `@biz-products` | `generate` · `extend` · `scope` · `audit` · `status` | Concepts + MVP scoping; no gate |
| `@biz-market-validate` | `test` · `design` · `status` | (pre-existing) Validation; no gate |
| `@biz-strategy` | `design` · `greenfield` · `probe` · `career` · `status` · `certify - why` | Strategy design and draft strategy; no gate beyond the `.work.biz/` scaffold. Only `certify` moves `strategy-ready` |
| `@biz-career` | `search` · `resume` · `interview` · `negotiate` · `status` | Job search and resume craft; no gate |
| `@biz-community` | `find` · `status` | Community discovery; no gate. **`engage` is gated** on brand-ready |

### Check each gate:

`{WORK_BUSINESS_ROOT}/gates.md` is the authoritative ledger. Read it and check the `**Status:**` line of the relevant `## <gate-id>` section. A gate is met only when `Status` is PASS; a missing file or missing section means not met. Do not infer a gate from the presence of files — the promoting skill writes the ledger entry after verifying its own criteria.

| Gate id | Promoted by | If not met |
|---------|-------------|------------|
| scaffold | `@biz-bootstrap init` (no ledger entry; `.work.biz/` exists) | Route to `@biz-bootstrap init` first |
| `strategy-ready` | `@biz-strategy certify` | Route to `@biz-strategy greenfield` → `@biz-strategy certify` |
| `brand-ready` | `@biz-brand overhaul` | Route to `@biz-brand audit` → `@biz-brand overhaul` |
| `pipeline-ready` | `@biz-review status` | Route to `@biz-pricing set` + configure tracker + fill outreach cadence, then `@biz-review status` |
| `sales-ready` | `@biz-discovery run` | Route to `@biz-discovery prepare` → `@biz-discovery run` |
| `active-deal` | `@biz-discovery run` | Route to `@biz-discovery run` first to generate pipeline |

The gated skills also self-check the ledger in their own I0. The director's check is the first layer, not the only one, so a stale ledger gets caught twice.

### Informal prerequisites

Some skills have lighter prerequisites that are not formal gates:

| Skill | Requires | How to verify |
|-------|---------|---------------|
| `@biz-review weekly` | At least one strategy doc exists | Check `.work.biz/strategy/` for any of the canonical files (`one-pager.md`, `target-buyer-profile.md`, `offer-scope.md`, `channel-plan.md`, `pricing.md`) or `certification.md` |
| `@biz-pipeline-diagnosis run` | Pipeline tracker has data | Check `.work.biz/pipeline/pipeline_tracker.md` has ≥1 row of deal data |

**Blocked output shape:**

```text
⛔ BLOCKED: <skill> requires <gate>
  Why: <explanation of what's missing>
  Fix: run `@<gate-unlocking-skill>` first
```

---

## I3 — Execute

Once intent is mapped and gates are confirmed, execute the skill(s):

1. **Single skill** — invoke directly with the appropriate verb.
2. **Multi-skill chain** — execute in dependency order. After each completes, verify output before proceeding to the next.
3. **Session context** — if running within a session, load HANDOFF first and update it after completion.

For each skill invocation, follow its `skill.md` instructions completely — do not skip steps.

---

## I4 — Gap detection

If after scanning all skills no existing skill covers the user's request:

1. **State the gap clearly** — "There is no existing skill for `<request>`."
2. **Describe what a new skill would need to cover** — scope, inputs, outputs, place in gate graph.
3. **Recommend creation** — "Consider creating `.ai.biz/skills/biz-<name>/skill.md` following the conventions in `skills/README.md` and `CONVENTIONS.md`."

### Example

```text
⚠️ GAP: No skill exists for "customer onboarding tracking"

A new skill `biz-onboarding` would need to:
  - Define onboarding stages and milestones
  - Provide a tracking template (likely under .work.biz/pipeline/)
  - Gate after pipeline-ready (requires active-deal)

To create: model after `biz-pipeline-diagnosis` and register in skills/README.md.
```

---

## Completion

After execution:

| Action | Detail |
|--------|--------|
| Update HANDOFF | Document what was accomplished this session |
| Update NEXT | Set the next action based on completed work |
| Update UNKNOWNS | Log any new open questions discovered |
| Record the decision | If this session reached a consequential recommendation, confirm it landed as a row in `decisions/DECISIONS.md` with a falsifiable expected outcome, confidence, reversibility, kill/review trigger, and review date (CONVENTIONS § Decision loop). A routed decision that was never recorded cannot be scored, so the orchestration is not complete until the row exists |
| Report summary | Brief one-paragraph: what was done, what's next; close with Form A or Form B per the Operator handoff contract |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

---

## References

**Loaded during I0 (gate + registry):**
- `skills/README.md` — full skill registry with descriptions and verbs
- `skills/SKILL_DEPENDENCIES.md` — gate graph and prerequisite checks

**Operator reference (not loaded by director — available if needed):**
- `START_HERE.md` — operator decision tree; useful when user is disoriented
- `PROCESS_ROUTER.md` — quick routing table; useful as a secondary intent-matching aid
- `CONVENTIONS.md` — naming, phases, core principles, § Decision loop (record/scoring/calibration rules), § Evidence grades; referenced during gap detection (I4) and at completion
