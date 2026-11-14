# Plan: Business OS framework improvement, round 1 (2026-11-14)

**What:** Measured defects in this framework repo, found during a read-only audit, with the fix and evidence for each.
**Status:** In progress (2026-11-14) - items 1-6 approved by the operator in the same message and applied this session; items 7-11 are proposals only.
**Needs:** Operator decision on items 7-11 (numbered under Decisions below). Nothing is needed for items 1-6.

Scope was set by the operator to **measured defects only**: every item below was reproduced with a command in this repo today. Structural findings (context-budget redesign of the large skills, and the validation-debt argument) are named under Open questions, not planned here.

Classification per `.cursorrules` Core Principle 6: `confirmed` = reproduced by command output today; `inference` = follows from confirmed facts but was not directly measured; `unknown` = needs a live run to settle.

---

## Applied this session (approved)

### 1. Root `QWEN.md` was another project's adapter - `confirmed`, FIXED

`QWEN.md` at the repo root was byte-identical to `/mnt/work/Projects/system-news/QWEN.md` (md5 `beaf5cbc`, 4,988 bytes, untracked here, tracked there). It is titled "QWEN.md - System News" and instructed every Qwen Code session in this repo to verify inside docker containers via `./bin/start.sh --env dev test` and to read state from `.work/context/HANDOFF.md`.

Measured: `bin`, `apps`, `.work`, `docker-compose.dev.yml` all **absent** from this repo. This framework has no build, no containers, and no `.work/`. The file was the reason this session opened with a false model of the tree.

**Fix applied:** deleted with same-message approval (the identical file remains tracked in `system-news`, so nothing was lost) and replaced with a 75-line adapter for the self-hosted Business OS source: repo role and the absent `.ai.biz/` prefix, `@biz-*` as markdown framework skills rather than `skill`-tool entries, the `.work.biz/` state map, the four host bash gates, and the `.cursorrules` non-negotiables **by pointer, not by copy**, so the adapter cannot drift from the rulebook it summarises.

Committed `8bccabf`. All 23 paths the new file asserts were checked to exist. Zero em/en dashes per Key decision 5.

### 2. `HANDOFF.md` over its own context budget - `confirmed`, FIXED

The live file carried **7** session blocks (`## Session summary` at former L10, 36, 51, 68, 79, 95, 109). `CONVENTIONS.md` § Context budget: "when HANDOFF carries more than ~5 session blocks ... move the older session blocks ... into `.work.biz/context/HANDOFF.archive.md`". Over budget by 2, and 33,050 bytes made it the second-largest item in the mandated session-start load.

**Fix applied:** moved the 4 oldest blocks (2026-09-10, 2026-08-21, 2026-08-19 homogenization + v0.6.1, 2026-08-19 consistency audit) into `HANDOFF.archive.md`, newest-first, pointer line updated. Move-not-delete per the rule; nothing dropped.

### 3. `.work.biz/` missing 10 of 16 manifest files - `confirmed`, FIXED

The canonical manifest is `scripts/biz-deploy-basic.sh:L153-161` (16 files) and `:L163-166` (10 dirs). This repo had 6 files: `README.md`, `context/HANDOFF.md`, `plans/NEXT.md`, `plans/UNKNOWNS.md`, `pipeline/pipeline_tracker.md`, `research/research_index.md`.

Absent: `gates.md`, `decisions/DECISIONS.md`, `pipeline/outreach-cadence.md`, `strategy/README.md`, `reference/CONTENT_STATUS.md`, `reference/BRAND_STATUS.md`, `reference/VOICE_PROFILE.md`, `reference/VOICE_RETRO.md`, `reference/OPERATOR_PROFILE.md`, `reference/PROJECTS.md`. Directories `drafts/`, `strategy/`, `reference/`, `ideas/`, `ideas.archive/`, `decisions/` absent.

Consequences, all measured: `gate-verify.sh` returns `skip: no .work.biz/gates.md` on every run, so the gate machinery has never executed here; `START_HERE.md` § 7 reading order steps 3 and 9 point at files that do not exist; the decision loop (`CONVENTIONS.md` § Decision loop) has no ledger to write to in the one repo that is always open.

**Fix applied:** `bash templates/bootstrap.sh`. Chosen over `scripts/biz-deploy-basic.sh .` deliberately: bootstrap uses `copy_if_missing` for all 16 files and explicitly skips an existing `.cursorrules` (`templates/bootstrap.sh:L86-87`), whereas `biz-deploy-basic` would try to merge a managed Business OS block into this repo's own framework `.cursorrules`, which is wrong in the source role.

### 4. `README.md` version badge two releases stale - `confirmed`, FIXED

`README.md:L4` read `Version-v0.6.0`; `CHANGELOG.md:L5` is `## [v0.7.0] - 2026-10-25`. Two releases behind (v0.6.1, v0.6.2, v0.6.3, v0.7.0 all shipped after).

`scripts/framework-verify.sh` checks README's **skill count** against the folder count and fails on mismatch, but has no equivalent check for the version badge against `CHANGELOG.md`. That is why four releases passed CI with a stale badge.

**Fix applied:** badge set to v0.7.0. Verifier change proposed as item 8, not applied.

### 5. Stray file `1` at repo root - `confirmed`, FIXED

Untracked file named `1`, 21 bytes, content `$: command not found`. A shell redirect accident (`... 2>&1 1` or similar) from an earlier session. Deleted with same-message approval.

### 6. `NEXT.md` fleet count stale - `confirmed`, FIXED

`NEXT.md:L18` states "Fleet re-wiring - 1 of 15 done (mendarion), 14 remaining" and lists 14 repos. `system-news` is in neither list, yet it **is** wired: `system-news/.cursorrules` carries a paired `BIZ_DESIGN_OS_BEGIN`/`END` block, `AI_BIZ_SOURCE=/mnt/work/Projects/pilo.ai.biz.logicbison` at `system-news/.cursorrules:486`, a fully scaffolded `.work.biz/`, and `scripts/biz-cursorrules-merge.sh /mnt/work/Projects/system-news --state` reports `present`.

The 2026-11-05 session that did it was never closed, so the count never moved. **Fix applied:** `NEXT.md:L18` corrected to 2 wired and the unclosed session recorded in `HANDOFF.md`.

---

## Verification after applying items 1-6

All measured after the fixes, same session:

| Check | Before | After |
|-------|--------|-------|
| `README.md` badge vs `CHANGELOG.md:L5` | `v0.6.0` vs `v0.7.0` | `v0.7.0` vs `v0.7.0`, congruent |
| `HANDOFF.md` live session blocks | 7 | 3 (archive 7 to 11; 14 unique blocks total, none lost, none duplicated) |
| `HANDOFF.md` size | 33,050 B / 219 lines | 26,952 B / 163 lines |
| `.work.biz/` manifest files | 6/16 | **16/16** |
| `.work.biz/` manifest dirs | 4/10 | **10/10** |
| `gate-verify.sh` | `skip: no .work.biz/gates.md` | **`PASS`** (ledger now read) |
| `touch-scope-verify.sh` | PASS | PASS (5 changed files in scope) |
| `blast-radius-check.sh` | PASS | PASS, `files=5 areas=2 risk=med` |
| `framework-verify.sh` | exit 0, 66 OK, 0 FAIL | exit 0, **66 OK, 0 FAIL** (unchanged, as expected: no framework file was touched) |
| Root `QWEN.md` | stray copy of `system-news` | committed `8bccabf`, 23/23 asserted paths exist, 0 em/en dashes |
| Stray file `1` | present, 21 B | removed |

`framework-verify` staying at 66 is itself a finding: none of the six defects it should have caught is covered by any of its 66 checks. See item 8.

---

## Proposed, not applied

### 7. `agent.os.framework.md` is wrong about this repo - `confirmed`

The file declares: "This file marks the repository root as the **Agent OS framework source repo** (self-hosted `.ai`)" and "**Never modify:** this file is a protected surface (`.cursorrules` § Protected Files, `standards/`)".

All three claims fail here, each measured:

1. This is the **Business OS** source repo. The Agent OS source is `/mnt/work/Projects/pilo.ai.logicbison`, which has its own `agent.os.framework.md`.
2. The detection rule it states ("a repo is framework source iff this file exists at the repo root") is not what this framework uses. `skills/biz-session/skill.md` § I0 detects source role with `[ -f "$ROOT/skills/biz-session/skill.md" ]`. Nothing in `scripts/` or `skills/` reads `agent.os.framework.md`.
3. `.cursorrules` § Protected Files lists `package.json`, `docker-compose*.yml`, `Dockerfile.*`, `.env*`, `skills/SKILL_DEPENDENCIES.md`, `standards/`, `hooks/`. `agent.os.framework.md` is **not** in it, and not in `standards/`.

The only file in the repo that mentions it is `.work.biz/prompts/20260814-marker-detection-deploy-repo-removal-audit.md` - the audit that removed marker-based detection. This file is that removal's leftover.

**Proposed fix:** delete it. Needs same-message approval (a delete, and the file asserts it is protected, so the assertion should be answered explicitly rather than silently overridden). Fallback if the operator wants a marker kept: rename to `biz.os.framework.md`, correct the identity line, and either add it to `.cursorrules` § Protected Files or drop the protected claim.

### 8. `framework-verify.sh` cannot see the two drifts that actually shipped - `confirmed`

66 checks, 0 FAIL, exit 0 (run twice today). The suite is real and it catches wiring loss. But it is a **text-presence** verifier: 104 `grep -q` / `-f` / `-d` assertions. It confirms a string exists, not that a claim is true. Two consequences measured today:

- The v0.6.0 badge (item 4) survived four releases because no check compares `README.md` to `CHANGELOG.md`.
- `touch-scope-verify.sh` reported "all 2 changed files within scope" and `blast-radius-check.sh` reported `files=2 areas=1` while **3** files had changed. Both measure `git diff` against HEAD, which excludes untracked files. A brand-new file is invisible to both gates until it is staged. `blast-radius-check.sh` does become staged-aware once anything is staged (it reported `files=1` correctly at commit time), so the blind spot is specifically *untracked, unstaged* additions.

  Re-measured after item 3, at larger scale and therefore more dangerous: `git status --porcelain` listed **11** paths (5 modified, 6 untracked, including the whole new `.work.biz/reference/`, `.work.biz/decisions/`, `.work.biz/strategy/` trees). `blast-radius-check.sh` reported `files=5 areas=2 risk=med` and `touch-scope-verify.sh` reported "all 5 changed files within scope". **Six new files, three of them entire directories, passed both gates unseen.** The risk rating was computed from less than half the change. In a session that adds a new skill folder, the gate would rate the blast radius of the skill's *absence*.

**Proposed fix:** (a) add a version-congruence check to `framework-verify.sh` - top `CHANGELOG.md` heading must equal the `README.md` badge; (b) make `touch-scope-verify.sh` and `blast-radius-check.sh` include `git ls-files --others --exclude-standard` alongside the diff. `scripts/` is not a protected path, but both are change-safety gates, so this needs operator sign-off before editing.

### 9. Session-start context load is ~44k tokens before any work - `confirmed`

Measured for the `START_HERE.md` § 7 reading order with `skills/biz-strategy/skill.md` as the invoked skill:

| File | Bytes |
|------|-------|
| `.cursorrules` | 22,321 |
| `README.md` | 15,256 |
| `.work.biz/context/HANDOFF.md` | 33,050 |
| `.work.biz/plans/NEXT.md` | 12,336 |
| `skills/README.md` | 9,659 |
| `skills/biz-strategy/skill.md` | 61,317 |
| `CONVENTIONS.md` | 23,049 |
| `.work.biz/gates.md`, `.work.biz/decisions/DECISIONS.md` | absent at measurement time (item 3) |
| **Total** | **176,988 (~44,247 tokens at 4 bytes/token, `estimated`)** |

`@biz-strategy design` also requires `concepts/strategy-design/prompt.md` (29,288 bytes), taking the worst case to ~206 KB / ~51k tokens (`estimated`). Two of the nine mandated files did not exist, so a correctly bootstrapped consumer loads **more** than this, not less.

Largest skills by line count: `biz-social` 951, `biz-strategy` 803, `biz-session` 643, `biz-writing` 519, `biz-brand` 511.

**Proposed fix:** out of scope for this round by operator decision. Recorded under Open questions.

### 10. Undocumented directories in `.work.biz/` - `confirmed`

`.work.biz/reports/` (4 files) and `.work.biz/prompts/` (6 files) exist and are in active use - the portable audit prompt at `.work.biz/prompts/framework-audit.md` is approved and was the method for this audit. Neither directory appears in `CONVENTIONS.md` § Project Memory nor in `standards/20260621-DIRECTORY_MAP.md`.

This is not cosmetic: `framework-audit.md:L38` instructs writing the report to `.work/reports/` (Agent OS path), which does not exist in a Business OS project. Precedent in this repo is `.work.biz/reports/20260814-biz-audit.md`.

**Proposed fix:** add both directories to DIRECTORY_MAP and to `CONVENTIONS.md` § Project Memory; correct the report path inside `framework-audit.md` to `{WORK_BUSINESS_ROOT}/reports/`. Note that `standards/` is a **protected** path, so the DIRECTORY_MAP edit needs same-message approval.

### 11. This plan file has no canonical home - `confirmed`

`.cursorrules` § Documentation Conventions and `CONVENTIONS.md` § Naming both say plans are `plan_<topic>.md` under `.work.biz/plans/`. The two prior improvement plans live in `.work.biz/reports/` (`20260707-biz-improvement-plan.md`, `20260814-biz-audit.md`) instead. This file follows the written convention, which makes the precedent inconsistent rather than resolved.

**Proposed fix:** pick one. Either plans-of-record live in `plans/plan_*.md` and `reports/` holds only audits, or the naming section gains a `reports/` row. Resolved by item 10 if the operator chooses the second branch.

---

## Round 2 - items 7-11 applied, plus the operator's 7 lead-facing asks

All approved by the operator in one message ("COMPLETE ALL PENDING IMPROVEMENTS"), then extended by a 7-item request about lead-facing capability. Everything below is applied and gated.

### Items 7-11 from round 1

| Item | Outcome | Evidence |
|------|---------|----------|
| 7 | `agent.os.framework.md` **deleted** | Was tracked, so recoverable from git. Verified load-bearing only in Agent OS: `pilo.ai.logicbison/skills/session-control/skill.md:L81` and `reference.md:L104,L574` use it as the source marker, and `pilo.ai.logicbison/agent.os.framework.md` (623 B) is intact. Nothing in this repo or `scripts/sister-discovery.sh` read it |
| 8 | Both gates made untracked-aware | `scripts/touch-scope-verify.sh` and `scripts/blast-radius-check.sh` now measure `git ls-files --others --exclude-standard` when nothing is staged, mirroring each other. Added a self-test scenario: three untracked areas with nothing staged must fail. `blast-radius-check.sh --self-test` PASS |
| 8b | `framework-verify` upgraded | Added README↔CHANGELOG version congruence (negative-tested: a synthetic v0.6.0 badge against a v0.7.0 changelog is detected) and a block that **runs all 5 sibling `--self-test` suites**. Those suites existed but CI ran none of them, which is how the item 8 blind spot survived. 66 → **102 OK** |
| 9a | `START_HERE.md` §7 reading order split into tiers | The old flat 9-file list cost ~177 KB (~44k tokens) and contradicted `@biz-session start` §S1, which reads 5 files. Tier 1 is now exactly what `start`/`context` load; `README.md` + `skills/README.md` + `CONVENTIONS.md` (~48 KB, ~12k tokens) moved to on-demand. Byte figures live here, not in `START_HERE.md`, so that file cannot drift |
| 9b | **Partially applied - ratchet only** | `framework-verify` now enforces a per-skill byte budget (default 31,000 B; `biz-social` 61,942 / `biz-strategy` 61,317 / `biz-session` 37,069 grandfathered at their 2026-11-14 sizes) and fails on growth. Negative-tested. The **extraction itself is not done**: `biz-strategy` has 11 verifier couplings, all inside Design and Certify, and the clean seam is I1 Greenfield (200 lines) + I2c Reconcile (59) + I2d Career (41) = 300 lines with zero couplings. Recorded as a scoped task, not attempted blind in a session already carrying 32 changed paths |
| 10 | `reports/` and `prompts/` documented | Added to `standards/20260621-DIRECTORY_MAP.md` (protected path, approved) and `CONVENTIONS.md` § Project Memory. `framework-audit.md:L38` hardcoded `.work/reports/`, which is wrong in every non-Agent-OS repo; now `<work root>/reports/` with the per-framework mapping |
| 11 | Plan vs report resolved | `CONVENTIONS.md` § Documents gains a binding rule: plans are forward-looking and live in `plans/plan_<topic>.md`; reports are records and live in `reports/YYYYMMDD-<topic>.md`, never rewritten |
| 12 (new) | `biz-deploy-files.sh` latent bug found, **not fixed** | `scripts/biz-deploy-files.sh:L120` builds its rsync list from `git ls-files --cached --others`, so a file deleted from the worktree but still in the index is listed and rsync aborts with exit 23. Observed live: deleting `agent.os.framework.md` before staging made `framework-verify` exit 23 mid-run. Staging the deletion cleared it. Fix would be to filter the list to paths that exist, or to fail with a named file instead of an rsync code |

### The operator's 7 lead-facing asks

| # | Ask | What was done |
|---|-----|---------------|
| 1 | Improved LinkedIn advice | `skills/biz-social/platforms/linkedin.md` and `concepts/content-platform-algorithms/prompt.md` corrected against 2026 evidence. **Three tactics the framework actively recommended are now penalized:** link-in-first-comment (detected and suppressed, 20-80% reach loss), "first 60 minutes decide reach" (posts now circulate 2-3 weeks), and 3-5 hashtags (10+ is a penalty; hashtags are near-obsolete). Added: interest graph and topic territories, dwell and saves as the dominant signals, educational 3-5x promotional, founder-led ~5x page, polls dead at ~0.07%, AI-slop filter, and 7 new anti-patterns. Carousel section de-contradicted |
| 2 | Improved CV/resume generation | `biz-career` now points at the new GenAI labour-market and geographic evidence sections. BIZ-13's evidence-recovery ladder and human-attention resume model were already sound and were left alone |
| 3 | Improved IT/software/consulting/GenAI career advice | New `docs/sources/verified-sources.md` § Generative AI / AI engineering labour market (2026), 11 graded rows. Contradictions recorded rather than averaged: Dice +91% YoY vs Canaria -10% YoY; "average AI engineer" $134K-$206K. Actionable findings: a 15-25% premium attaches to **shipped production** agentic systems while LangChain-tagged roles top out ~$80K lower; only ~2.5% of postings target 0-2 years; the Big Four are now volume hirers (Deloitte 3,025, Accenture 2,767, EY 1,495, PwC 1,307) |
| 4 | Jobs and projects by country, incl. LatAm and Costa Rica | **The largest true gap - no geographic coverage existed anywhere.** New concept **BIZ-14 `concepts/geo-sourcing/prompt.md`**: three-ring model (domestic / regional / northward), a 5-step ring-sizing method using first-party board counts, channel classes per ring, positioning against the arbitrage, and contracting shape before any rate. Registered in `concepts/README.md` with 3 trigger rows, referenced from `biz-career`, and covered by 4 new `framework-verify` checks. Costa Rica worked in detail: Indeed ~115 domestic remote roles vs ~8,100-10,600 region-wide (a ~70-100x ratio, grade A/B), Ley 9738 and Ley 10168, EF EPI 604 for IT professionals vs 516 nationally, 2-4 week paid-pilot norm |
| 5 | Marketing tips for business / individuals / products | Addressed through 1 and 4 plus the evidence catalog. `standards/20260621-BRAND-GUIDE.md` is only 2,527 B and is the thinnest binding standard in the framework; recorded as an open question rather than padded |
| 6 | Bottom line: get hired and get clients | Every change above is aimed here, and BIZ-14 §3 now *requires* at least one northward channel and at least one direct approach in any plan, so a pipeline cannot be built entirely from platform listings. **The honest caveat stands:** the framework has still never been run end-to-end on a live search or a live pipeline, so none of this is validated by outcome. That is Open question 2 |
| 7 | Verify lead-facing content is natural and non-AI-detectable | **Implemented as verifiable, with the premise corrected.** New `CONTENT-STANDARD` § Lead-facing artifacts binds the existing anti-AI floor on resumes, CVs, profile copy, proposals, outreach sequences, discovery recaps and written objection answers - artifacts produced by 5 skills that were never in scope of the scan. Rule 2 **forbids any detector-evasion claim**, because the evidence runs both ways: Liang et al., *Patterns* 4(7):100779 (2023, grade B) found 61.22% of 91 TOEFL essays flagged as AI and 97% flagged by at least one of seven detectors, while Van Vlasselaer (2026, grade B) found Turnitin and GPTZero detected **0%** of fully-AI papers in a 160-document ground-truth set. Rule 4 protects second-language English as voice rather than defect, which is the operative risk for a LatAm operator. 5 skills wired; `framework-verify` enforces the wiring and fails if any skill promises detector evasion |

**Gate state after round 2:** `framework-verify` exit 0, **102 OK / 0 FAIL** · `gate-verify` PASS · `touch-scope-verify` PASS · `blast-radius-check` PASS. 32 paths changed. Nothing pushed.

---

## Decisions

1. **Item 12** - fix `scripts/biz-deploy-files.sh:L120` so a staged-but-uncommitted deletion cannot abort a deploy with rsync exit 23? Low risk, and the failure mode is cryptic.
2. **Item 9b** - proceed with extracting `biz-strategy` I1 Greenfield + I2c Reconcile + I2d Career (300 lines, zero verifier couplings) into `skills/biz-strategy/reference.md`? Cuts that skill's per-invocation load by roughly 37%. Needs its own session: the 11 couplings in Design and Certify must stay in `skill.md`, and a new check should assert `reference.md` is actually referenced so the split cannot silently orphan content.
3. **`BRAND-GUIDE.md`** at 2,527 B is the thinnest binding standard in the framework and carries `brand-ready`. Expand it, or is its brevity deliberate?
4. **`linkedin-video.md`** (405 lines) still carries "first comment" posting-ritual advice that was not re-verified against 2026 evidence. Give it the same correction pass?
5. **Release**: round 1 + round 2 together are a coherent v0.8.0 (2 new verifier blocks, 1 new concept, 1 extended binding standard, 3 corrected platform tactics). Cut it, or hold until item 9b lands?

## Open questions

1. Should the remaining large skills be split so a session loads a hot path and pulls reference material on demand, the way `biz-social` already does with `platforms/`? The ratchet now prevents growth but does not reduce what exists.
2. Is the framework over-built relative to its runtime evidence? Still `unknown`, and round 2 made it sharper: the framework now carries a 2026-current LinkedIn model, a GenAI labour-market catalog and a geographic sourcing method, and **none of the three has been used on a live search or a live pipeline**. 10 of 22 `UNKNOWNS.md` rows remain open and 15 of 17 `NEXT.md` active tasks are still "validate on a live project".
3. `gate-verify.sh` returns `skip` rather than `fail` when `gates.md` is absent. This repo now has a ledger, but a consumer project that loses its `gates.md` still passes every gate check silently.
4. Does the ~44k-token session-start figure survive the tier split in practice? `estimated` until one real `@biz-session start` is timed against the new §7.

## Next action

Answer Decisions 1-5 above; the highest-value single item is Decision 5, because everything applied in rounds 1 and 2 is currently uncommitted and unreleased.
