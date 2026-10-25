---
name: biz-bootstrap
description: >-
  Scaffold .work.biz/, .cursorrules, and initial business structure from
  templates. One-command setup for a new project using Business OS.
  biz-bootstrap init, biz-bootstrap status.
---

# biz-bootstrap — One-Command Business OS Setup

**Shell:** `bash .ai.biz/templates/bootstrap.sh`

Entry point for setting up Business OS in any project. Creates the `.work.biz/` skeleton (gates ledger, HANDOFF, NEXT, UNKNOWNS, pipeline tracker) and copies `.cursorrules` from template — everything you need to start a strategy session or begin a new engagement.

**Canonical path:** `.ai.biz/skills/biz-bootstrap/skill.md` · **Shell:** `.ai.biz/templates/bootstrap.sh`

**Typical flow:** `@biz-bootstrap init` → `@biz-strategy greenfield` → `@biz-strategy certify` → `@biz-brand overhaul`

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-bootstrap init` | Run bootstrap: create `.cursorrules` and `.work.biz/` skeleton |
| `@biz-bootstrap status` | Report current bootstrap state |

**Default:** `status` if no verb matches.

---

## I0 — Pre-checks

| Condition | Action |
|-----------|--------|
| `.ai.biz/` is not present in project root | **Block**: report; bootstrap requires Business OS framework installed |
| `.cursorrules` already exists at project root | Report existing; skip copy. If it belongs to another OS framework, do **not** overwrite it — append the managed block instead (`bash .ai.biz/scripts/biz-cursorrules-merge.sh <project> --layout fat`, see `COHABITATION.md`) |
| `.work.biz/` already exists | Report existing; do not overwrite |
| `templates/bootstrap.sh` or `templates/cursorrules.template` missing | **Block**: report missing template path |

---

## I1 — Init mode

1. **Pre-check** that `.ai.biz/templates/` exists and contains `bootstrap.sh`, `cursorrules.template`, and `work/` template files.
2. **Create `.cursorrules`** — copy `templates/cursorrules.template` to project root (skip if already present). When a file already exists and carries no Business OS wiring, append the managed block with `biz-cursorrules-merge.sh --layout fat` instead of skipping silently: a skipped file means the project has `.work.biz/` and no rules that mention it.
3. **Create `.work.biz/` skeleton** — create directories and copy template files:

   | Output | Source template |
   |--------|----------------|
   | `.work.biz/README.md` | `templates/work/README.md.template` |
   | `.work.biz/gates.md` | `templates/work/gates.md.template` — readiness ledger; every gated skill reads it in its I0 pre-check. Ships with all five gates at `NOT MET` |
   | `.work.biz/context/HANDOFF.md` | `templates/work/context/HANDOFF.md.template` |
   | `.work.biz/plans/NEXT.md` | `templates/work/plans/NEXT.md.template` |
   | `.work.biz/plans/UNKNOWNS.md` | `templates/work/plans/UNKNOWNS.md.template` |
   | `.work.biz/pipeline/pipeline_tracker.md` | `templates/work/pipeline/pipeline_tracker.md.template` |
   | `.work.biz/pipeline/outreach-cadence.md` | `templates/work/pipeline/outreach-cadence.md.template` |
   | `.work.biz/research/research_index.md` | `templates/work/research/research_index.md.template` |
   | `.work.biz/strategy/README.md` | `templates/work/strategy/README.md.template` |
   | `.work.biz/decisions/DECISIONS.md` | `templates/work/decisions/DECISIONS.md.template` — decision ledger: decisions with falsifiable expected outcomes, scored by `@biz-review quarterly` (CONVENTIONS § Decision loop) |
   | `.work.biz/reference/CONTENT_STATUS.md` | `templates/work/reference/CONTENT_STATUS.md.template` — canonical publish/status tracker across all content types; prevents recommending already-published content |
   | `.work.biz/reference/BRAND_STATUS.md` | `templates/work/reference/BRAND_STATUS.md.template` — brand audit history and overhaul log; evidence for the `brand-ready` gate |
   | `.work.biz/reference/VOICE_PROFILE.md` | `templates/work/reference/VOICE_PROFILE.md.template` — how this owner sounds; binding for every content skill on every platform. Ships as a skeleton the owner must fill |
   | `.work.biz/reference/VOICE_RETRO.md` | `templates/work/reference/VOICE_RETRO.md.template` — draft vs owner edits; measures whether the voice profile is working |
   | `.work.biz/reference/OPERATOR_PROFILE.md` | `templates/work/reference/OPERATOR_PROFILE.md.template` — operator skills, proof points, constraints, risk, career stage; filled by `@biz-strategy career`. Ships as a skeleton |
   | `.work.biz/reference/PROJECTS.md` | `templates/work/reference/PROJECTS.md.template` — proof-point bank content, proposals, and calls draw on; disclosure status is binding |

   **Sync rule:** this table, `templates/bootstrap.sh`, `templates/README.md`, `scripts/biz-deploy-basic.sh` `WORK_FILES`, and `skills/biz-deploy-basic/skill.md` must list the same set. `WORK_FILES` is the one that fails quietly: `biz-deploy-basic --update` only offers files listed there, so an artifact missing from it is never updated on existing installs and nothing reports the omission. The same rule binds the directory set: the `bootstrap.sh` dir loop and `WORK_DIRS` must match (`framework-verify.sh` checks both).

   Not scaffolded here, created on first use: `templates/work/pipeline/platform-tracker.md.template` → `.work.biz/pipeline/<platform>-tracker.md`.

4. **Complete** — report summary and next steps.

### Post-init checklist

| # | Task | Owner |
|---|------|-------|
| 1 | Replace every `REPLACE:` token in `.cursorrules` (PROJECT_NAME, UNIFIED_OFFER, TARGET_BUYER, PRICE_RANGE) | User |
| 2 | Review `.work.biz/context/HANDOFF.md` — set date and initial status | User |
| 3 | Review `.work.biz/plans/NEXT.md` — confirm current phase | User |
| 4 | Run `@biz-strategy greenfield` to define niche and offer | Agent |
| 5 | Run `@biz-session start` to open first session | Agent |

---

## I2 — Status mode

Read-only report of the current bootstrap state:

| Check | Evidence |
|-------|----------|
| `.cursorrules` exists at project root | `ls "$PROJECT_ROOT/.cursorrules"` |
| `.work.biz/` directory exists | `ls -d "$PROJECT_ROOT/.work.biz"` |
| `.work.biz/gates.md` exists | `ls "$WORK_DIR/gates.md"` |
| `.work.biz/context/HANDOFF.md` exists | `ls "$WORK_DIR/context/HANDOFF.md"` |
| `.work.biz/plans/NEXT.md` exists | `ls "$WORK_DIR/plans/NEXT.md"` |
| `.work.biz/plans/UNKNOWNS.md` exists | `ls "$WORK_DIR/plans/UNKNOWNS.md"` |
| `.work.biz/pipeline/pipeline_tracker.md` exists | `ls "$WORK_DIR/pipeline/pipeline_tracker.md"` |
| `.work.biz/pipeline/outreach-cadence.md` exists | `ls "$WORK_DIR/pipeline/outreach-cadence.md"` |
| `.work.biz/research/research_index.md` exists | `ls "$WORK_DIR/research/research_index.md"` |
| `.work.biz/strategy/README.md` exists | `ls "$WORK_DIR/strategy/README.md"` |
| `.work.biz/decisions/DECISIONS.md` exists | `ls "$WORK_DIR/decisions/DECISIONS.md"`; report `empty ledger` when it has no `D-NNN` rows — decisions then cannot be scored, so the judgment loop is not running |
| `.work.biz/reference/CONTENT_STATUS.md` exists | `ls "$WORK_DIR/reference/CONTENT_STATUS.md"` |
| `.work.biz/reference/BRAND_STATUS.md` exists | `ls "$WORK_DIR/reference/BRAND_STATUS.md"` |
| `.work.biz/reference/VOICE_PROFILE.md` exists and is filled in | `ls "$WORK_DIR/reference/VOICE_PROFILE.md"`; report `skeleton` if `<` placeholders remain, and warn: content skills fall back to generic human-voice defaults until it is filled |
| `.work.biz/reference/OPERATOR_PROFILE.md` exists and is filled in | `ls "$WORK_DIR/reference/OPERATOR_PROFILE.md"`; report `skeleton` if `<` placeholders remain — run `@biz-strategy career` to fill |
| `.work.biz/reference/PROJECTS.md` exists and has at least one project | `ls "$WORK_DIR/reference/PROJECTS.md"`; report `empty bank` if no project block is filled — content and calls fall back to generic claims until it is |
| Which gates are PASS | `grep -A1 '^## ' "$WORK_DIR/gates.md"` — a fresh bootstrap has all five at `NOT MET` |
| Any `REPLACE:` tokens remain in `.cursorrules` | `grep -c 'REPLACE:' "$PROJECT_ROOT/.cursorrules" \|\| echo 0` |

Output a summary table. If the project is fully bootstrapped, recommend next skill: `@biz-strategy greenfield`. If not yet bootstrapped, recommend `@biz-bootstrap init`.

Close the status report per the Operator handoff contract: any missing artifact or `REPLACE:` token needing operator action goes under `**Needs your approval:**` or `**Needs your answer:**`, followed by exactly one `**Next step:**` command; if nothing is needed, end with `Next: nothing - work complete`.

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | `.cursorrules` created from template (or skipped if existing) | pass |
| 2 | `.work.biz/` skeleton created with all template files | pass |
| 3 | All directories (`context/`, `plans/`, `pipeline/`, `research/`, `drafts/`, `strategy/`, `reference/`, `ideas/`, `ideas.archive/`) exist | pass |
| 3b | `.work.biz/gates.md` exists with all five gates at `NOT MET` | pass |
| 4 | User informed of `REPLACE:` token checklist | pass |
| 5 | User informed of next steps | pass |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

## Next commands

```text
@biz-strategy greenfield        # define niche, offer, target buyer
@biz-session start          # open first session
@biz-brand audit                # assess current brand presence
```

Close the completion report per the Operator handoff contract: list any post-init checklist item needing operator action under `**Needs your approval:**` or `**Needs your answer:**`, then exactly one `**Next step:**` — the immediate command from the list above; if nothing is needed, end with `Next: nothing - work complete`.

---

## References

- `.ai.biz/CONVENTIONS.md` — business phase lifecycle, naming conventions, core principles
- `.ai.biz/START_HERE.md` — decision tree and orchestration flow
- `.ai.biz/templates/README.md` — template map and REPLACE: token reference
- `bootstrap.sh` — shell implementation (`.ai.biz/templates/bootstrap.sh`)
- `.cursorrules` — AI agent rules (project root after init)
