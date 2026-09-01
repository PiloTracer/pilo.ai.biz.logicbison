---
name: biz-session
description: >-
  Session open, close, context, status, and scoped git operations.
  Commit scope depends on repo role: in the Business OS source repo
  (framework at git root) commit/push apply to ALL modified/added/new
  files repo-wide; in a target project they apply to the `.work.biz/`
  working directory only. Verbs: start (full context load + mark
  HANDOFF Open), close (write HANDOFF/NEXT/UNKNOWNS; commit/push only
  when requested), commit / commit push (standalone: git add + commit
  + optional push, NO HANDOFF/NEXT writes, session stays open), add
  (stage the commit scope only, no commit), context (read-only full
  load, uncommitted-aware), status (compact snapshot). Modifiers:
  commit, push, scoped. Order-independent and combinable: biz-session
  close, close commit, close commit scoped, close push, close commit
  push, commit, commit push, add, context, status. On commit, MUST run
  git add + git commit in the shell for all safe changes in scope —
  including new untracked files/dirs. Always shows the commit message
  (draft or used). Never commits unless the invocation includes commit
  or push. Aliased as session-control (session-control start, close,
  commit, context, status map to the same operations).
---

# biz-session

**Purpose:** Bookend AI work sessions so the next chat (or human) can resume without guessing. Start loads context and marks the session open. Close saves state. Standalone commit/add checkpoint work mid-session without closing. Context loads read-only. **Tool-agnostic**; works in any repo that has `.work.biz/context/HANDOFF.md`.

**Hard rules:**

- **Default close:** never `git commit` or `git push`. Only when the invocation includes `commit` and/or `push` (see I1).
- **`close commit` / `close commit push` / `commit` / `commit push`:** the agent **MUST** run `git add` + `git commit` in the shell (C6b / M5), staging the **full commit scope** (see I0 — repo-wide in the Business OS source repo, `.work.biz/` in a target project; incl. new untracked files/dirs). A dirty in-scope tree after close with only a draft message is **fail**.
- **Always** show the commit message — drafted, used for the commit, or `none — working tree clean`.
- **`commit` / `commit push` (standalone):** run git add + commit + push **without** updating HANDOFF, NEXT, or UNKNOWNS. The session stays open. Use for mid-session checkpoints.
- **`add` (standalone):** stage the commit scope and show the draft message, but do **not** commit.
- **Commit message format:** `BIZ-123: description` when a task ref is known, else `type: description` (per `.cursorrules`). Never commit with `type:` format when a ref is known or could reasonably be asked for.
- **No `Co-authored-by:` trailers** and no agent attribution — hooks strip/reject them.
- Every mode except `context` and `status` ends with a **completion checklist** — each item `pass` | `fail` | `skip` with evidence.
- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

---

## I0 — Files & scope

| File | Purpose |
|------|---------|
| `.work.biz/context/HANDOFF.md` | Current session context, what was done, what's next |
| `.work.biz/plans/NEXT.md` | Ordered list of next tasks / priorities |
| `.work.biz/plans/UNKNOWNS.md` | Open questions that need research or decisions |
| `.work.biz/reference/CONTENT_STATUS.md` | **Optional.** Canonical publish/status tracker across all content types. Read if present. |
| `.work.biz/active-ref` | **Optional.** One-line task ref (e.g. `BIZ-123`) written by `start`; read by the `prepare-commit-msg` hook. Removed on close. |

**Location:** Project root under `.work.biz/`. Defined per Business OS conventions.

### Scope rule (binding)

**Repo-role detection (mandatory before any git step):**

```bash
ROOT="$(git rev-parse --show-toplevel)"
if [ -f "$ROOT/skills/biz-session/skill.md" ]; then ROLE=source; else ROLE=target; fi
```

| Role | Detected when | Commit scope |
|------|---------------|--------------|
| **source** | the git root itself is the Business OS framework (`skills/biz-session/skill.md` exists at the root, next to `standards/`, `templates/`) | **All safe changes repo-wide** — every modified/added/deleted path incl. new untracked files/dirs |
| **target** | any consumer project (framework vendored under `.ai.biz/` or remote via `AI_BIZ_SOURCE`; legacy targets may still name the pointer `AGENT_OS_SOURCE`) | **`.work.biz/` only** |

**File writes** always land under `.work.biz/` in both roles (`HANDOFF.md`, `NEXT.md`, `UNKNOWNS.md`, `active-ref`, session artifacts) — that is where Business OS project memory lives, including in the source repo.

**Git scope — target role:**

- Staging is **path-scoped**: `git add -A -- .work.biz` (never bare `git add -A`).
- The commit is **path-scoped**: `git commit -m "<msg>" -- .work.biz` (never a bare `git commit` that could sweep in unrelated staged changes).
- Files outside `.work.biz/` are read-only for this skill. If a session produced app-code or framework changes that need committing, tell the user to commit them separately — do not stage them.

**Git scope — source role:**

- Staging covers the **whole repo**: `git add -A` from the git root picks up every modified, deleted, and new untracked file/dir — framework code, skills, standards, docs, and `.work.biz/` state alike.
- The only hard exclusions are the C1 secrets-scan matches (halt) and gitignored output trees (`tmp/`, `.tmp/`). Protected files (`.cursorrules` § Protected Files) that changed are listed in the report; commit them only when the operator's request covers them.
- The commit itself is a plain `git commit -m "<msg>"` — staging already defines the scope exactly.

**Push** is identical in both roles: `git push` the current branch, which necessarily carries the whole branch history; the session's own changes are scoped by the staging rules above.

---

## I1 — Parse invocation

Normalize the user message to a **verb** + optional **modifiers**. Arguments are order-independent and combinable.

Mode words: `start` | `close` | `commit` | `add` | `context` | `status`. Modifier words: `commit`, `push`, `scoped`.

| User says | Verb | Git action |
|-----------|------|------------|
| `@biz-session` **start** | start | — |
| `@biz-session` **start** - \<goal\> | start | — |
| `@biz-session` **close** | close | draft message only |
| `@biz-session` **close commit** | close | commit all **safe** changes in scope (role rule, I0; default scope, C6b) |
| `@biz-session` **close commit scoped** | close | commit only HANDOFF + NEXT + UNKNOWNS (+ paths named in the close report) |
| `@biz-session` **close commit push** | close | commit then push |
| `@biz-session` **close push** | close | treat as **commit push** (`push` requires `commit`) |
| `@biz-session` **commit** | commit | commit the role's scope (default, I0), **no close** |
| `@biz-session` **commit push** | commit | commit then push, **no close** |
| `@biz-session` **add** | add | stage the role's scope only, **no commit** |
| `@biz-session` **context** | context | — |
| `@biz-session` **status** | status | — |

**Aliases (same verb):** `begin`, `open` → start; `end`, `handoff` → close. `@session-control …` maps to `@biz-session …` for every verb above.

**Goal text:** anything after `-` or on a new line after `start` (not the words `commit` / `push` / `scoped`).

**Standalone `commit` / `commit push` / `add`:** the verb `commit` or `add` **without** `close` runs the git-only protocol (I4 / I5). The session remains open; HANDOFF, NEXT, and UNKNOWNS are **not** touched. (In this skill, `commit` as a *modifier of close* closes first; `commit` as the *verb* does not.)

**Commit scope:** resolved by repo role (I0). **Target project:** `.work.biz/` only — all safe changed + **new untracked files/dirs** under it; nothing outside is staged. **Source repo (this framework):** all safe changes **repo-wide** — framework code, skills, standards, docs, and `.work.biz/` state in one commit. Use **`commit scoped`** (target role) only when the user wants bookend files only.

**Rejections:** `commit` / `push` / `add` combined with `start`, `status`, or `context` are rejected with a redirect (`commit`/`add` are their own verbs; `push` pairs with `close` or `commit`). Duplicates (`close close commit`) are harmless — dedupe. Anything unrecognized is reported with a warning and ignored, never guessed.

---

## I2 — Start protocol

**Execution order:** S1 → S1b → S2 → S3 → S4 → S5 → S6 → S7.

### S1 — Baseline reads (mandatory, read in full or confirm missing)

| # | File | Pass criteria |
|---|------|----------------|
| 1 | `.cursorrules` | Can state: identity, core principles, protected files, no-commit rule |
| 2 | `.work.biz/context/HANDOFF.md` | Know: status line, session summaries, pending tasks, locked decisions |
| 3 | `.work.biz/plans/NEXT.md` | Know: recommended next action + active tasks + owner blockers |
| 4 | `.work.biz/plans/UNKNOWNS.md` | Know: every open unknown + owner + status |
| 5 | `.work.biz/reference/CONTENT_STATUS.md` **if present** | Know: ready/draft pieces, last publish, missing pillars |

**Content pipeline brief (when CONTENT_STATUS.md exists, 3–5 lines, no more):**

- `ready` pieces waiting to be posted (title + platform), oldest first
- `draft` pieces waiting on an owner pass
- Last publish date, and whether any published piece is still missing its pillar
- One suggested action when the pipeline is actionable (e.g. "post \<piece\> today", "owner pass on \<draft\>")

A tracker that is read but never acted on is indistinguishable from no tracker; the brief is what turns it into action.

**If HANDOFF.md doesn't exist:** prompt to run `@biz-bootstrap init` or create a minimal HANDOFF manually. Do not invent project history.

### S1b — Unblock check

If NEXT.md lists tasks with status `blocked`:

1. For each, find the blocker in UNKNOWNS.md or HANDOFF pending tasks.
2. If the condition has changed (unknown resolved, owner action done) → flip to `pending`, annotate `unblocked YYYY-MM-DD — <reason>`; mark the UNKNOWNS row `Resolved` with date.
3. If unchanged → leave `blocked`; surface in the start report under Open blockers.

### S2 — Conditional reads (goal-based)

Only when the goal names a domain:

| Goal touches | Read |
|--------------|------|
| Strategy / offer / pricing | `.work.biz/strategy/` one-pager + relevant artifact |
| Content / publishing | `.work.biz/reference/VOICE_PROFILE.md`, platform tracker under `.work.biz/pipeline/` |
| Sales / pipeline | `.work.biz/pipeline/pipeline_tracker.md` |
| Gated work (brand, pricing, content publish) | `.work.biz/gates.md` — confirm the prerequisite gate |

### S3 — Environment snapshot (evidence)

```bash
git status -sb
git log -1 --oneline
```

Record: branch, clean/dirty, last commit. A dirty tree at start → note in the report; ask if continuing WIP.

### S4 — Session goal

Capture from (in order): text after `start -`, else HANDOFF recommended pick-up, else ask **once**: "What is the primary goal for this session? (one line)". Store in the start report only.

### S5 — Task-ref resolution (no network)

Pick the session's task ref in this priority order:

1. **HANDOFF goal/status** containing `[A-Z]+-[0-9]+` (e.g. `BIZ-123`)
2. **Branch name** matching the same pattern
3. **`.github/task-registry.json`** if present (local file; match entries against goal/changed files)
4. **Last commit subject** starting with a ref
5. None found → continue without a ref; close/commit messages will use `type:` format

When a ref is chosen, write it to `.work.biz/active-ref` (`echo "BIZ-123" > .work.biz/active-ref`). The `prepare-commit-msg` hook reads this file, so every commit this session gets the ref prefix even on branches without one.

### S6 — Mark session open (HANDOFF)

Update only the header of `.work.biz/context/HANDOFF.md`:

```markdown
> **Date:** <today>
> **Status:** Open — <today> — goal: <goal or "not specified">
```

If HANDOFF already says Open and the same goal is restarted, refresh the date only. A prior `Closed` status means: treat as a new session; do not assume prior chat memory.

### S7 — Start report (mandatory output)

```markdown
## Session started — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Working tree:** clean | dirty

### Completion checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | .cursorrules read | pass/fail | |
| 2 | HANDOFF read | pass/fail | |
| 3 | NEXT read | pass/fail | |
| 4 | UNKNOWNS read | pass/fail | |
| 5 | CONTENT_STATUS read | pass/skip | pipeline brief emitted |
| 6 | Unblock check | pass/skip | N tasks unblocked |
| 7 | Git snapshot | pass | <one-liner> |
| 8 | Session goal captured | pass | <goal> |
| 9 | Task ref resolved | pass/skip | <ref or none> |
| 10 | HANDOFF marked Open | pass | |

### Content pipeline
<3–5 line brief, or "no CONTENT_STATUS.md">

### Pick up here
<quote recommended next from NEXT.md>

### Open blockers
<from HANDOFF / NEXT, or none>

**Needs your approval:** <numbered decisions, each citing `path:L<n>` — omit if none>
**Needs your answer:** <numbered questions — omit if none>
**Next step:** <the one immediate command> — when nothing is needed, close instead with the single Form A line `Next: nothing - work complete`.
```

`commit` / `push` / `add` are not valid with `start` — reject with a redirect to `close` or the standalone verb.

---

## I3 — Close protocol

**Execution order:** C1 → C2 → C3 → C4 (draft message) → C5 (HANDOFF) → C6 (NEXT/UNKNOWNS) → C6b (git, only if `commit`/`push`) → C7 (report).

If C1 secrets **fail**, **stop** — do not run C5, C6, or C6b; report the failure in C7.

### C1 — Working tree audit (mandatory)

```bash
git status
git diff --stat
git diff --cached --stat
```

Classify: uncommitted changes (summarize by area), untracked files (flag unexpected), staged-only (ready), clean tree (state explicitly).

**Secrets scan (mandatory):** confirm `git status` lists no path matching `credentials/`, `.env`, `.env.*` (except `.env.example`), `*.pem`, `*.p12`, `*.key`, `*.pfx`, `*.p8`, `*id_rsa*`, `*.token`, `*.secret`. On any match → checklist **fail**, **halt close** (no HANDOFF/NEXT/git); tell the user to unstage/remove and never commit the content.

### C2 — Verification gate (this session)

Per `.cursorrules` Completion Gate — answer honestly:

| Question | Answer |
|----------|--------|
| Framework or content changed this session? | yes / no |
| Change-safety gates run? (`touch-scope-verify.sh`, `blast-radius-check.sh`, `gate-verify.sh`, `framework-verify.sh` in the framework repo; project tests in a consumer repo) | yes / no / n/a |
| All passed? | yes / no / partial |
| What remains unverified? | list |

Do not claim "all good" when a gate failed. Run the gates now if framework files changed and they were not run yet.

### C3 — Follow-ups required

Detect and list: uncommitted work outside the commit scope (target role: outside `.work.biz/` — needs a separate owner commit; source role: nothing is outside scope), stale HANDOFF/NEXT vs reality, open owner actions, temp files to clean, protected files changed (flag for explicit owner review), stale `.work.biz/touch-scope` outside a scoped edit session.

### C4 — Commit message with task ref (always)

**Always** produce the commit message block in the close report — even when the tree is clean (`none — working tree clean`).

**Task-ref extraction (auto-detect), priority order:**

1. HANDOFF session goal containing `[A-Z]+-[0-9]+`
2. `.work.biz/active-ref` (written at start) — `head -1 .work.biz/active-ref`
3. `.github/task-registry.json` if present (local file, no network; match against goal/changed files)
4. Branch name matching the ref pattern
5. Last commit subject starting with a ref
6. No ref → use `type: description`. If the work clearly belongs to a task, ask the user **once** for the ref; otherwise proceed with `type:`.

**Subject format:**

- Ref found: `{REF}: {subject}` (e.g. `BIZ-123: add pillar loop to content tracker`)
- No ref: `{type}: {subject}` — valid types: `feat`, `fix`, `refactor`, `docs`, `chore`, `style`
- ≤72 chars including the prefix, imperative mood
- Body: optional; wrap ~72 chars; **why**, not a file list. Omit if the subject suffices.
- One message if changes are cohesive; suggest a **split** with multiple message blocks if not.
- Plain text only — no surrounding quotes, no `Co-authored-by:` trailers.
- Label in the report: **Commit message (draft)** vs **Commit message (used)**.

### C5 — Update HANDOFF (mandatory on close)

Rewrite the top sections (history moves to the sibling archive, it is never deleted — CONVENTIONS § Context budget):

1. Header: `**Status:** Closed — <date> — <one-line session outcome>`, `**Date:** <today>`
2. Prepend a session summary table for this session (what was done, one row per step)
3. Refresh **Pending for next session** and **Key decisions** (append new locked decisions)
4. Remove any stale "in progress" wording — a closed session must not say it is open
5. **Slim (Context budget):** when HANDOFF carries more than ~5 session blocks or has grown past what a session start should load, move the older session blocks (keep the newest few) into `.work.biz/context/HANDOFF.archive.md` — newest-first preserved, one pointer line left in HANDOFF. Create the archive file on first use. Never drop a block without it landing in the archive file.

**Cleanup:** remove `.work.biz/active-ref` if it exists (`rm -f .work.biz/active-ref`).

### C6 — Update NEXT + UNKNOWNS (mandatory on close)

- NEXT: move completed items to done with date; set **one** clear recommended next; refresh active tasks and owner blockers. Collapse long completed narration to one-liners with record pointers; bulk resolved material moves to `.work.biz/plans/NEXT.archive.md` (Context budget).
- UNKNOWNS: mark resolved rows with date; add new open questions. Resolved rows may move in bulk to `.work.biz/plans/UNKNOWNS.archive.md` with a pointer row left behind; open rows are never moved.

### C6b — Git actions (only when `commit`/`push` requested)

| Modifier | Action |
|----------|--------|
| *(none)* | Message only. The user runs git themselves from the draft. |
| `commit` | Only if C1 secrets **pass**. After C5/C6: stage the **default scope** → commit (HEREDOC, path-scoped) → verify tree → record SHA. |
| `commit scoped` | After C5/C6: stage only HANDOFF + NEXT + UNKNOWNS (+ paths explicitly tied to this session in the close report). |
| `commit push` / `push` | After a successful commit: `git push` the current branch. Never `--force` unless the user explicitly requests it in the same message. |

**Hard rule — agents MUST execute git:** typing `@biz-session close commit` does not commit by itself. Checklist item 6 is **fail** if the tree still has unstaged safe in-scope changes and no new SHA was produced.

**Default commit scope** (`commit` / `commit push`, not `scoped`) — resolve the repo role first (I0):

**Target role** (consumer project):

1. From C1's `git status --porcelain`, the stage list is every path under `.work.biz/` with status `M`, `A`, `D`, `R`, `C`, or `??` (untracked — includes **new untracked files/dirs**) **except** secrets-scan matches and `tmp/` output (never add unless the user explicitly named them).
2. Stage and commit from the **target repo root**:

```bash
git add -A -- .work.biz                     # ALL .work.biz changes: modified, new, deleted, untracked files AND dirs
git commit -m "$(cat <<'EOF'
<exact message from C4>
EOF
)" -- .work.biz                              # path-scoped: unrelated staged changes stay out
git status -sb
git log -1 --oneline
```

3. Do **not** stage anything outside `.work.biz/` — list such paths in the report as follow-ups for a separate owner commit.
4. Do **not** default to HANDOFF + NEXT only — that is `commit scoped`, not default `commit`.
5. If the only remaining dirty paths are excluded (secrets) or outside `.work.biz/`, commit what was staged and report the exclusions.

**Source role** (Business OS framework repo itself):

1. The stage list is **every** path from C1's `git status --porcelain` — modified, deleted, and new untracked files/dirs across the whole repo (`skills/`, `standards/`, `scripts/`, docs, `.work.biz/`, etc.) — **except** secrets-scan matches (C1 already halts on those).
2. Stage and commit from the git root:

```bash
git add -A                                   # whole repo: modified + deleted + new untracked files/dirs
git commit -m "$(cat <<'EOF'
<exact message from C4>
EOF
)"
git status -sb
git log -1 --oneline
```

3. Protected files (`.cursorrules` § Protected Files) in the changeset are listed in the report; if the operator's request did not cover them, unstage them (`git restore --staged <path>`) before committing.
4. `commit scoped` keeps its meaning in both roles: HANDOFF + NEXT + UNKNOWNS only.

**Post-commit verification (mandatory):** new SHA in `git log -1`; no remaining safe `M`/`D`/`??` paths in scope (target: under `.work.biz/`; source: repo-wide) — or the report lists each leftover and why (secrets, protected, intentional WIP).

**Clean tree + `commit` modifier:** skip the commit (never create empty commits); report `Commit message (used): none — working tree clean`.

**On commit failure:** report hook output verbatim; do not claim the git step passed. HANDOFF/NEXT updates stand if already written.

### C7 — Close report (mandatory output)

```markdown
## Session closed — <Project Name>

**Date:** <ISO date> · **Branch:** <branch>

### Completion checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Git audit | pass/fail | clean / N files changed |
| 2 | Secrets safe | pass/fail | |
| 3 | Verification honest | pass/fail | gates run, results |
| 4 | Follow-ups listed | pass | |
| 5 | Commit message shown | pass | always |
| 6 | Git commit (if requested) | pass/fail/skip | SHA + git status evidence |
| 6b | Commit scope staged per repo role (default commit) | pass/fail/skip | role; leftover safe paths listed |
| 7 | Git push (if requested) | pass/fail/skip | remote/branch result |
| 8 | HANDOFF updated | pass/fail | |
| 9 | NEXT + UNKNOWNS updated | pass/fail | |

### Commit message
**Status:** draft | used
**Task ref:** <ref or none>
**Message:**

    BIZ-123: subject line here

    Optional body — why, not what.

**Git:** no commit (default) | committed <sha> | push <remote/branch> result

### Follow-ups before next session
<ordered list>

### Next session should
<one line from NEXT.md>

**Needs your approval:** <numbered decisions, each citing `path:L<n>` — omit if none>
**Needs your answer:** <numbered questions — omit if none>
**Next step:** <the one immediate command> — when nothing is needed, close instead with the single Form A line `Next: nothing - work complete`.
```

---

## I4 — Commit protocol (standalone)

`@biz-session commit` / `@biz-session commit push` — git checkpoint **without** closing the session. No HANDOFF/NEXT/UNKNOWNS writes. Idempotent, re-runnable mid-session.

**Execution order:** M1 → M2 → M3 → M4 → M5 (git) → M6 (report). If M1 secrets **fail**, stop — do not run M4 or M5.

- **M1 — Working tree audit:** same as C1 (incl. secrets scan).
- **M2 — Verification gate:** same as C2.
- **M3 — Follow-ups:** same as C3.
- **M4 — Commit message with task ref (always):** same extraction and format as C4. Always shown, even on a clean tree.
- **M5 — Git actions:** same as C6b (default scope, HEREDOC, path-scoped commit, post-commit verification, push if requested). Agents MUST run shell git; no `Co-authored-by:` trailers. Clean tree → `none — working tree clean`, no empty commit.
- **M6 — Commit report (mandatory output):**

```markdown
## Commit completed — <Project Name>

**Date:** <ISO date> · **Branch:** <branch>

### Checklist
| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Git audit | pass/fail | clean / N files changed |
| 2 | Secrets safe | pass/fail | |
| 3 | Verification honest | pass/fail | |
| 4 | Follow-ups listed | pass | |
| 5 | Commit message shown | pass | always |
| 6 | Task ref extracted | pass/skip | ref or none |
| 7 | Git commit | pass/fail | SHA + git status evidence |
| 8 | Commit scope staged per repo role | pass/fail | role; leftover safe paths listed |
| 9 | Git push (if requested) | pass/fail/skip | remote/branch result |

### Commit message
**Status:** used
**Message:**

    BIZ-123: subject line here

**Git:** committed <sha> | push <remote/branch> result

**Session:** still open — no HANDOFF, NEXT, or UNKNOWNS changes.

**Needs your approval:** <numbered decisions, each citing `path:L<n>` — omit if none>
**Needs your answer:** <numbered questions — omit if none>
**Next step:** <the one immediate command> — when nothing is needed, close instead with the single Form A line `Next: nothing - work complete`.
```

---

## I5 — Add protocol (stage only)

`@biz-session add` — stage the commit scope without committing. Use to inspect exactly what a session commit would carry, or to pre-stage before an owner-driven commit.

1. Run the C1 audit (incl. secrets scan; halt on match) and resolve the repo role (I0).
2. Stage from the repo root: **target role** → `git add -A -- .work.biz`; **source role** → `git add -A` (whole repo).
3. Report: the resolved role, staged paths (grouped by area), exclusions (secrets/tmp/protected), and the **draft commit message** per C4.
4. State explicitly: staged but **not committed**; the session remains open; `git status -sb` evidence.

Never stage outside the role's scope (target: `.work.biz/` only; source: repo-wide). Never commit from `add` — that is what `commit` is for.

---

## I6 — Status protocol

`@biz-session status` — read-only snapshot. No writes, no checklist.

1. Read HANDOFF.md and NEXT.md (+ UNKNOWNS.md for the count).
2. Run `git status -sb` and `git log -1 --oneline`.
3. Output:

```markdown
## Session status — <Project>

**Session:** Open | Closed — <date> — <goal if Open>
**Branch:** <branch> · **Tree:** clean | dirty
**Next items:** <N> — first 3: <…>
**Unanswered:** <M open unknowns>
**Pick up:** <one line from NEXT.md>

**Needs your approval:** <numbered decisions, each citing `path:L<n>` — omit if none>
**Needs your answer:** <numbered questions — omit if none>
**Next step:** <the one immediate command> — when nothing is needed, close instead with the single Form A line `Next: nothing - work complete`.
```

Optional: one line on dirty files (no full diff). For a full context load, use **start**; for full load without writes, use **context**.

---

## I7 — Context protocol (read-only, uncommitted-aware)

`@biz-session context` — read-only full context load. **No** HANDOFF/NEXT/UNKNOWNS/active-ref writes, no completion checklist. Sits between `status` (compact) and `start` (full load + marks Open).

### X1 — Mandatory context reads (read in full)

Same set as S1 (files 1–5). Conditional reads per S2 only when the operator named a domain.

### X2 — Uncommitted-aware snapshot

```bash
git status -sb
git diff --stat
git diff --cached --stat
git log -1 --oneline
git status -sb -- .work.biz        # scoped view: what the session owns
```

Classify the working tree:

- **clean:** state explicitly; report last commit only.
- **dirty:** summarize by top-level area (e.g. `3 files .ai.biz/skills/`, `1 file .work.biz/plans/`); list staged vs unstaged vs untracked counts. Do not paste full diffs — file paths + per-area counts only. Flag any path matching the C1 secrets patterns **without printing content**.
- **Target role:** always separate the `.work.biz/` scoped status from the rest of the tree, since `.work.biz/` is what `close commit` would carry. **Source role:** the whole tree is the scope — per-area counts suffice.

### X3 — Context report (mandatory output)

```markdown
## Session context — <Project Name>

**Date:** <ISO date> · **Branch:** <branch> · **Working tree:** clean | dirty (N files)
**Last commit:** <sha — subject>

### Context loaded
| # | File | Result | Note |
|---|------|--------|------|
| 1 | .cursorrules | pass | |
| 2 | .work.biz/context/HANDOFF.md | pass (or missing) | Status: Open|Closed … |
| 3 | .work.biz/plans/NEXT.md | pass (or missing) | |
| 4 | .work.biz/plans/UNKNOWNS.md | pass (or missing) | |
| 5 | .work.biz/reference/CONTENT_STATUS.md | pass (or missing) | |

### Uncommitted status (read-only)
- Staged: <N files> · Unstaged: <N files> · Untracked: <N files>
- Areas touched: <top-level dirs with counts>
- Commit scope (per repo role): <what a session commit would carry — `.work.biz/` status in a target, whole-tree summary in the source repo>
- Secrets scan: clean | <flagged paths (not printed)>
- (Clean tree → omit this section; state "working tree clean".)

### Pick up here
<quote recommended next from NEXT.md, or "no NEXT.md">

### Open blockers
<from HANDOFF / NEXT, or none>

### No files written
This mode is read-only: HANDOFF, NEXT, UNKNOWNS, and active-ref are **not** modified.
To open a session, run `@biz-session start`.

**Needs your approval:** <numbered decisions, each citing `path:L<n>` — omit if none>
**Needs your answer:** <numbered questions — omit if none>
**Next step:** <the one immediate command> — when nothing is needed, close instead with the single Form A line `Next: nothing - work complete`.
```

### Anti-patterns (context)

- Treating `context` as `start` (writing the HANDOFF Open line) — `context` writes nothing.
- Pasting raw `git diff` output (use per-area counts).
- Skipping the secrets-flag pass on a dirty tree.
- Claiming "context loaded" without reading all of X1.
- Recommending a publish without checking CONTENT_STATUS.md when it exists.

---

## Mode comparison

| | start | status | context | close | close commit | close commit push | commit | commit push | add |
|---|-------|--------|---------|-------|--------------|-------------------|--------|-------------|-----|
| Read HANDOFF/NEXT | yes | yes | yes | yes | yes | yes | no | no | no |
| Update HANDOFF | Open | no | no | Closed | Closed | Closed | no | no | no |
| Update NEXT/UNKNOWNS | no | no | no | yes | yes | yes | no | no | no |
| `git add` (scope) | no | no | no | no | yes | yes | yes | yes | **yes (only)** |
| `git commit` | no | no | no | no | yes | yes | yes | yes | no |
| `git push` | no | no | no | no | no | yes | no | yes | no |
| Commit message in output | no | no | no | **always** | **always** | **always** | **always** | **always** | **always (draft)** |
| Completion checklist | yes | no | no | yes | yes | yes | yes | yes | no |

---

## Edge cases

| Situation | Behavior |
|-----------|----------|
| Merge conflict markers in tree | close checklist **fail**; list files |
| Only framework / app dirs changed | Target role: outside `.work.biz/` scope — session commit stages nothing; list as follow-up for a separate owner commit. Source role: these ARE the scope — committed by default |
| Secrets-pattern path in `git status` | **fail** secrets check; halt; never print content |
| User closes mid-task | HANDOFF notes "in-flight: …" in the status line |
| Multiple logical changes | close report suggests 2+ message blocks (split) |
| HANDOFF already Open, new `start -` goal | Set the Open line to the new goal + today; note the prior goal in the start report |
| Clean tree + `commit`/`push` | Skip commit (no empty commits); `none — working tree clean`; still push if `push` was requested and the branch is ahead |
| `push` fails (divergent remote, no upstream) | Report the exact error; never `--force`; let the user decide |
| Operator has unrelated staged changes | Target role: changes outside `.work.biz/` stay staged and untouched; report them. Source role: everything staged by the session commit is in scope by definition |

---

## Anti-patterns

- Claiming "context loaded" without reading HANDOFF and NEXT.
- Closing a session without updating HANDOFF and NEXT/UNKNOWNS (on **close**).
- Committing on plain `close` (without the `commit` modifier).
- **`close commit` / `commit` without running `git commit`** or without a new SHA.
- Bare `git add -A` or bare `git commit` **in a target project** — always path-scope with `-- .work.biz`. (In the source repo, repo-wide `git add -A` is the defined scope, not a violation.)
- Staging app-code, framework files, `.cursorrules`, or any non-`.work.biz` path "to be helpful" **in a target project**.
- `close commit` with only HANDOFF/NEXT staged while other safe `.work.biz/` paths remain dirty (that is `commit scoped` behavior without the `scoped` modifier).
- Omitting the commit message block from close/commit/add reports.
- Running HANDOFF/NEXT updates on standalone `commit` / `commit push` / `add` — the session stays open.
- Using `git commit --amend`, `git reset`, or `git push --force` to "fix" the session commit — destructive; stop and tell the user.
- Guessing when `push` fails — report the exact error and let the user decide.
- Ignoring an unrecognized parameter silently — report it with a warning.
- Adding `Co-authored-by:` trailers or agent attribution.
- Putting secrets or real client data in HANDOFF.

---

## Completion

| # | Check | Result |
|---|-------|--------|
| 1 | HANDOFF.md exists and is current (under `.work.biz/`) | |
| 2 | NEXT.md has ordered priorities | |
| 3 | UNKNOWNS.md tracks open questions | |
| 4 | CONTENT_STATUS.md loaded if present (+ pipeline brief on start) | |
| 5 | Session start acknowledged + HANDOFF marked Open | |
| 6 | Session close wrote state (to `.work.biz/`, in both roles) | |
| 7 | If `commit`/`push` requested: repo role resolved; scope staged (target: `-A -- .work.biz` incl. untracked; source: repo-wide `-A`) + commit (and push) verified with SHA | |
| 8 | If standalone `commit`/`add`: no HANDOFF/NEXT writes; session still open | |

**Next:** whatever NEXT.md says first.
