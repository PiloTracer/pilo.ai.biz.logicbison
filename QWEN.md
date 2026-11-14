# QWEN.md - Business OS source repo

Adapter for Qwen Code only. **`.cursorrules` (repo root) is the binding rulebook** and outranks this file and your defaults; read it at session start. This file translates that rulebook for Qwen Code. It deliberately restates almost nothing: a second copy of a rule is a drift risk, so when this file and `.cursorrules` disagree, `.cursorrules` wins and this file is the bug.

## What this repo is

The git root **is** the Business OS framework tree (self-hosted source), not a consumer project.

- No `.ai.biz/` prefix here. Docs that show `.ai.biz/skills/...` mean `skills/...` in this repo. In consumer projects the prefix is real.
- Repo role is **source**. `skills/biz-session/skill.md` tests this: role is `source` when that file sits at the git root, `target` otherwise. Role decides commit scope (below).
- Nothing to build, install, or run. The framework is Markdown plus bash: no `package.json`, no containers, no dev server, no `bin/`, no `apps/`, no `.work/`. Do not import verify commands from a consumer project's adapter.
- 26 skills under `skills/`, every id `biz-` prefixed. `session-control` is an alias of `biz-session`.

## `@biz-<skill> <args>` = framework skill, not a Qwen Code skill

Invocations like `@biz-session start`, `@biz-strategy design`, `@biz-director - <text>` are markdown-defined framework skills.

- They are **not** in your `skill` tool's list. Never call `skill: "biz-session"`; no such skill is registered. Read the doc and follow it.
- Resolve `skills/<name without @>/skill.md` **in this repo**. Read a sibling `reference.md` or `platforms/*.md` in the same folder when `skill.md` links it.
- Everything after the skill name is the invocation: a verb plus modifiers (`start`, `close`, `close commit push`, `design`, `certify`, `status`) or `- <free text>` for the directors. Parse it with that skill's own **Parse invocation** table; never infer git behaviour from the verb alone.
- Any `.ai.biz/<path>` inside those docs resolves to `<this repo>/<path>`. `.work.biz/**` is always the local project's own memory.

| Prefix | Source root |
|--------|-------------|
| `@biz-*` (including `@biz-session`) | **this repo** |
| `@session-control` | **this repo** - it is an alias of `biz-session` (`skills/biz-session/skill.md:L108`). Do **not** route it to Agent OS from here. Agent OS owns a *different* skill of the same name, so in a cohabitation repo the bare alias is ambiguous and `@biz-session <verb>` is the form to use. |
| none: `@code-implementation`, `@code-verify`, `@plan-*`, `@feature-spec`, `@db-migration`, `@docs`, `@ai-director`, `@x-director` | `/mnt/work/Projects/pilo.ai.logicbison` |
| `@ui-*` | `/mnt/work/Projects/pilo.ai.ui.logicbison` |
| `@cto-*` / `@mlt-*` / `@soc-*` / `@flutter-*` | `/mnt/work/Projects/pilo.ai.<fw>.logicbison` |

**Session bookends are the entry point for context.** `@biz-session start` loads the session and marks `HANDOFF.md` open; `@biz-session context` is the same load, read-only and uncommitted-aware, and writes nothing. The verb is `context` on its own - there is no `context load` form. Both read exactly the tier 1 set in `START_HERE.md` § 7; do not hand-read the tier 2 files (`README.md`, `skills/README.md`, `CONVENTIONS.md`) at session start, and never load a `skill.md` you are not invoking.

Sister roots resolve through `scripts/sister-discovery.sh` and the Frameworks registry in `.cursorrules`; prefer those over hardcoding. If a source root is missing or unreadable, stop and report `<framework> source unreachable: <path>`. No fallback, no guessing.

Lost: `START_HERE.md` (decision tree), `PROCESS_ROUTER.md` (skill routing), `.quick/` (cheat sheets), or invoke `@biz-director - <what you want>`. Cross-framework work: `@x-director - <what you want>`.

## State and artifacts (`.work.biz/`, always local)

| Need | Path |
|------|------|
| Session handoff | `.work.biz/context/HANDOFF.md` (older blocks: `HANDOFF.archive.md`) |
| Backlog / next action | `.work.biz/plans/NEXT.md` |
| Open questions | `.work.biz/plans/UNKNOWNS.md` |
| Readiness ledger (authoritative gate state) | `.work.biz/gates.md` |
| Decision ledger + calibration | `.work.biz/decisions/DECISIONS.md` |
| Active task ref for commits | `.work.biz/active-ref` |
| Declared change scope | `.work.biz/touch-scope` |
| Strategy artifacts (canonical) | `.work.biz/strategy/` |
| Publish/status tracker | `.work.biz/reference/CONTENT_STATUS.md` |
| Voice definition / voice measurement | `.work.biz/reference/VOICE_PROFILE.md` / `VOICE_RETRO.md` |

Binding conventions: `CONVENTIONS.md`. Canonical layout: `standards/20260621-DIRECTORY_MAP.md`. Binding standards: `standards/`. Session files stay lean per `CONVENTIONS.md` § Context budget (move history to a sibling archive, never delete).

## Verify: plain bash on the host

```bash
bash scripts/framework-verify.sh      # framework self-check; expect exit 0, 0 FAIL lines
bash scripts/gate-verify.sh           # gate PASS claims must have evidence on disk
bash scripts/touch-scope-verify.sh    # changed files must sit inside .work.biz/touch-scope
bash scripts/blast-radius-check.sh    # measures the NEXT commit: staged content wins when anything is staged
```

Declare scope **before** editing: copy `templates/work/touch-scope.template` to `.work.biz/touch-scope` and list the paths you will touch. A stale scope from a closed session is a finding, not a pass.

CI: `.github/workflows/framework-verify.yml`. Hooks: `bash scripts/install-git-hooks.sh` installs `pre-commit`, `commit-msg`, `prepare-commit-msg`, `post-commit`. The `pre-commit` change-safety gates are **warn-only** by default; `GATES_ENFORCE=1 git commit ...` restores blocking. Deploy paths have their own checks: `scripts/biz-deploy-basic.sh <target>`, `scripts/biz-cursorrules-verify.sh <target>`, `scripts/biz-cursorrules-merge.sh <target> --state`.

A green `framework-verify` proves wiring and text presence. It does **not** prove a skill works on a real project; say which of the two you verified.

## Non-negotiables (full text in `.cursorrules`)

- **Same-message approval only, never standing:** `git commit` / `git push`; deleting files or directories; `DROP` / `TRUNCATE` / datastore wipes; history rewrites and `--no-verify`; bulk-wiping `.work.biz/`; replacing an existing `.cursorrules` wholesale; and edits to Protected Files (`package.json`, `docker-compose*.yml`, `Dockerfile.*`, `.env*` except `.env.example`, `skills/SKILL_DEPENDENCIES.md`, `standards/`, `hooks/`). Plain `@biz-session close` on a dirty tree is a valid pass: hand over the draft message and the `git add` scope, the operator commits.
- **Commit scope follows repo role.** Source role (this repo): all safe changes repo-wide, `git add -A`. Target role: `git add -A -- .work.biz` and a path-scoped `git commit ... -- .work.biz`; nothing outside is staged. `close commit scoped` means HANDOFF + NEXT + UNKNOWNS only, in either role.
- **Commit messages:** `BIZ-123: subject` when a task ref is known (`.work.biz/active-ref`, branch, HANDOFF goal, last commit subject), else `type: description` with `type` in `feat` `fix` `refactor` `docs` `chore` `style`. Imperative, 72 chars or less, body explains **why**. No "Generated by", no agent signature, no dates-as-signature, no `Co-authored-by:` trailer (hooks strip and reject it).
- **Evidence over memory:** report actual command output. Never claim fixed, passing, verified, or implemented without it. State what you checked and what is still unverified, and grade load-bearing claims `A`-`D` per `CONVENTIONS.md` § Evidence grades.
- **Truth over agreement:** `.cursorrules` Core Principles 1-7 are non-negotiable. Push back on a flawed premise immediately; never report "solid strategy" when the arithmetic or the evidence says otherwise.
- **Consequential decisions get a ledger row** at decision time, with a falsifiable expected outcome (number and date, or observable event), confidence, reversibility, kill trigger, and review date. Advice that was never recorded can never be scored.
- **Content voice:** zero em-dashes and en-dashes in generated content; use periods, commas, colons, or parentheses.
- **Output economy:** chat prose 150 words or fewer (code, diffs, command output, and the handoff sections excluded); ask before exceeding it or widening scope. Close every operator-facing turn per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md`: Form A single line when nothing is needed, otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`.
