# Business OS skills (`.ai.biz/skills/`)

Portable, tool-agnostic business workflows. Each skill is a folder with `skill.md`.

**Identifiers:** Folder name = stable skill id (YAML `name:` in `skill.md` must match). Invoke as `@<skill-id>`.

**Invocation punctuation:** Use ASCII hyphen `-` between verb and argument (`@biz-strategy greenfield`).

**Work tree paths:** `{WORK_BUSINESS_ROOT}` = `.work.biz/` at project root.

---

## Naming protocol

| Rule | Requirement |
|------|-------------|
| **Shape** | `{prefix}-{role}` in **kebab-case** |
| **Business prefix** | `biz-` for **all** skills — business (`biz-strategy`, `biz-content`), infrastructure (`biz-deploy-basic`, `biz-deploy-files`, `biz-session`), and generative (`biz-writing`, `biz-social`, `biz-ideas`, `biz-products`) |
| **Stable id** | Folder name = `name:` in frontmatter = `@` handle |

---

## Registered skills

| Skill id | Folder | Role |
|----------|--------|------|
| biz-deploy-basic | `biz-deploy-basic/` | Thin-client bootstrap (`.cursorrules` + `.work.biz/`); skills load via `AI_BIZ_SOURCE` (legacy pointer name: `AGENT_OS_SOURCE`) |
| biz-deploy-files | `biz-deploy-files/` | Deploy `.ai.biz/` files into target project |
| biz-bootstrap | `biz-bootstrap/` | Scaffold `.work.biz/`, `.cursorrules` from templates |
| biz-strategy | `biz-strategy/` | **Design** the strategy (generate 5+ plays, score them on graded evidence, pick one, pre-mortem) then define niche, offer, positioning; profile the operator (`career`); reality check (arithmetic + sensitivity + outside view); certifies **strategy-ready** and records it as a decision |
| biz-brand | `biz-brand/` | Audit/overhaul LinkedIn, website, brand presence |
| biz-pricing | `biz-pricing/` | Value-based pricing for any engagement; reality check (margin, capacity, runway); records each quote as a decision |
| biz-content | `biz-content/` | LinkedIn publishing ops: publish, plan, 30-day challenge (#CreateImpact), tracker |
| biz-youtube | `biz-youtube/` | YouTube publishing ops: publish, plan, 30-day challenge, analytics status |
| biz-community | `biz-community/` | Community engagement without selling |
| biz-referrals | `biz-referrals/` | Systematic referral generation |
| biz-discovery | `biz-discovery/` | Sales discovery calls |
| biz-proposal | `biz-proposal/` | Proposal writing and scoping |
| biz-objections | `biz-objections/` | Handle sales objections |
| biz-review | `biz-review/` | Weekly/monthly/quarterly business review (monthly = assumption re-validation; quarterly = content-by-pillar + **decision audit/calibration** + **counterfactual audit** of rejected plays and bet kill signals) |
| biz-market-validate | `biz-market-validate/` | Test offers before committing |
| biz-pipeline-diagnosis | `biz-pipeline-diagnosis/` | Find and fix funnel bottlenecks |
| biz-session | `biz-session/` | Session bookends + scoped git: `start` / `close` / `status` / `context`; `close commit [scoped] [push]`; standalone `commit` / `commit push` (no close) and `add` (stage only). Scope: `.work.biz/` in target projects, repo-wide in the Business OS source repo. Aliased as `session-control` |
| biz-director | `biz-director/` | Universal orchestrator; maps free-text requests to correct skills, checks gates, chains execution |
| biz-writing | `biz-writing/` | Craft of writing articles, posts, case studies, landing pages, emails — project-aware, technology-tilted |
| biz-social | `biz-social/` | Platform-native social content (Reddit, Instagram, LinkedIn incl. carousel + native video, Facebook, X, YouTube incl. Shorts, Substack, Threads). Write, research, repurpose, plan, log publishes. |
| biz-ideas | `biz-ideas/` | Structured, stress-tested business/venture idea generation; archetypes + assumption ledger |
| biz-archive | `biz-archive/` | Archive published content pieces: `ideas/` → `ideas.archive/` (mirrored), tracker annotated, history preserved |
| biz-products | `biz-products/` | Buildable, stack-fit product/service concepts + MVP scoping + prioritization matrix |
| biz-advisory | `biz-advisory/` | Situational business counsel: asset reframe pass, ranked options with **graded** evidence, base rate, arithmetic check, anti-advice, decisive recommendation; records the decision row |
| biz-career | `biz-career/` | Job search and resume craft: role archetypes + channel plan + target list with a kill signal; CV elaboration on evidenced scope; interview story bank; offer evaluation. No invented numbers |
| biz-sources | `biz-sources/` | Curate and mine business-advisory sources into a living catalog (`.work.biz/research/sources.md`), each **graded A–D** with freshness |

**Typical flow (greenfield):** `@biz-bootstrap init` → `@biz-strategy design` (when more than one direction is plausible) → `@biz-strategy greenfield` → `@biz-strategy certify`

**Typical flow (employment):** `@biz-strategy career` (profile) → `@biz-career search` → `@biz-career resume` → `@biz-career interview` → `@biz-career negotiate` → `@biz-brand audit` → `@biz-pricing set` → `@biz-community find` → `@biz-social strategy` → `@biz-social write` → `@biz-youtube plan` → ...

---

## Canonical command vocabulary

| Verb | Meaning |
|------|---------|
| `status` | Read-only state report |
| `init` | One-time setup |
| `greenfield` | Generate full output from scratch (single chosen direction) |
| `probe` | Adaptive gap-driven questioning |
| `certify` | Gate check + state promotion |
| `amend` | Record a strategy change made outside greenfield; fold out-of-tree strategy docs back in (biz-strategy) |
| `audit` | Read-only assessment |
| `overhaul` | Full rewrite/restructure |
| `publish` | Create and distribute content |
| `set` | Configure a value |
| `run` | Execute a process |
| `prepare` | Pre-work before execution |
| `write` | Author a document |
| `handle` | Respond to a situation |
| `ask` | Request something (referrals) |
| `engage` | Participate in community |
| `test` | Run a validation experiment |
| `design` | Generate and score candidate strategies before committing (`biz-strategy`) — or plan a validation experiment (`biz-market-validate`) |
| `review` | Assess a proposal before sending (biz-proposal) or assess business performance (biz-review) |
| `plan` | Create a content/publishing plan |
| `challenge` | 30-day LinkedIn consistency program (biz-content) |
| `revise` | Update an existing decision |
| `find` | Find communities to join (biz-community) |
| `weekly` | Weekly business review (biz-review) |
| `monthly` | Monthly assumption re-validation: re-grade the assumption ledger, route dead load-bearing assumptions to amend (biz-review) |
| `quarterly` | Quarterly strategic review: content-strategy alignment by pillar **and the Decision audit** — score the decision ledger, update calibration, convert repeating miss classes into rule changes (biz-review) |
| `career` | Probe the operator (skills, proof points, constraints, risk, stage); fill `reference/OPERATOR_PROFILE.md`; career-direction read (biz-strategy) |
| `search` / `resume` / `interview` / `negotiate` | Job search plan + target list, CV elaboration, story bank, offer evaluation (biz-career) |
| `roleplay` | Practice objection handling (biz-objections) |
| `close` / `start` | Session bookends |
| `commit` / `push` | Session git ops, `.work.biz/` scope (incl. untracked): standalone verbs (checkpoint, no close) or modifiers of `close`; `push` implies commit; any order, combinable (biz-session) |
| `add` | Stage the `.work.biz/` session scope without committing (biz-session) |
| `clone` / `archive` | Deploy modes |
| `copy` | Deploy files mode |
| `write` | Author content (biz-writing, biz-social) |
| `repurpose` | Spin one asset into multiple formats (biz-writing, biz-social) |
| `research` | Discover trending topics, active discussions, content gaps on a platform (biz-social) |
| `generate` | Produce a set of structured concepts/ideas (biz-ideas, biz-products) |
| `stress` | Stress-test/kill one idea (biz-ideas) |
| `pivot` | Generate pivot directions from an existing business (biz-ideas) |
| `extend` | Extension concepts for an existing product (biz-products) |
| `scope` | Produce a ruthlessly minimal MVP definition (biz-products) |
| `find` | Discover communities/subreddits/accounts/groups on a platform (biz-community) |
| `reconcile` | Transcribe certification-asserted decisions into canonical files; no gate moves, no re-certification (biz-strategy) |
| `icp` | Run LinkedIn ICP analysis, saved to `.work.biz/strategy/linkedin-icp.md` (biz-social) |
| `log` | Record a publish or status change into `CONTENT_STATUS.md` (biz-social) |
| `archive` | Move published content pieces from `ideas/` to `ideas.archive/`, mirrored (biz-archive) |
| `context` | Read-only full session context load, uncommitted-aware (biz-session) |
| `update` | Deploy update mode with rules-aware merge (biz-deploy-basic, biz-deploy-files) |
| `advise` | Full situational advisory pass: reframe, ranked options, evidence, anti-advice, decisive recommendation (biz-advisory) |
| `patterns` | List/apply the advisory pattern library, BIZ-10 (biz-advisory) |
| `list` | Show the curated advisory-source catalog (biz-sources) |
| `decisions` | The decision ledger (`.work.biz/decisions/DECISIONS.md`): every consequential decision with a falsifiable expected outcome, a confidence, a reversibility class, a kill/review trigger, and a review date. Written by `@biz-strategy certify`/`amend`, `@biz-advisory advise`, `@biz-pricing set`, `@biz-market-validate test`, `@biz-proposal write`; scored by `@biz-review quarterly` (CONVENTIONS § Decision loop) |
