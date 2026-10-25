# Business OS — turn your career into a business

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version: v0.6.0](https://img.shields.io/badge/Version-v0.6.0-blue.svg)](CHANGELOG.md)

> Your freelance/consulting business has no CRM, no sales playbook, no repeatable pipeline — just you guessing what to do next. **Business OS fixes that** with a complete set of repeatable **skills**, binding **standards**, and a tiny **project-memory** folder.

**Platform:** Developed and verified on **Linux** (bash, git, rsync). Shell scripts and docs assume a POSIX environment. macOS, Windows (WSL2), and other OSes work when you adapt paths, line endings, and local tooling in your consumer repo — run `bash scripts/framework-verify.sh` to confirm the baseline toolchain on your host.

**Customization:** Business OS is a starting point, not a fixed contract. You are already working with a coding agent — use the same workflow to tailor skills, standards, `.cursorrules`, and `.work.biz/` to your repository and preferences. Fork, trim, or extend the framework in your consumer project (or in this repo when self-hosting) as your process evolves; after substantive changes to shared scripts, re-run `bash scripts/framework-verify.sh` to confirm the baseline still holds.

**Works with:** Cursor, Claude Code, Codex, and any agent that reads project files. OpenCode and other host configs are owned by your primary Agent OS (`.ai/`) when co-installed — this framework does not ship a local `opencode.json`.

```bash
bash .ai.biz/templates/bootstrap.sh    # 30-second setup, any project
```

Then in chat:

```text
@biz-session start             # bookend the day
@biz-bootstrap init                # scaffold .work.biz/
@biz-strategy design               # generate + score candidate plays (skip if the direction is settled)
@biz-strategy greenfield           # define niche, offer, positioning
@biz-session close             # update HANDOFF · draft commit message
```

**Lost?** → [`START_HERE.md`](START_HERE.md) · **All commands** → [Skills at a glance](#skills-at-a-glance)

---

## What you get

- **Skills** — `@biz-strategy`, `@biz-brand`, `@biz-content`, `@biz-youtube`, `@biz-discovery`, `@biz-proposal`, … run the playbook (26 skills in total).
- **Standards** — binding contracts (business conventions, pricing standard, brand guide, content standard) keep agent output honest.
- **`.work.biz/`** — the project's memory: strategy docs, plans, pipeline tracker, `gates.md`, `HANDOFF.md`, `NEXT.md`. Survives session boundaries.
- **Gates** — strategy-ready, brand-ready, pipeline-ready, sales-ready, active-deal, tracked in `.work.biz/gates.md`; skip a step and the agent **stops** with a redirect.
- **Design before commit** — `@biz-strategy design` generates five or more plays, scores them on graded evidence, and writes the pre-mortem before anything is certified; `@biz-review quarterly` scores the choice against the alternatives it beat.
- **Coexists with other OS frameworks** — a project that already runs Agent OS or UI Design OS keeps its `.cursorrules`; Business OS adds one managed block and never touches the rest (see [`COHABITATION.md`](COHABITATION.md)).

Result: less re-prompting, fewer "where were we?" threads, a loop you can run **start → execute → review → hand off** every session.

---

## Path convention (read this once)

Docs often show paths like `.ai.biz/START_HERE.md`. That applies when Business OS lives **inside** an application repo. When the **git root is this framework repository**, the same files sit at the repo root **without** the `.ai.biz/` prefix.

| Layout | Where Business OS lives | Example |
|--------|------------------------|---------|
| **Nested** (typical) | `your-project/.ai.biz/` | `.ai.biz/START_HERE.md`, `.ai.biz/skills/` |
| **Self-hosted** (this repo) | git root *is* the tree | `START_HERE.md`, `skills/` |

Bootstrap always runs from the **project root** (parent of `.ai.biz/`): `bash .ai.biz/templates/bootstrap.sh`.

---

## How this compares

| Tool | What it does | Where Business OS adds value |
|------|-------------|------------------------------|
| `.cursorrules` / `AGENTS.md` | Static rules for one tool | Adds **gated workflow + memory + standards** on top |
| Plain prompts | Per-task instructions | Adds **repeatable skills** with prerequisite gates |
| CRM / Notion / Sheets | Human-only tracking | Plans and pipeline live **next to your code** as Markdown the agent reads |
| Business books / courses | Knowledge without execution | Skills are **executable playbooks** — read, run, repeat |
| Custom system prompts | Per-session drift | One project-wide, tool-agnostic contract checked into git |

---

## Bird's-eye — how to use Business OS

Business OS is a **gated pipeline**: each stage unlocks the next. Skills enforce the gates; if you skip a step, the agent should **stop** and tell you what to run instead.

### Readiness states (do not skip or confuse)

State lives in one file, `.work.biz/gates.md`, and exactly one skill may promote each gate. Gated skills read the ledger before doing anything; `scripts/gate-verify.sh` fails when a gate claims PASS without its evidence on disk.

| State | You get there with | What it unlocks |
|-------|-------------------|-----------------|
| *(scaffold)* | `@biz-bootstrap init` | Foundation planning, session files, the gate ledger |
| **strategy-ready** | `@biz-strategy greenfield` → `@biz-strategy certify` | `@biz-brand`, `@biz-pricing` |
| **brand-ready** | `@biz-brand audit` → `@biz-brand overhaul` | `@biz-content`, `@biz-community engage` |
| **pipeline-ready** | `@biz-pricing set` + pipeline tracker configured + outreach cadence documented in `.work.biz/pipeline/outreach-cadence.md`, then confirmed by `@biz-review status` | `@biz-discovery`, `@biz-proposal` |
| **sales-ready** | `@biz-discovery run` (one completed call, logged) | `@biz-referrals` |
| **active-deal** | `@biz-discovery run` (deal at Conversation stage or later) | `@biz-objections handle` |

### Full flow (once per project → every day → per phase)

```text
  @biz-bootstrap init
        │
        │  Creates: .cursorrules · .work.biz/ skeleton · gates.md (all gates NOT MET)
        │  (scaffold only; no planning gates)
        ▼
  @biz-strategy design        (when more than one direction is plausible)
        │
        │  Produces: situation audit, scored plays, ranking, WWHTBT, pre-mortem,
        │            bets with kill signals, one decision row. Moves no gate.
        ▼
  @biz-strategy greenfield
        │
        │  Produces: niche decision, unified offer, target buyer, channel plan
        ▼
  @biz-strategy certify
        │
        │  Deep consistency check; certifies strategy-ready
        │  State: strategy-ready
        ▼
  @biz-brand audit  │  @biz-brand overhaul
        │
        │  Produces: LinkedIn, website, brand assets aligned to offer
        │  State: brand-ready
        ▼
  @biz-pricing set  │  @biz-strategy status
        │
        │  State: pipeline-ready  (pricing set, tracker configured, outreach cadence defined, confirmed by @biz-review status)
        ▼

  ┌─ EVERY SESSION ──────────────────────────────────────────────┐

  @biz-session start          ← load HANDOFF · NEXT · UNKNOWNS
        │
        │  … your business development work …
        ▼
  @biz-session close          ← refresh HANDOFF + NEXT; draft commit message

  └──────────────────────────────────────────────────────────────┘

  ┌─ PER EXECUTION PHASE ───────────────────────────────────────┐

  @biz-content publish            ← publish content (LinkedIn, blog)
  @biz-community engage           ← engage in communities
  @biz-referrals ask              ← ask for referrals systematically
  @biz-discovery run              ← run discovery calls
  @biz-proposal write             ← write proposals
  @biz-objections handle          ← handle sales objections
  @biz-review weekly              ← weekly pipeline + metrics review
  @biz-market-validate test       ← test offers before committing
  @biz-pipeline-diagnosis run     ← find + fix funnel bottlenecks

  └──────────────────────────────────────────────────────────────┘
```

### Skills at a glance

All **26** skills live under [`skills/`](skills/README.md). Invoke as `@<skill-id>` plus a mode.

| Skill | One line | Typical invoke |
|-------|----------|----------------|
| **biz-bootstrap** | Scaffold `.work.biz/`, `.cursorrules` from templates | `init` · `status` |
| **biz-strategy** | Design the strategy (5+ plays scored on graded evidence, pre-mortem, bets); define niche, unified offer, target buyer, channel plan; profile the operator; certifies **strategy-ready** | `design` · `greenfield` · `probe` · `career` · `status` · `certify` |
| **biz-brand** | Audit and overhaul LinkedIn, website, brand presence to match offer | `audit` · `overhaul` · `status` |
| **biz-pricing** | Arrive at value-based pricing for any engagement | `set` · `status` · `revise` |
| **biz-content** | LinkedIn publishing ops: tracker, calendar, engagement cadence, consistency challenges | `publish` · `plan` · `challenge` · `status` |
| **biz-youtube** | YouTube publishing ops: tracker, upload calendar, challenges, analytics review | `publish` · `plan` · `challenge` · `status` |
| **biz-community** | Choose communities, engage without selling, convert relationships | `engage` · `find` · `status` |
| **biz-referrals** | Systematically ask for referrals at every stage | `ask` · `status` |
| **biz-discovery** | Run discovery calls that qualify and uncover the real problem | `run` · `prepare` · `status` |
| **biz-proposal** | Write proposals with clear scope, pricing, and protection | `write` · `review` · `status` |
| **biz-objections** | Handle the 7 most common sales objections | `handle` · `roleplay` · `status` |
| **biz-review** | Weekly/monthly/quarterly pipeline, content, and business health review (monthly = assumption re-validation) | `weekly` · `monthly` · `quarterly` · `status` |
| **biz-market-validate** | Test offers, niches, and channels with low-cost experiments | `test` · `design` · `status` |
| **biz-pipeline-diagnosis** | Identify which funnel stage is the bottleneck | `run` · `status` |
| **biz-session** | Session bookends + scoped git checkpoints; updates HANDOFF + NEXT | `start` · `close` · `commit` · `add` · `status` · `context` |
| **biz-deploy-files** | Deploy `.ai.biz/` into target project (no-overwrite default; `--update`/`--force`) | in-place · `copy - <path>` · `status` |
| **biz-deploy-basic** | Thin-client bootstrap (`.cursorrules` + `.work.biz/` only); appends a managed block when the project already runs another OS framework | `update` · `status` · `--no-merge` · `- <path>` |
| **biz-career** | Job search and resume craft: role archetypes, channel plan, target list with a kill signal, CV elaboration, interview story bank, offer evaluation | `search` · `resume` · `interview` · `negotiate` · `status` |
| **biz-director** | Universal orchestrator; accepts free-text, routes to correct skills | `<free-text request>` |
| **biz-writing** | Write articles, posts, case studies, landing pages, emails (project-aware, tech-tilted) | `write - <topic>` · `plan - <horizon>` · `repurpose - <src>` · `audit - <draft>` |
| **biz-social** | Platform-native social content (Reddit, Instagram, LinkedIn incl. carousel + native video, Facebook, X, YouTube incl. Shorts, Substack, Threads) | `write - <platform>` · `research - <platform>` · `repurpose - <src>` · `plan - <horizon>` |
| **biz-ideas** | Structured, stress-tested business/venture/pivot idea generation | `generate - <domain>` · `stress - <idea>` · `pivot - <situation>` |
| **biz-archive** | Archive published content pieces: `ideas/` → `ideas.archive/` (mirrored), tracker annotated | `run` · `status` |
| **biz-products** | Buildable, stack-fit product/service concepts + MVP scoping | `generate - <space>` · `extend - <product>` · `scope - <concept>` · `audit - <concept>` |
| **biz-advisory** | Situational business counsel: reframe pass, ranked options with evidence, anti-advice, decisive recommendation | `advise - <situation>` · `patterns` · `status` |
| **biz-sources** | Curate and mine business-advisory sources into a living catalog | `find - <topic>` · `list` · `add - <source>` · `status` |

Gates between skills: [`skills/SKILL_DEPENDENCIES.md`](skills/SKILL_DEPENDENCIES.md).

---

## First-time setup (human or agent)

**Recommended — one command from project root:**

```bash
bash .ai.biz/templates/bootstrap.sh
```

Or in chat: **`@biz-bootstrap init`**

This creates:
- `.cursorrules` from template
- `.work.biz/` skeleton (gate ledger, HANDOFF, NEXT, pipeline tracker, plan folders)

Then:
1. Replace every **`REPLACE:`** token in `.cursorrules`.
2. Initialize a git repo in the target project if not already.
3. Run **`@biz-strategy greenfield`** to define your niche, offer, and plan.

---

## Pain → fix

| Pain | Fix |
|------|-----|
| Re-explaining your business every session | **Skills** — `@biz-strategy`, `@biz-content`, … |
| Drifty positioning and messaging | **Standards** — business conventions, brand guide |
| Missing pipeline and no repeatable process | **`.work.biz/`** + session bookends |
| Context evaporates between sessions | Session control with HANDOFF + NEXT |
| No sales playbook means reinventing every time | **Skills** — `@biz-discovery`, `@biz-proposal`, `@biz-objections` |

---

## What's inside `.ai.biz/`

| Folder | Role |
|--------|------|
| [`skills/`](skills/README.md) | Executable playbooks — full registry |
| [`standards/`](standards/) | Business contract **templates** (customize per project) |
| [`concepts/`](concepts/README.md) | Business concept prompts (market fit, pricing, channels, brand) |
| [`templates/`](templates/README.md) | **`cursorrules.template`** — copy to project root as `.cursorrules` |
| [`.quick/`](.quick/README.md) | Copy-paste cheat sheets for common workflows |
| [`docs/`](docs/) | Workflow guides and adoption documentation |

---

## Required reads (when work is active)

1. [`START_HERE.md`](START_HERE.md)
2. **`.cursorrules`** (project root — install via bootstrap)
3. `.work.biz/gates.md`
4. `.work.biz/context/HANDOFF.md`
5. `.work.biz/plans/NEXT.md`
6. `.work.biz/strategy/` (one-pager, target-buyer-profile, offer-scope, channel-plan, pricing) when present

**Free-text entry point:** Don't know which skill to run? → `@biz-director - <describe what you want>` · `@x-director - <describe what you want>` (cross-framework).

---

## License

MIT — see [`LICENSE`](LICENSE).
