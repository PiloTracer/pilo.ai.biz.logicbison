---
name: biz-deploy-files
description: >-
  Deploy .ai.biz (Business OS) files into a target project. Two directions:
  (1) in-place bootstrap — invoked from a TARGET project, copies the source
  .ai.biz in without overwriting existing files, then scaffolds .work.biz/ +
  .cursorrules; (2) outbound copy — invoked from the source .ai.biz repo,
  copies into an explicit <path>. `update` mode additionally performs a
  rules-aware merge of existing-but-differing files. Copies only git-tracked /
  non-ignored files. Use biz-deploy-files (default), biz-deploy-files update,
  biz-deploy-files copy - <path>, biz-deploy-files status.
---

# biz-deploy-files

Two-direction deploy of the `.ai.biz` framework into a target project. **Default = no-overwrite**: existing target files are preserved by construction.

**Shell:** `bash <source>/scripts/biz-deploy-files.sh <target-path> [--force|--update]`
**Scaffold shell:** `REPO_ROOT=<target> BIZ_SOURCE=<source> bash <source>/templates/bootstrap.sh`

**Canonical path:** `.ai.biz/skills/biz-deploy-files/skill.md` · **Shell:** `<source>/scripts/biz-deploy-files.sh`

**Security invariant:** The script enumerates files via `git ls-files --cached --others --exclude-standard` from the **source** Business OS repo root.

**No local `opencode.json`.** When co-installed with Agent OS, register skills via parent `.ai/opencode.json`.

`biz-deploy-files` copies only the `.ai.biz/` directory (no VCS artifacts). For a full repo mirror, use plain `git clone` out-of-band.

---

## Parse invocation

| User says | Direction | Mode |
|-----------|-----------|------|
| `@biz-deploy-files` | in-place (cwd is target) | copy no-overwrite + scaffold no-overwrite |
| `@biz-deploy-files update` | in-place | copy no-overwrite + scaffold + verifier repair (`--fix`) + **rules-aware merge** |
| `@biz-deploy-files copy - /path/to/repo` | outbound | copy no-overwrite to `/path/to/repo/.ai.biz` |
| `@biz-deploy-files copy - /path/to/repo --force` | outbound | legacy overwrite |
| `@biz-deploy-files status` | report | `.ai.biz/skills` presence + read-only `.cursorrules` verification via `scripts/biz-cursorrules-verify.sh` |

**Argument forms are equivalent.** Verbs accept the `--` prefix or bare form, `-` / `--` separators are ignored, and the target path may appear in any position:

```text
@biz-deploy-files copy - /path/to/repo update
  ≡  @biz-deploy-files /path/to/repo --update
```

**Default:** `status` if no verb matches; bare invoke with no local `.ai.biz/` → in-place bootstrap.

Path auto-resolution: if the path ends in `.ai.biz` it is used as-is; otherwise `.ai.biz` is appended.

---

## I0 — Pre-checks

| Condition | Action |
|-----------|--------|
| Source is not a git repo | **Block** |
| Target parent dir does not exist | **Block** |
| Destination already has `.ai.biz/` | Proceed with **no-overwrite**; report skipped count |

---

## I1 — Copy mode (no-overwrite by default)

1. `bash <source>/scripts/biz-deploy-files.sh "<resolved-target>"` — or `--force` / `--update`.
2. **Skill-level omissions:** `.github/`, `.gitignore`, `.gitattributes`, `.cursorrules`, deploy scripts (`biz-deploy-*.sh`, `biz-cursorrules-verify.sh`).
3. **No-overwrite default:** `rsync --ignore-existing`. `--update` emits merge candidate list.

---

## I2 — Scaffold (in-place only)

When invoked in-place, after copy the script chains bootstrap into the target:

```bash
REPO_ROOT=<target> BIZ_SOURCE=<source> bash <source>/templates/bootstrap.sh
```

**Outbound `copy - <path>` does NOT scaffold** — run `@biz-bootstrap init` in target.

**Post-deploy verification (in-place only):** after scaffolding, the script runs `scripts/biz-cursorrules-verify.sh` against the target — `--fix` in `update` mode (pointer re-sync + script-path baking), read-only otherwise. Unrepairable `[FAIL]` findings fail an `update` deploy; otherwise they are reported with the repair hint.

---

## I3 — update-merge protocol

Agent performs rules-aware merge for each merge candidate (skills, standards, docs, templates, scripts). Preserve target `REPLACE:` tokens and target-only content. Never wholesale-replace.

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | Source repo is git root | pass |
| 2 | Destination `.ai.biz/` exists | |
| 3 | No `.gitignored` content copied | |
| 4 | Scaffold ran (in-place only) | |
| 5 | `update`: merge candidates processed | |
| 6 | Post-deploy verification ran (in-place); `[FAIL]` findings surfaced or repaired | |

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

The completed checklist closes with Form A (e.g. `Next: nothing - deploy complete`) when nothing is needed, else Form B per the contract above.

## Next commands

```text
@biz-session start
@biz-strategy greenfield
```
