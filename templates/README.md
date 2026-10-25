# Templates (`.ai.biz/templates/`)

Portable starter files for new projects using **Business OS**.

## Quick start

From the **project root** (directory containing `.ai.biz/`):

```bash
bash .ai.biz/templates/bootstrap.sh
```

Or: `@biz-bootstrap init`

---

## What gets created

| Output | Source template |
|--------|-----------------|
| `.cursorrules` (project root) | `cursorrules.template` (full file) — or `cursorrules.biz.snippet.template` (managed block) when the project already has a `.cursorrules` from another OS framework |
| `.work.biz/README.md` | `work/README.md.template` |
| `.work.biz/gates.md` | `work/gates.md.template` |
| `.work.biz/context/HANDOFF.md` | `work/context/HANDOFF.md.template` |
| `.work.biz/plans/NEXT.md` | `work/plans/NEXT.md.template` |
| `.work.biz/plans/UNKNOWNS.md` | `work/plans/UNKNOWNS.md.template` |
| `.work.biz/pipeline/pipeline_tracker.md` | `work/pipeline/pipeline_tracker.md.template` |
| `.work.biz/pipeline/outreach-cadence.md` | `work/pipeline/outreach-cadence.md.template` |
| `.work.biz/research/research_index.md` | `work/research/research_index.md.template` |
| `.work.biz/strategy/README.md` | `work/strategy/README.md.template` |
| `.work.biz/decisions/DECISIONS.md` | `work/decisions/DECISIONS.md.template` |
| `.work.biz/reference/CONTENT_STATUS.md` | `work/reference/CONTENT_STATUS.md.template` |
| `.work.biz/reference/BRAND_STATUS.md` | `work/reference/BRAND_STATUS.md.template` |
| `.work.biz/reference/VOICE_PROFILE.md` | `work/reference/VOICE_PROFILE.md.template` |
| `.work.biz/reference/VOICE_RETRO.md` | `work/reference/VOICE_RETRO.md.template` |
| `.work.biz/reference/OPERATOR_PROFILE.md` | `work/reference/OPERATOR_PROFILE.md.template` |
| `.work.biz/reference/PROJECTS.md` | `work/reference/PROJECTS.md.template` |

Created on demand rather than at bootstrap: `work/pipeline/platform-tracker.md.template` → `.work.biz/pipeline/<platform>-tracker.md`, instantiated on the first publish to a given platform.

Copied manually, not at bootstrap: `work/touch-scope.template` → `.work.biz/touch-scope`, to declare change scope (see `.cursorrules` § Change safety).

### Two `.cursorrules` templates, one rule

| Template | Written when | Installed by |
|----------|--------------|--------------|
| `cursorrules.template` | The project has no `.cursorrules`: this file becomes the whole contract | `@biz-deploy-basic` (thin), `biz-bootstrap init` / `@biz-deploy-files` (fat) |
| `cursorrules.biz.snippet.template` | The project already runs another OS framework: only a managed region is added | `scripts/biz-cursorrules-merge.sh`, called by both deploy skills and by `biz-cursorrules-verify.sh --fix` |

Neither template is ever written over an existing file without the explicit `confirm-overwrite-cursorrules` token. The snippet is delimited by `<!-- BIZ_DESIGN_OS_BEGIN -->` … `<!-- BIZ_DESIGN_OS_END -->`; `update` refreshes only that region. `verify --state` reports `none` / `absent` / `present` / `legacy` / `unterminated`. Multi-framework rules: `COHABITATION.md`.

**Sync rule:** this table, `templates/bootstrap.sh`, `scripts/biz-deploy-basic.sh` `WORK_FILES`, and `skills/biz-bootstrap/skill.md` § I1 must list the same set. `biz-deploy-basic --update` only offers files in `WORK_FILES`, so an omission there means an artifact is silently never updated on existing installs. The directory set is bound the same way: the `bootstrap.sh` dir loop and `WORK_DIRS` must match (`framework-verify.sh` checks both).

Scaffolded as empty directories (no template): `.work.biz/` `context`, `plans`, `pipeline`, `research`, `drafts`, `strategy`, `reference`, `ideas`, `ideas.archive`, `decisions`.

## `REPLACE:` checklist (`.cursorrules`)

| Token | Purpose |
|-------|---------|
| `REPLACE:PROJECT_NAME` | Business / project name |
| `REPLACE:UNIFIED_OFFER` | Your one-line offer |
| `REPLACE:TARGET_BUYER` | Ideal client description |
| `REPLACE:PRICE_RANGE` | Typical price range |
