# Cohabitation — Business OS inside a project that already runs another OS framework

**Status:** Binding · **Needs:** none · **Applies to:** `@biz-deploy-basic`, `@biz-deploy-files`, `@biz-bootstrap`, and every agent working in a multi-framework repo.

A project that already runs Agent OS, UI Design OS, Social OS, or any of the sister frameworks already owns a `.cursorrules`. That file is a shared contract between frameworks, and it is the one artifact a careless deploy destroys: it is hand-merged, it accumulates another framework's rules, and it is usually tracked in git. This document defines how Business OS takes its place in it without breaking anything.

---

## 1. Ownership model

A multi-framework `.cursorrules` is a **union of managed regions**. Each framework owns a delimited region and nothing else.

| Region | Owner | Delimiter (today) |
|--------|-------|-------------------|
| Project identity, engineering rules, agent core principles | the project / Agent OS | none (unmanaged — nobody's to rewrite) |
| UI rules | UI Design OS | `<!-- UI_DESIGN_OS_BEGIN -->` … `<!-- UI_DESIGN_OS_END -->` |
| Social rules | Social OS | `<!-- SOC_DESIGN_OS_BEGIN -->` … `<!-- SOC_DESIGN_OS_END -->` |
| Business strategy, gates, skills, `.work.biz/` | **Business OS** | `<!-- BIZ_DESIGN_OS_BEGIN -->` … `<!-- BIZ_DESIGN_OS_END -->` |

Rules that follow from the model:

1. **A framework writes only inside its own markers.** Business OS never reorders, reformats, or rewrites a line outside `BIZ_DESIGN_OS_*`.
2. **Unmanaged content is not ours to judge.** The verifier scopes its script-path and source-resolution checks to the business region when one exists; another framework's `bash scripts/…` convention is not a Business OS finding.
3. **A missing block is not proof of absence.** Older hand-merged installs may carry Business OS wiring with no markers. That is detected as `legacy` and left alone — never "fixed" by appending a second block.
4. **An unmatched marker is a broken merge, not a formatting detail.** Report it and stop; do not guess the intended region.

---

## 2. What `@biz-deploy-basic` does to an existing `.cursorrules`

| Target shape | Detected as | Action |
|--------------|-------------|--------|
| No `.cursorrules` | `none` | Write the full thin-client template |
| Standalone Business OS file (own template) | `legacy` | Leave alone; repair pointer/paths in place on `update` |
| Foreign file with no Business OS wiring | `absent` | **Append** the managed block; existing bytes untouched |
| Foreign file with the managed block | `present` | No-op on deploy; **refresh only the region** on `update` |
| Foreign file, `--no-merge` | any | Touch nothing (explicit opt-out) |
| Half-deleted marker pair | `unterminated` | Refuse and exit non-zero; file untouched |
| `--force confirm-overwrite-cursorrules` | any | Replace the whole file — destroys every other framework's region; same-message approval only |

The append is the only write Business OS performs outside a file it created itself, and it is additive: the file's existing bytes are preserved, a single blank line and the block are added at the end. Business OS never *deletes* on a deploy.

`@biz-deploy-files` (fat-client, vendored `.ai.biz/`) follows the same table with the fat layout: no source pointer, `.ai.biz/` paths, same markers.

---

## 3. Directory ownership

| Directory | Owner | Business OS may |
|-----------|-------|-----------------|
| `.work/` | Agent OS | read a cross-link; **never write** |
| `.work.ui/` | UI Design OS | read a cross-link; **never write** |
| `.work.biz/` | Business OS | read and write freely |
| `.ai.biz/` (fat-client) | Business OS framework copy | read; write only via a deploy |
| `.ai/`, `.ai.ui/`, … | sister frameworks | read only through the registry |

A business deliverable that must change a shared surface (a `README`, a landing page, a brand asset the UI framework also edits) states the change and asks in the same message. Writing into `.work/` because it was convenient is the most common cross-framework break, and it is invisible until the other framework reads a corrupted ledger.

---

## 4. Recovery

| Symptom | Cause | Fix |
|---------|-------|-----|
| `.work.biz/` exists, no Business OS wiring, verifier FAILs on `AI_BIZ_SOURCE` | deploy ran before the merge behaviour existed, or an operator used `--no-merge` | `@biz-deploy-basic update` (appends the block; nothing else changes) |
| `AI_BIZ_SOURCE` points at a path that no longer exists | the framework source moved or was renamed | `@biz-deploy-basic update` — re-syncs the pointer and re-bakes script paths in place |
| Block content looks stale after a framework update | the block is a snapshot taken at deploy time | `@biz-deploy-basic update` (refreshes only the region between the markers) |
| Two `BIZ_DESIGN_OS_BEGIN` markers | a hand copy plus a deploy | `@biz-deploy-basic status` reports `unterminated`; remove the duplicated region by hand, then `update` |
| Another framework's rules disappeared | `--force confirm-overwrite-cursorrules` was used | restore `.cursorrules` from git; never force-replace a shared file |

The verifier is the single source of truth for all of these: `bash $AI_BIZ_SOURCE/scripts/biz-cursorrules-verify.sh <repo-root>` (read-only) and `--fix` (mechanical repairs). `@biz-deploy-basic status` is the report form.

---

## 5. Paths in a thin-client target

A thin-client consumer holds **no framework files** — only `.cursorrules` and `.work.biz/`. Every framework reference therefore resolves through the pointer:

```
AI_BIZ_SOURCE=/abs/path/to/business-os     # baked by @biz-deploy-basic, canonicalised with pwd -P
```

- The baked path is the **real directory** the framework lives in, not a symlinked alias. A framework reachable as both `/x/.ai.biz` and `/x/pilo.ai.biz.logicbison` must produce one pointer, or the same deploy quoted from two shells bakes two different paths and the stale-pointer repair cannot tell them apart.
- `.work.biz/...` and application code always resolve **locally**.
- Command cells in the change-safety table are baked to absolute paths at deploy time because they are executed, not read.
- Documentation references use `$AI_BIZ_SOURCE/…` so they survive a source move without a re-deploy.

---

## 6. Running the two deploy skills together

| Want | Use | Result |
|------|-----|--------|
| Project tracks the live source; new skills arrive without re-deploying | `@biz-deploy-basic` | `.cursorrules` block + `.work.biz/`, no framework copy |
| Skills and standards versioned inside the repo; offline-editable | `@biz-deploy-files` | `.ai.biz/` vendored + `.work.biz/` + block |

Do not run both in one repo. A mixed tree resolves skills local-first (fat wins), so the thin pointer stops describing reality — the verifier reports it as a mixed state. Convert deliberately: remove the local `.ai.biz/`, then `@biz-deploy-basic update`.

---

## Next action

Next action: none — this document describes behaviour already enforced by `scripts/biz-cursorrules-merge.sh`, `scripts/biz-cursorrules-verify.sh` and the regression checks in `scripts/framework-verify.sh`.
