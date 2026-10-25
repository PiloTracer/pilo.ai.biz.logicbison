---
name: biz-deploy-basic
description: >-
  Thin-client bootstrap of Business OS (.ai.biz) into a target project. Writes
  ONLY the minimal scaffold — .cursorrules (with the AI_BIZ_SOURCE pointer to
  the source) and the .work.biz/ skeleton (HANDOFF, NEXT, UNKNOWNS, pipeline,
  decisions, research). Framework assets (skills, standards, concepts, docs,
  scripts) are NOT copied; the agent resolves them from the source Business OS at
  runtime per .cursorrules § Source resolution. A target that already runs
  another OS framework keeps its .cursorrules: this skill appends one managed
  block between BIZ_DESIGN_OS_BEGIN/END and later refreshes only that region —
  it never replaces the file. Use biz-deploy-basic (default = write or merge),
  biz-deploy-basic update (block refresh + self-heal), biz-deploy-basic status,
  biz-deploy-basic --no-merge, or biz-deploy-basic - <target-path> (outbound from
  source). Never modifies the source. Contrast with biz-deploy-files (fat-client).
---

# biz-deploy-basic

Thin-client deploy of the `.ai.biz` (Business OS) framework. The target project receives only the scaffold it owns (`.cursorrules`, `.work.biz/`); everything else (skills, standards, concepts, docs, scripts, templates) stays in the **source** Business OS and is loaded on demand via the `AI_BIZ_SOURCE` pointer written into `.cursorrules`.

**Shell:** `bash <source>/scripts/biz-deploy-basic.sh <target-path> [mode]` (source framework is self-hosted; `skills/` and `scripts/` live at the repo root)

**Canonical path:** `.ai.biz/skills/biz-deploy-basic/skill.md` · **Shell:** `<source>/scripts/biz-deploy-basic.sh` · **Merge helper:** `<source>/scripts/biz-cursorrules-merge.sh` (block install/refresh) · **Verifier:** `<source>/scripts/biz-cursorrules-verify.sh` · **Multi-framework contract:** `<source>/COHABITATION.md`

**Source not modified.** biz-deploy-basic only writes to the **target**. The source framework is read-only (script reads its templates).

**Contrast with `biz-deploy-files`:** `biz-deploy-files` = **fat-client** (vendored full `.ai.biz/` into target, skills are local). `biz-deploy-basic` = **thin-client** (skills remote in source). Choose:
- `biz-deploy-files` — you want skills/standards/concepts versioned inside the project, offline-editable, no external dependency.
- `biz-deploy-basic` — you want the project to track the live source Business OS, share one source of truth across many consumer repos, and accept new skills/standards automatically by updating the source (no per-project re-deploy).

---

## Parse invocation

| User says | Direction | Mode |
|-----------|-----------|------|
| `@biz-deploy-basic - /path/to/target` | outbound (invoked from source) | thin bootstrap: full template when no `.cursorrules`, managed block when one exists |
| `@biz-deploy-basic` (from target, post-bootstrap) | in-place | idempotent re-run; an existing block is left as is |
| `@biz-deploy-basic update` (from target) | in-place | no-overwrite + **refresh the managed block in place** + re-sync source pointer + re-bake script paths + rules-aware merge of differing `.work.biz/` files |
| `@biz-deploy-basic status` | report | read-only: delegates `.cursorrules` checks to `scripts/biz-cursorrules-verify.sh` (pointer set + reachable + a Business OS root, Source-resolution section, baked script paths, marker pairing, `.work.biz/` skeleton, `REPLACE:` token count) + fat-client leak check + block state |
| `@biz-deploy-basic --no-merge` | in-place | never touches an existing `.cursorrules` (the old skip behaviour, now explicit) |

**Argument forms are equivalent.** Verbs accept the `--` prefix or bare form, `-` / `--` separators are ignored, and the target path may appear in any position:

```text
@biz-deploy-basic "/mnt/work/Projects/system-erp" update
  ≡  @biz-deploy-basic /mnt/work/Projects/system-erp --update
  ≡  @biz-deploy-basic - --update /mnt/work/Projects/system-erp
```

**Default:** bare `@biz-deploy-basic` runs the script default mode, `merge` — idempotent: write the file when absent, append the managed block when the file belongs to another framework, no-op when already wired. Use `status` when the operator is asking for state and nothing should be written. **Aliases:** `bootstrap-biz-thin`, `biz-thin` → bare `@biz-deploy-basic`.

**Target path is REQUIRED when invoked from the source Business OS dir (Scenario #2 / outbound).** The shell aborts with a usage message if no `<target-path>` is supplied; the agent must prompt the user for it rather than guessing. When invoked in-place (target is cwd), the path is implicit (`.`) and no argument is needed.

---

## What gets copied (the local surface)

| Path | Source | If target exists |
|------|--------|-------------------|
| `.cursorrules` (no file yet) | `templates/cursorrules.template` with `AI_BIZ_SOURCE=<source>` substituted, registry self row and sister cells filled, script paths baked | — |
| `.cursorrules` (another framework already owns it) | `templates/cursorrules.biz.snippet.template` appended as one managed block between `<!-- BIZ_DESIGN_OS_BEGIN -->` and `<!-- BIZ_DESIGN_OS_END -->` | existing bytes untouched; re-runs are no-ops, `update` refreshes only the region; `--force` overwrites **only** with the explicit `confirm-overwrite-cursorrules` token (blocked + lost-content report otherwise) |
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
| Target `.cursorrules` exists, has no Business OS wiring, no markers | **Merge**: append the managed block (default). `--no-merge` → skip and report that source-resolution is not wired. `update` → same append, then self-heal. |
| Target `.cursorrules` has exactly one `BIZ_DESIGN_OS_BEGIN`/`END` pair | Refresh semantics: default leaves it as is, `update` rewrites only the region between the markers |
| Target `.cursorrules` has Business OS wiring but no markers (hand merge, or a legacy standalone file) | **Leave alone** (state `legacy`); `update` repairs the pointer and script paths in place and never appends a second block |
| Target `.cursorrules` has an unmatched marker | **Block** (exit 1): the region is ambiguous. Report the marker line; repair by hand or restore from git |
| Framework source reachable under two names (real dir + symlink) | Canonicalised with `pwd -P`: one physical source always bakes one pointer, and that pointer is the real directory |

---

## I1 — Bootstrap protocol

1. Resolve source `BIZ_ROOT` (explicit `BIZ_SOURCE` env, else script's parent). Validate `templates/cursorrules.template` + `skills/` exist.
2. Resolve target = `REPO_ROOT` of the consumer (cwd for in-place, or the named path for outbound).
3. Write or merge `.cursorrules`:
   - **No file** → render `templates/cursorrules.template`, substituting `AI_BIZ_SOURCE=REPLACE_BASICSOURCE` → the absolute canonical source root, filling the registry cells (`REPLACE:AI_*_PATH`, plus the self row which becomes the source root), and baking `bash scripts/<name>` → `bash <root>/scripts/<name>` (these commands live inside `.cursorrules` itself, so the skill-level source-resolution rule does not cover them).
   - **File owned by another framework** → append the block rendered by `scripts/biz-cursorrules-merge.sh` (same substitutions, plus the layout-dependent pointer section). Existing bytes are preserved. `--no-merge` opts out.
   - `--force` overwrites **only** when the operator names `confirm-overwrite-cursorrules` — otherwise BLOCKED (exit 1) with the content that would be lost.
4. Create `.work.biz/` skeleton by copying template files and creating directory structure. `copy_if_missing` enforces no-overwrite.
5. **Post-deploy verification** (every mode): the script runs `scripts/biz-cursorrules-verify.sh` against the target and surfaces any `[FAIL]` findings. In `update` mode unrepairable findings fail the deploy; in `skip`/`force` they are reported as pre-existing with the repair hint.
6. Report: `.cursorrules` state (`none` / `absent` / `present` / `legacy` / `unterminated`), what was written or appended, the source pointer value, `.work.biz/` presence, fat-client leak check, next steps — close per the Operator handoff contract (Form A when nothing is needed, Form B otherwise).

**No local `opencode.json`.** When co-installed with Agent OS, register skills via parent `.ai/opencode.json`.

**Idempotent re-run.** Safe to re-run; no-overwrite preserves target customizations. The source pointer is re-synced only in `update` mode (or `--force confirm-overwrite-cursorrules`).

---

## I2 — update-merge protocol (`@biz-deploy-basic update` only)

After I1 (no-overwrite) the script:

0. **Refreshes the managed block** (`scripts/biz-cursorrules-merge.sh --refresh`): only the bytes between `<!-- BIZ_DESIGN_OS_BEGIN -->` and `<!-- BIZ_DESIGN_OS_END -->` are rewritten, so an updated snippet (new tables, new contracts) reaches every thin target without touching the rest of the file. A standalone or hand-merged file has no block; it is left to step 1.
1. **Repairs via the shared verifier** (`scripts/biz-cursorrules-verify.sh --fix --thin`): appends the block when a target has `.work.biz/` but no Business OS wiring at all (the silent no-op older deploys produced), re-syncs a stale `AI_BIZ_SOURCE` pointer in-place (assignment only — preserves all other target edits) and re-bakes `bash scripts/...` gate-table paths to the current source. Stale-pointer detection is naming-agnostic: a moved `pilo.ai.biz.logicbison` root is repaired even though the path contains no `.ai.biz` segment. **Legacy fallback:** a target still on the old `AGENT_OS_SOURCE=` pointer name is migrated to `AI_BIZ_SOURCE=` (same root, in place) when the value resolves to a Business OS root. **Foreign-pointer guard:** if the existing pointer resolves to a valid root of a *different* framework (e.g. an Agent OS `.ai` in a mixed project — including a foreign `AGENT_OS_SOURCE`), it is left untouched — repair it with that framework's own deploy update.
2. **Lists merge candidates** among the local surface: existing-but-differing files vs the current source templates (substituted). Candidates:
   - `.cursorrules` (standalone/legacy only — a managed block is refreshed mechanically, and a foreign file was already handled by the append; neither becomes an agent diff)
   - `.work.biz/<file>` (target has user content; templates are skeletons)
3. The **agent** then performs a rules-aware merge per candidate (this is agent work, not script work).

### Merge rules per file class

| Class | Merge rule |
|-------|------------|
| `.cursorrules` — managed block (`present`) | **Mechanical, not agent work.** `update` rewrites the region between the markers from the current snippet and stops there. Do not hand-edit inside the markers; do not re-order anything outside them. |
| `.cursorrules` — foreign file, no Business OS wiring (`absent`) | **Append only** (`biz-cursorrules-merge.sh merge`). Never a rewrite, never a re-order: the other frameworks' sections are not ours. Whether the operator asked for merge or not, report that the block was appended and what it contains. |
| `.cursorrules` — legacy/hand-merged (`legacy`) | Update framework sections in place (Skills table, Protected files, **Source resolution**, Frameworks registry). Preserve target-filled `REPLACE:` tokens, target customizations, target-specific protected-file paths. Never wholesale-replace, and never append a second block. **Check the pointer NAME in the prose**: the legacy `AGENT_OS_SOURCE=` → `AI_BIZ_SOURCE=` migration renames the assignment only, so a migrated hand merge can keep rules that tell the agent to read `$AGENT_OS_SOURCE/…` — a variable that no longer exists (or belongs to another framework). `biz-cursorrules-verify.sh` warns on that mismatch inside the source-resolution section; fix the prose, not the pointer. |
| `.cursorrules` — standalone full template | Diff against the current substituted template; merge new sections and preserve filled tokens. Converting it to a marked block is the agent's call, offered as a merge candidate — not a silent rewrite. |
| `.work.biz/<file>` skeletons | Append new template sections absent in target; **preserve all user content** (HANDOFF rows, NEXT iteration blocks, UNKNOWNS entries, pipeline data). Skeletons are minimal — most merges add no new sections. Never drop target rows. |
| `.work.biz/<dir>` | Create any NEW scaffold dir that didn't exist (e.g. a new sub-dir added since last bootstrap); do not touch existing. |

### Preserve invariants (never drop)
- Target's filled `REPLACE:` tokens (the merge keeps target values, not source `REPLACE:*` placeholders).
- Target's `AI_BIZ_SOURCE` line, in-place value (synced, not reset to `REPLACE_BASICSOURCE`).
- Target's custom content in `.work.biz/` files — any HANDOFF rows, NEXT items, pipeline data, research notes the user or `biz-*` skills produced.
- Target's git history, `.gitignore`, app code — all untouched.

---

## I3 — status (read-only)

Delegates `.cursorrules` checks to `scripts/biz-cursorrules-verify.sh` (single source of truth) and adds the thin-client layout lines. In a merged layout the verifier scopes its change-safety checks to the business region, so another framework's `bash scripts/…` convention is not reported as a Business OS failure. Reports:

| Check | Output |
|-------|--------|
| `.cursorrules` present | pass / missing |
| Managed block state | `present` (markers paired, lines reported) / `legacy` (wired, unmarked) / `absent` (unwired) / `unterminated` (broken pair — FAIL) |
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
| 3 | Target `.cursorrules` carries Business OS wiring: valid `AI_BIZ_SOURCE` in thin-client, or a local `.ai.biz/` + block in fat-client | |
| 3b | If the target already had a `.cursorrules`, only the managed block was added — content outside the markers is byte-identical, and the other framework's sections are intact | |
| 3c | Marker pair is complete and correctly ordered (`unterminated`/inverted is a BLOCK, never repaired by guesswork) | |
| 4 | Source-resolution section present in target `.cursorrules` | |
| 5 | `.work.biz/` skeleton present (HANDOFF, NEXT, UNKNOWNS at minimum) | |
| 6 | No-overwrite honored (existing target files preserved; `--force` only with the explicit `confirm-overwrite-cursorrules` token) | |
| 7 | `update`: managed block refreshed in place; source pointer re-synced if stale (naming-agnostic); script paths baked; `.work.biz/` merge candidates listed; no wholesale replaces; foreign-framework pointer left untouched | |
| 8 | Fat-client leak checked (no unexpected local `.ai.biz/skills/`) | |
| 9 | Post-deploy verification ran (`biz-cursorrules-verify.sh`); `[FAIL]` findings surfaced or repaired | |
| 10 | User informed that skills load from `$AI_BIZ_SOURCE` at runtime + next steps (the "fill REPLACE: tokens" step is only reported when a full template was written) | |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

## Next commands (in target project)

```text
# Verify the source is reachable from the target's perspective:
test -d "$(grep -oE 'AI_BIZ_SOURCE=[^ ]*' .cursorrules | head -1 | cut -d= -f2-)"

# Prove the managed block is paired (and see its line range):
bash "$(grep -oE 'AI_BIZ_SOURCE=[^ ]*' .cursorrules | head -1 | cut -d= -f2-)/scripts/biz-cursorrules-merge.sh" . --state

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
| Target already has `.cursorrules` from another OS framework | State `absent` → append the managed block and report it; offer `--no-merge` for a hold-out. Never overwrite, never re-order, never edit outside the markers (`COHABITATION.md`). |
| Target `.cursorrules` has Business OS wiring but no markers | State `legacy` → leave it; say that migration to a marked block is available and what it changes, but do not do it silently. |
| Target `.cursorrules` has an unmatched marker | BLOCK: report the marker line and the two safe repairs (restore from git, or delete the orphan marker by hand). Never append a "fix-it" block. |
| `update` finds `.cursorrules` with no Business OS wiring at all | The silent no-op older deploys produced. `update` appends the block through the verifier's self-heal; if the append is impossible (no snippet template, unwritable file), FAIL loudly rather than reporting success. |
| Source moved since last bootstrap | `update` re-syncs the pointer in-place; report old→new. If source unreachable, report `business-os source unreachable` and stop. |

---

## Anti-patterns

- Copying `skills/`/`standards/`/`concepts/` into the target (that defeats thin-client; use `@biz-deploy-files` instead).
- Wholesale-replacing `.cursorrules` or `.work.biz/context/HANDOFF.md` on `update`.
- Reporting a successful deploy into a target that already had a `.cursorrules` while writing no Business OS wiring — the original defect behind the managed block. If `AI_BIZ_SOURCE` and the block are both absent at the end, the deploy failed.
- Appending a managed block to a file that already has one (or has hand-merged Business OS sections): the second block double-defines the skills table and the source pointer.
- Editing, re-ordering, or "tidying" another framework's sections while merging — the file is shared ownership, not a draft.
- Resetting `AI_BIZ_SOURCE` to `REPLACE_BASICSOURCE` instead of the resolved path.
- Running `@biz-deploy-basic` and expecting skills to work offline — thin-client requires the source path to remain reachable.
- Failing to verify `$AI_BIZ_SOURCE` is readable before claiming bootstrap complete.
- Invoking `@biz-deploy-basic -` from the source dir **without** a target path — the shell aborts; the agent must prompt for the target rather than guessing or defaulting to the source's own cwd.
- Using `biz-deploy-basic` to "upgrade" a fat-client repo without first removing the local `.ai.biz/` (creates a mixed state; skills resolve fat-client first).
