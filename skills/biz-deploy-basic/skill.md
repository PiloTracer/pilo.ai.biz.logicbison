---
name: biz-deploy-basic
description: >-
  Thin-client bootstrap of Business OS (.ai.biz) into a target project. Copies
  ONLY the minimal scaffold — .cursorrules (with AI_BIZ_SOURCE pointer to the
  source .ai.biz) and .work.biz/ skeleton (HANDOFF, NEXT, UNKNOWNS, pipeline,
  research). Framework assets (skills, standards, concepts, docs, scripts) are
  NOT copied; the agent resolves them from the source Business OS at runtime per
  .cursorrules § Source resolution. Use biz-deploy-basic (default), biz-deploy-basic
  update, biz-deploy-basic status, or biz-deploy-basic - <target-path> (outbound from
  source). Never modifies the source. Contrast with biz-deploy-files (full fat-client
  copy of .ai.biz/).
---

# biz-deploy-basic

Thin-client deploy of the `.ai.biz` (Business OS) framework. The target project receives only the scaffold it owns (`.cursorrules`, `.work.biz/`); everything else (skills, standards, concepts, docs, scripts, templates) stays in the **source** Business OS and is loaded on demand via the `AI_BIZ_SOURCE` pointer written into `.cursorrules`.

**Shell:** `bash <source>/scripts/biz-deploy-basic.sh <target-path> [mode]` (source framework is self-hosted; `skills/` and `scripts/` live at the repo root)

**Canonical path:** `.ai.biz/skills/biz-deploy-basic/skill.md` · **Shell:** `<source>/scripts/biz-deploy-basic.sh`

**Source not modified.** biz-deploy-basic only writes to the **target**. The source framework is read-only (script reads its templates).

**Contrast with `biz-deploy-files`:** `biz-deploy-files` = **fat-client** (vendored full `.ai.biz/` into target, skills are local). `biz-deploy-basic` = **thin-client** (skills remote in source). Choose:
- `biz-deploy-files` — you want skills/standards/concepts versioned inside the project, offline-editable, no external dependency.
- `biz-deploy-basic` — you want the project to track the live source Business OS, share one source of truth across many consumer repos, and accept new skills/standards automatically by updating the source (no per-project re-deploy).

---

## Parse invocation

| User says | Direction | Mode |
|-----------|-----------|------|
| `@biz-deploy-basic - /path/to/target` | outbound (invoked from source) | thin bootstrap no-overwrite |
| `@biz-deploy-basic` (from target, post-bootstrap) | in-place | re-runs no-overwrite bootstrap + source-pointer sync |
| `@biz-deploy-basic update` (from target) | in-place | no-overwrite + re-sync source pointer + re-bake script paths + agent rules-aware merge of differing local-surface files |
| `@biz-deploy-basic status` | report | read-only: delegates `.cursorrules` checks to `scripts/biz-cursorrules-verify.sh` (pointer set + reachable + a Business OS root, Source-resolution section, baked script paths, `.work.biz/` skeleton, `REPLACE:` token count) + fat-client leak check |

**Argument forms are equivalent.** Verbs accept the `--` prefix or bare form, `-` / `--` separators are ignored, and the target path may appear in any position:

```text
@biz-deploy-basic "/mnt/work/Projects/system-erp" update
  ≡  @biz-deploy-basic /mnt/work/Projects/system-erp --update
  ≡  @biz-deploy-basic - --update /mnt/work/Projects/system-erp
```

**Default:** `status` if no verb matches. **Aliases:** `bootstrap-biz-thin`, `biz-thin` → bare `@biz-deploy-basic`.

**Target path is REQUIRED when invoked from the source Business OS dir (Scenario #2 / outbound).** The shell aborts with a usage message if no `<target-path>` is supplied; the agent must prompt the user for it rather than guessing. When invoked in-place (target is cwd), the path is implicit (`.`) and no argument is needed.

---

## What gets copied (the local surface)

| Path | Source | If target exists |
|------|--------|-------------------|
| `.cursorrules` | `templates/cursorrules.template` with `AI_BIZ_SOURCE=<source>` substituted | skip (preserve); `--force` overwrites **only** with the explicit `confirm-overwrite-cursorrules` token (blocked + lost-content report otherwise) |
| `.work.biz/README.md`, `gates.md`, `context/HANDOFF.md`, `plans/NEXT.md`, `plans/UNKNOWNS.md`, `pipeline/pipeline_tracker.md`, `pipeline/outreach-cadence.md`, `research/research_index.md`, `strategy/README.md`, `decisions/DECISIONS.md`, `reference/CONTENT_STATUS.md`, `reference/BRAND_STATUS.md`, `reference/VOICE_PROFILE.md`, `reference/VOICE_RETRO.md`, `reference/OPERATOR_PROFILE.md`, `reference/PROJECTS.md` | `templates/work/*.template` (suffix stripped) | skip (preserve) |
| `.work.biz/{context,plans,pipeline,research,drafts,strategy,reference,ideas,ideas.archive,decisions}/` | created empty dirs | skip (preserve) |

**Sync rule:** this list, `scripts/biz-deploy-basic.sh` `WORK_FILES`, `templates/bootstrap.sh`, `templates/README.md`, and `skills/biz-bootstrap/skill.md` § I1 must agree. `--update` only offers files in `WORK_FILES`, so an omission there means the artifact is silently never updated on an existing install. The directory set is bound the same way: the `bootstrap.sh` dir loop and `WORK_DIRS` must match (`framework-verify.sh` checks both).

**Explicitly NOT copied (stay in source, loaded at runtime):** `skills/**`, `standards/**`, `concepts/**`, `docs/**`, `scripts/**`, `templates/**`, `SKILL_DEPENDENCIES.md`, root `README.md`, `PROCESS_ROUTER.md`, `START_HERE.md`, `CONVENTIONS.md`, `.github/`, `.gitignore`, `.gitattributes`.

---

## I0 — Pre-checks

| Condition | Action |
|-----------|--------|
| Source `templates/cursorrules.template` missing | **Block**: source is not a valid `.ai.biz` framework root |
| Source `skills/` directory missing | **Block**: source is not a valid `.ai.biz` framework root |
| Target dir does not exist | **Block**: report missing path |
| Target already has local `.ai.biz/skills/` | **Block** fat-client leak (use `--force` with `confirm-overwrite-cursorrules` when `.cursorrules` exists, or remove local `.ai.biz/` first) |
| Target `.cursorrules` exists + lacks `AI_BIZ_SOURCE=` line (and no legacy `AGENT_OS_SOURCE=` line) | In `update` mode → flag as **MERGE CANDIDATE** (the Source-resolution section is missing); in default mode → skip (preserve) and report that source-resolution is not wired. |

---

## I1 — Bootstrap protocol

1. Resolve source `BIZ_ROOT` (explicit `BIZ_SOURCE` env, else script's parent). Validate `templates/cursorrules.template` + `skills/` exist.
2. Resolve target = `REPO_ROOT` of the consumer (cwd for in-place, or the named path for outbound).
3. Write `.cursorrules` into the target from the template, substituting `AI_BIZ_SOURCE=REPLACE_BASICSOURCE` → `AI_BIZ_SOURCE=<absolute BIZ_ROOT>` and baking `bash scripts/<name>` → `bash <BIZ_ROOT>/scripts/<name>` (Change-safety gate table + git-hooks install line — these commands live inside `.cursorrules` itself, so the skill-level source-resolution rule doesn't cover them). **No-overwrite** if `.cursorrules` exists; `--force` overwrites **only** when the operator names `confirm-overwrite-cursorrules` — otherwise BLOCKED (exit 1) with the content that would be lost.
4. Create `.work.biz/` skeleton by copying template files and creating directory structure. `copy_if_missing` enforces no-overwrite.
5. **Post-deploy verification** (every mode): the script runs `scripts/biz-cursorrules-verify.sh` against the target and surfaces any `[FAIL]` findings. In `update` mode unrepairable findings fail the deploy; in `skip`/`force` they are reported as pre-existing with the repair hint.
6. Report: source pointer value, `.work.biz/` presence, fat-client leak check, next steps — close per the Operator handoff contract (Form A when nothing is needed, Form B otherwise).

**No local `opencode.json`.** When co-installed with Agent OS, register skills via parent `.ai/opencode.json`.

**Idempotent re-run.** Safe to re-run; no-overwrite preserves target customizations. The source pointer is re-synced only in `update` mode (or `--force confirm-overwrite-cursorrules`).

---

## I2 — update-merge protocol (`@biz-deploy-basic update` only)

After I1 (no-overwrite) the script:

1. **Repairs via the shared verifier** (`scripts/biz-cursorrules-verify.sh --fix --thin`): re-syncs a stale `AI_BIZ_SOURCE` pointer in-place (assignment only — preserves all other target edits) and re-bakes `bash scripts/...` gate-table paths to the current source. **Legacy fallback:** a target still on the old `AGENT_OS_SOURCE=` pointer name is migrated to `AI_BIZ_SOURCE=` (same root, in place) when the value resolves to a Business OS root. **Foreign-pointer guard:** if the existing pointer resolves to a valid root of a *different* framework (e.g. an Agent OS `.ai` in a mixed project — including a foreign `AGENT_OS_SOURCE`), it is left untouched — repair it with that framework's own deploy update.
2. **Lists merge candidates** among the local surface: existing-but-differing files vs the current source templates (substituted). Candidates:
   - `.cursorrules` (differs from current `template-with-source`)
   - `.work.biz/<file>` (target has user content; templates are skeletons)
3. The **agent** then performs a rules-aware merge per candidate (this is agent work, not script work).

### Merge rules per file class

| Class | Merge rule |
|-------|------------|
| `.cursorrules` | Update framework sections (Skills table, Core principles, Protected files, **Source resolution** section, Frameworks registry). Preserve target-filled `REPLACE:` tokens, target customizations, target-specific protected-file paths. If target lacks the Source-resolution section entirely (fat-client template) → append it with the current `AI_BIZ_SOURCE`. Never wholesale-replace. |
| `.work.biz/<file>` skeletons | Append new template sections absent in target; **preserve all user content** (HANDOFF rows, NEXT iteration blocks, UNKNOWNS entries, pipeline data). Skeletons are minimal — most merges add no new sections. Never drop target rows. |
| `.work.biz/<dir>` | Create any NEW scaffold dir that didn't exist (e.g. a new sub-dir added since last bootstrap); do not touch existing. |

### Preserve invariants (never drop)
- Target's filled `REPLACE:` tokens (the merge keeps target values, not source `REPLACE:*` placeholders).
- Target's `AI_BIZ_SOURCE` line, in-place value (synced, not reset to `REPLACE_BASICSOURCE`).
- Target's custom content in `.work.biz/` files — any HANDOFF rows, NEXT items, pipeline data, research notes the user or `biz-*` skills produced.
- Target's git history, `.gitignore`, app code — all untouched.

---

## I3 — status (read-only)

Delegates `.cursorrules` checks to `scripts/biz-cursorrules-verify.sh` (single source of truth) and adds the thin-client layout lines. Reports:

| Check | Output |
|-------|--------|
| `.cursorrules` present | pass / missing |
| `AI_BIZ_SOURCE` value + reachable + a Business OS root | pass / unfilled / unreachable / foreign-framework pointer (warn — mixed project) |
| Baked gate-table script paths | pass / unbaked literals / stale prefix |
| Source-resolution section present | pass / missing (merge candidate) |
| `.work.biz/` skeleton (HANDOFF, NEXT, UNKNOWNS) | pass / missing |
| Local `.ai.biz/skills/` exists (fat-client leak) | no (good, thin) / yes (warn — mixed) |
| `REPLACE:` tokens remaining in `.cursorrules` | count (excludes `AI_BIZ_SOURCE` which is filled) |

Exit code is non-zero when any `[FAIL]` finding remains, so `status` doubles as a CI/deploy gate.

### `biz-cursorrules-verify.sh` (standalone use)

```bash
bash scripts/biz-cursorrules-verify.sh <target-root>            # read-only audit
bash scripts/biz-cursorrules-verify.sh <target-root> --fix      # mechanical repairs (pointer re-sync, script-path baking)
bash scripts/biz-cursorrules-verify.sh --fix --thin <target>    # force layout
```

Flags accept `--` or bare form (`fix` ≡ `--fix`); path may appear in any position. Exit: 0 = pass · 1 = FAIL findings · 2 = usage.

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | Source `templates/cursorrules.template` readable | pass |
| 2 | Source `skills/` directory present | pass |
| 3 | Target `.cursorrules` exists with valid `AI_BIZ_SOURCE` (resolves to a Business OS root) | |
| 4 | Source-resolution section present in target `.cursorrules` | |
| 5 | `.work.biz/` skeleton present (HANDOFF, NEXT, UNKNOWNS at minimum) | |
| 6 | No-overwrite honored (existing target files preserved; `--force` only with the explicit `confirm-overwrite-cursorrules` token) | |
| 7 | `update`: source pointer re-synced if stale; script paths baked; merge candidate list produced; no wholesale replaces; foreign-framework pointer left untouched | |
| 8 | Fat-client leak checked (no unexpected local `.ai.biz/skills/`) | |
| 9 | Post-deploy verification ran (`biz-cursorrules-verify.sh`); `[FAIL]` findings surfaced or repaired | |
| 10 | User informed that skills load from `$AI_BIZ_SOURCE` at runtime + next steps | |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

## Next commands (in target project)

```text
# Verify the source is reachable from the target's perspective:
test -d "$(grep -oE 'AI_BIZ_SOURCE=[^ ]*' .cursorrules | head -1 | cut -d= -f2-)"

# Fill remaining REPLACE tokens in .cursorrules (NOT AI_BIZ_SOURCE — biz-deploy-basic set it):
#   rg 'REPLACE:' .cursorrules

# First skill invocation — loads from source:
@biz-session start

# Load context without writing handoff (uncommitted-aware):
@biz-session context
```

---

## Critical interactions

| When | Ask / do |
|------|----------|
| Invoked from target with no source pointer yet (greenfield, no `.cursorrules`) | The skill itself can't be loaded in thin-client mode before bootstrap. Tell the user to run the shell directly: `bash /abs/path/to/source/scripts/biz-deploy-basic.sh .` — chicken-and-egg escape (see `.cursorrules` § Source resolution). |
| Bootstrap target already has `.ai.biz/skills/` (fat-client) | Warn; ask: convert to thin (delete local `.ai.biz/`)?, keep mixed (skills resolve local-first per fat-client rule — unexpected)?, or abort? Do not silently leave a mixed state. |
| `update` finds `.cursorrules` with no `AI_BIZ_SOURCE` line (and no legacy `AGENT_OS_SOURCE` line) | Fat-client template detected → flag as merge candidate; agent appends the Source-resolution section with current source value. |
| Source moved since last bootstrap | `update` re-syncs the pointer in-place; report old→new. If source unreachable, report `business-os source unreachable` and stop. |

---

## Anti-patterns

- Copying `skills/`/`standards/`/`concepts/` into the target (that defeats thin-client; use `@biz-deploy-files` instead).
- Wholesale-replacing `.cursorrules` or `.work.biz/context/HANDOFF.md` on `update`.
- Resetting `AI_BIZ_SOURCE` to `REPLACE_BASICSOURCE` instead of the resolved path.
- Running `@biz-deploy-basic` and expecting skills to work offline — thin-client requires the source path to remain reachable.
- Failing to verify `$AI_BIZ_SOURCE` is readable before claiming bootstrap complete.
- Invoking `@biz-deploy-basic -` from the source dir **without** a target path — the shell aborts; the agent must prompt for the target rather than guessing or defaulting to the source's own cwd.
- Using `biz-deploy-basic` to "upgrade" a fat-client repo without first removing the local `.ai.biz/` (creates a mixed state; skills resolve fat-client first).
