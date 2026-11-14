# HANDOFF — Session Bookmark

> **Date:** 2026-11-14
> **Status:** Closed — 2026-11-14 — goal: improve the Business OS framework. Shipped **v0.8.0**: BIZ-14 geographic sourcing, a lead-facing natural-voice floor, three corrected LinkedIn tactics, `framework-verify` 66→102 checks, both change-safety gates made untracked-aware, and a documented release process. Plan of record with full evidence: `plans/plan_framework_improvement_20261114.md`.
>
> **Superseded open session (2026-11-05, never closed):** goal was `@biz-deploy-basic update` on `/mnt/work/Projects/system-news`. Measured 2026-11-14, the deploy **did land**: `system-news/.cursorrules` carries a paired `BIZ_DESIGN_OS_BEGIN`/`END` block, `AI_BIZ_SOURCE=/mnt/work/Projects/pilo.ai.biz.logicbison` at `.cursorrules:486`, `.work.biz/` fully scaffolded (incl. `gates.md`, `decisions/`, `reference/`), and `biz-cursorrules-merge.sh --state` reports `present`. Only the bookend was missing, and it is now written: `NEXT.md:L18` fleet count corrected this session.

---

## Session summary (2026-11-14, framework improvement + v0.8.0 release)

| Step | Status |
|------|--------|
| Read-only audit per `.work.biz/prompts/framework-audit.md` — measured rather than assumed: session-start load ~177 KB / ~44k tokens, `.work.biz/` at 6/16 manifest files, README badge two releases stale, 66 verifier checks all string-presence. Findings + evidence written to `plans/plan_framework_improvement_20261114.md` **before** any change, per the operator's instruction | Done |
| **Root `QWEN.md` replaced** (commit `8bccabf`) — it was a byte-identical copy of `system-news/QWEN.md` (md5 `beaf5cbc`, untracked here) telling every host session to verify via `./bin/start.sh` in docker and read state from `.work/`; none of `bin/`, `apps/`, `.work/`, `docker-compose.dev.yml` exist in this repo. New adapter is 75 lines, points at `.cursorrules` rather than restating it so it cannot drift, 23/23 asserted paths checked | Done |
| **`.work.biz/` scaffolded 6/16 → 16/16 files, 4/10 → 10/10 dirs** via `templates/bootstrap.sh`, chosen over `biz-deploy-basic.sh .` because bootstrap is `copy_if_missing` throughout and explicitly skips an existing `.cursorrules` (`bootstrap.sh:L86-87`). `gate-verify` went from `skip` to a real `PASS` | Done |
| **HANDOFF slimmed to its own budget** — 7 live session blocks against CONVENTIONS § Context budget's ~5; the 4 oldest moved to `HANDOFF.archive.md` newest-first with a pointer left behind. 14 unique blocks across both files, none lost or duplicated | Done |
| **Both change-safety gates were blind to untracked files** — `blast-radius` reported `files=5 areas=2 risk=med` while `git status` listed **11** paths, so six new files including three whole directories passed unseen and the risk rating was computed from under half the change. Both now mirror each other (staged wins; else worktree + `git ls-files --others --exclude-standard`), with a new self-test scenario that fails without the fix | Done |
| **`framework-verify` 66 → 102 checks** — README↔CHANGELOG version congruence (negative-tested against a synthetic stale badge), newest-release tag congruence, **all five sibling `--self-test` suites now executed** (they existed but CI ran none, which is exactly how the blind spot survived), per-skill byte ratchet failing on growth, BIZ-14 wiring, lead-facing floor wiring, detector-evasion prohibition | Done |
| **BIZ-14 `concepts/geo-sourcing/`** — the largest true gap; no geographic coverage existed anywhere and the catalog was US/UK-centric, so a resident of another market had no channel method. Three-ring model (domestic / regional / northward), ring sizing from first-party board counts, channel classes per ring, arbitrage reframe, contracting-shape-before-rate. Costa Rica worked in detail: ~115 domestic vs ~8,100–10,600 regional remote listings (~70–100x, grade A/B), Ley 9738 + Ley 10168, EF EPI 604 for IT professionals vs 516 nationally, 2–4 week paid-pilot norm. §3 now **requires** ≥1 northward channel and ≥1 direct approach, so a pipeline cannot be assembled purely from platform listings | Done |
| **Lead-facing natural-voice floor** — `CONTENT-STANDARD` § Lead-facing artifacts binds the anti-AI floor on resumes, CVs, profile copy, proposals, outreach sequences, discovery recaps and written objection answers across `biz-career`, `biz-proposal`, `biz-discovery`, `biz-objections`, `biz-brand`; none were scanned before. **Premise corrected rather than adopted**: rule 2 forbids detector-evasion claims because the evidence fails both ways at once — Liang et al. *Patterns* 4(7):100779 (2023, B) found 61.22% of 91 TOEFL essays flagged as AI with 97% flagged by ≥1 of 7 detectors, while Van Vlasselaer (2026, B) found Turnitin and GPTZero detected **0%** of fully-AI papers in a 160-document ground-truth set. Rule 4 protects second-language English as voice, since detectors score perplexity | Done |
| **Three LinkedIn tactics the framework recommended are now penalized** — link-in-first-comment (detected and suppressed, 20–80% reach loss), "the first 60 minutes decide reach" (posts circulate 2–3 weeks), and 3–5 hashtags (10+ is a visibility penalty; hashtags near-obsolete against semantic analysis). Corrected in `platforms/linkedin.md`, `platforms/linkedin-video.md` (5 spots incl. the deliverable list, posting ritual and QA checklist) and BIZ-07. Added: interest graph, dwell + saves as dominant signals, educational 3–5x promotional, founder-led ~5x page, polls dead at ~0.07%, AI-slop filter, 7 new anti-patterns | Done |
| **Four new graded source sections, 26 rows** in `docs/sources/verified-sources.md`: geographic sourcing, GenAI / AI engineering labour market 2026, AI-text detectors, LinkedIn distribution 2026. Contradictions recorded rather than averaged — Dice +91% YoY vs Canaria −10% YoY; "average AI engineer" $134K–$206K. Findings that survive the conflict: 15–25% premium on **shipped production** agentic systems while LangChain-tagged roles top out ~$80K lower; only ~2.5% of postings target 0–2 years; Big Four are volume hirers | Done |
| **Release process documented** — `CONVENTIONS.md` § Release process. `grep CHANGELOG` returned **nothing** in `CONVENTIONS.md`, `.cursorrules`, `biz-review` and `biz-archive`, which is the root cause of v0.6.2 / v0.6.3 / v0.7.0 shipping untagged and the badge freezing at v0.6.0 for four releases. Also § Plan vs report, resolving that plans of record live in `plans/plan_*.md` and never-rewritten audits in `reports/`. CI workflow gains `fetch-tags: true` so the tag check runs instead of skipping | Done |
| **`scripts/biz-deploy-files.sh` rsync exit 23 fixed** — the copy list came from `git ls-files --cached --others`, which includes index entries for files deleted from the worktree but not yet staged; rsync then aborted with an error naming rsync, not the missing file. Now filtered to existing paths with dropped entries reported by name. Found live: deleting `agent.os.framework.md` before staging aborted `framework-verify` mid-run at exit 23 | Done |
| **Removed `agent.os.framework.md`** — declared this repo the *Agent OS* framework source with a self-hosted `.ai`, described a source-detection rule this framework does not use (`biz-session` §I0 tests for `skills/biz-session/skill.md`), and claimed protected status `.cursorrules` § Protected Files never granted. Leftover of the 2026-08-14 marker-detection removal; the only file referencing it was that removal's own audit prompt. The real marker at `pilo.ai.logicbison/agent.os.framework.md` (623 B) is untouched and still load-bearing there. Also removed stray root file `1` (21 B, `$: command not found`) | Done |
| **`session-control` name collision documented** — Agent OS owns a *different* skill of that name (`pilo.ai.logicbison/skills/session-control/`) with its own repo-mode detection and `.work/` paths, while `biz-session/skill.md:L108` claimed it as an alias. In a cohabitation repo the bare alias is ambiguous and resolving it to Business OS would write `.work.biz/` when the operator meant `.work/`. `@biz-session <verb>` is now canonical; the alias is a single-framework convenience, not a claim on the name | Done |
| **`START_HERE.md` §7 tiered** — the flat nine-file reading order cost ~177 KB (~44k tokens, ~51k for `@biz-strategy design`) and contradicted `@biz-session start` §S1, which reads five. Tier 1 is now exactly what `start` / `context` load; `README.md` + `skills/README.md` + `CONVENTIONS.md` (~48 KB, ~12k tokens) moved to on-demand. Byte figures live in the plan, not in `START_HERE.md`, so that file cannot drift | Done |
| **`reports/` and `prompts/` documented** in DIRECTORY_MAP (protected path, operator-approved) and CONVENTIONS § Project Memory; `framework-audit.md:L38` hardcoded `.work/reports/`, wrong in every non-Agent-OS repo, now `<work root>/reports/` with the per-framework mapping | Done |
| Gates: `framework-verify` exit 0 / **102 OK / 0 FAIL** · `gate-verify` PASS · `touch-scope-verify` PASS · `blast-radius` high (6 areas — cross-cutting release, acknowledged, warn-only per Key decision 34). The one expected FAIL was the new tag-congruence check firing on v0.8.0 before the tag existed; re-verified green after tagging | Done |

**Verify in-repo:** `bash scripts/framework-verify.sh` (expect 102 OK / 0 FAIL) · `bash scripts/blast-radius-check.sh --self-test` (covers the untracked case) · `git tag -l 'v0.8.0'` (expect the tag) · `grep -c 'Lead-facing artifacts' skills/biz-{career,proposal,discovery,objections,brand}/skill.md` (expect 1 each).

**Prior sessions below are historical.**

---

## Session summary (2026-10-25, cohabitation deploy + strategy design + career skill)

| Step | Status |
|------|--------|
| Audit finding (measured, not assumed): `@biz-deploy-basic` into a project that already had another framework's `.cursorrules` wrote `.work.biz/` and **no Business OS wiring** — no pointer, no skills table; `update` printed a merge candidate no script could apply. Reproduced on a foreign-file fixture before the fix | Done |
| **Managed block**: `templates/cursorrules.biz.snippet.template` + `scripts/biz-cursorrules-merge.sh` (`merge`/`refresh`/`state`/`print`, thin + fat layouts). Deploy default = merge; `--no-merge` = old skip; `update` refreshes only the region; unmatched marker = refuse + untouched file; `biz-deploy-files` (fat) wired the same way | Done |
| **Verifier**: marker-pair integrity, merged-layout scoping (another framework's `bash scripts/…` is not a biz finding), self-heal append for targets an older deploy left unwired, naming-agnostic stale-pointer repair. Fixed a bug that **deleted the verified `.cursorrules`** when no block existed | Done |
| **Paths**: `pwd -P` everywhere (one physical source → one pointer); the source registry's `.ai.ui`/`.ai.soc` cells pointed at non-existent `../.ai.*` and FAILed the framework against itself — all seven cells now name the real family dirs; template thin-client dead references (`skills/SKILL_DEPENDENCIES.md`, `templates/work/touch-scope.template`, `{SKILLS_ROOT}`) fixed | Done |
| **Strategy design**: `@biz-strategy design` (I1b) + `concepts/strategy-design/prompt.md` (BIZ-11) — 6-lens audit, 7 archetypes, do-nothing-first alternatives map, 5–8 plays, weighted graded scoring, sensitivity, WWHTBT, 11-row pre-mortem, moat taxonomy, breakeven worksheet; incumbent play competes; rejected plays keep re-entry conditions | Done |
| **Certify checks 14–17** (alternatives / pre-mortem / moat / sensitivity-breakeven) + `@biz-review quarterly` **counterfactual audit** (scores the selection process, re-enters a winning rejected play) + `CONVENTIONS.md` § Strategy design (8 binding rules) | Done |
| **Enforcement**: `framework-verify` gains the foreign-`.cursorrules` merge matrix, canonical-pointer check, template dead-reference guard, skill-discovery coverage on both templates, and the strategy-design wiring block. Pre-existing rsync `chgrp` abort (exit 23 on `/tmp`) fixed with `-rlptD` | Done |
| Fleet audit (read-only `status` over 21 consumer repos): 6 wired by hand merge (`legacy`, 0 FAILs), 15 with no Business OS wiring — each becomes wired with one `update`. Two repos carry stale `.ai.ui`/`.ai.soc` registry cells. Recorded in NEXT #1 | Done |
| **`future-strategy` update + the bug it exposed** — legacy five-framework `.cursorrules`: the pointer assignment had been migrated to `AI_BIZ_SOURCE=` while **6 prose references still said `$AGENT_OS_SOURCE`** (undefined there), so resolution rule 2 pointed at nothing; skills table had 23 of 26 rows (no design mode, no `biz-career`/`biz-advisory`/`biz-sources`); protected-file ref was a local path. Fixed as a legacy section merge (`15 insertions / 10 deletions`, nothing outside the Business OS sections), `.work.biz/decisions/` scaffolded, verifier PASS | Done |
| **Verifier: stale prose pointer detection** — `--fix` renames `AGENT_OS_SOURCE=` → `AI_BIZ_SOURCE=` but not the prose; a migrated hand merge can keep rules naming a dead variable. `biz-cursorrules-verify.sh` now warns inside the source-resolution section only (never auto-rewrites another framework's text); deploy skill's legacy merge rule says fix the prose; changelog records it. Tested both directions (fires on a reconstructed pre-fix fixture, silent on the repaired target); `framework-verify` 66/66 | Done |
| **Live verification of the merge** — `mendarion` (UI + Agent OS + Social OS already in `.cursorrules`): `update` → `state=absent` → block appended, `git diff --stat` **111 insertions, 0 deletions** (separator + 110-line block), original 421 lines byte-identical, `.work.biz/` scaffolded, verifier PASS. First attempt was denied by the file sandbox (read-only target) and failed safely with the file untouched — which surfaced two gaps, both fixed: accurate appended/refreshed reporting, and a writability pre-check with a single-payload write so a failure cannot half-append |
| **`@biz-career`** (new skill, 5 modes) — job search plan with a capacity check and a kill signal, resume elaboration via an **evidence-recovery ladder** (no invented numbers; untraceable bullets become reported gaps), interview story bank, offer evaluation. Artifacts live in existing dirs — no scaffold change, no re-bootstrap |
| **BIZ-12 IT services strategy** + **BIZ-13 career search** playbooks; both wired into `biz-strategy design` (IT lens during D2–D4) and `biz-career` |
| **`docs/sources/verified-sources.md`** — 16 fetched-and-graded sources (Hinge High Growth 2025 B; Stark A; Dunford A; ConnectWise SLI A/B; Dalton A; Kuhn & Skuterud AER 2004 B; Ladders/HR Dive 2018 C; NBER w33903 2025 B; OPM A; AOM 2025 B) + a "what the evidence does not support" section (no ATS-rejection rate, no referral conversion, no causal positioning claim) + 12 recorded-unverified sources. `@biz-sources find` checks it before re-searching |
| Docs: `COHABITATION.md` (new), `biz-deploy-basic`/`biz-bootstrap` skill docs, `templates/README.md`, README, START_HERE, PROCESS_ROUTER, `skills/README.md`, `biz-director`, `concepts/README.md`, CHANGELOG v0.7.0 | Done |

**Verify in-repo:** `bash scripts/framework-verify.sh` (expect all pass) · `bash scripts/biz-deploy-basic.sh <fixture-with-foreign-.cursorrules>` (expect "merged Business OS block") · `bash scripts/biz-cursorrules-merge.sh <target> --state` (expect `present`).

**Prior sessions below are historical.**

---

## Session summary (2026-10-15, deploy-reliability close)

| Step | Status |
|------|--------|
| Audit share of `.work/feedback/20261015-deploy-configure-cohabitate.md/` (in `pilo.ai.logicbison`): biz had `BIZ_SOURCE` override + `bash scripts/` bake/verify already; the gap was an unguarded force overwrite | Done |
| `scripts/biz-deploy-basic.sh`: arg token `confirm-overwrite-cursorrules`; force on existing `.cursorrules` → BLOCKED exit 1 + lost-content listing unless the token is named; default skip unchanged | Done |
| `skills/biz-deploy-basic/skill.md`: force row, flag-equivalence note, leak-block, step 3, idempotency, checklist (6 spots) | Done |
| Evidence: force blocked/token/skip matrix on mktemp targets; `framework-verify` PASS | Done |

**Verify in-repo:** `bash scripts/framework-verify.sh` · `bash scripts/biz-deploy-basic.sh /tmp/t --force` (expect BLOCKED exit 1) · append the token to overwrite.

**Prior sessions below are historical.**

---

## Session summary (2026-10-09, judgment-quality layer close)

| Step | Status |
|------|--------|
| Audited the advice/planning layer for judgment-quality mechanisms: framework-wide absence of decision records, outcome tracking, base rates, pre-mortems, sensitivity, scenario analysis, and reversibility confirmed by grep plus a 10-file skill audit; BIZ-01–06 concept stubs found orphaned (no skill references any of them) | Done |
| **Decision loop shipped** — `.work.biz/decisions/DECISIONS.md` + template (7 required columns + Calibration + Repeating-misses), `CONVENTIONS.md` § Decision loop (consequence test, record rule, scoring rule, calibration rule, empty-ledger warning); writers wired into `biz-strategy` (certify/amend), `biz-advisory` (step 8), `biz-pricing` (set/revise), `biz-market-validate` (go), `biz-proposal` (send); auditor added as `@biz-review quarterly` § Decision audit + weekly overdue flag + monthly dead-assumption cross-check | Done |
| **Reality check shipped** — `biz-strategy` greenfield Element 8 (arithmetic table + outside view) and certify checks 11 Reality arithmetic, 12 Outside view, 13 Decision record; `biz-pricing` pre-quote reality check (margin / capacity / runway); `biz-advisory` outside-view step 4b + "does the math close" | Done |
| **Evidence grades A–D + freshness** — CONVENTIONS § Evidence discipline extended (tier ladder, grade-the-claim rule, 18/12-month freshness); consumed by `biz-advisory` step 4, the assumption-ledger Grade column, `biz-pricing` anchors, `biz-market-validate` Signal grade, `biz-sources` catalog | Done |
| **Load-bearing unknown gate** replaces the 30%-unknown count (certify check 3); ledger gains Load-bearing / If wrong / Grade columns; probe targets the largest blast radius first + new Reality question row | Done |
| **`@biz-director` never dead-ends** — 5 new intent rows, 4-way judgment-route disambiguation, no-match default (one splitting question → `@biz-advisory` fallback → orientation fallback → gap detection), decision ledger in I0, completion contract requires the row | Done |
| Manifest sync (rule #22): `decisions` dir + `decisions/DECISIONS.md` across bootstrap.sh, WORK_DIRS, WORK_FILES, templates/README, work/README.md.template, biz-bootstrap § I1/I2 (`empty ledger` warning), biz-deploy-basic; DIRECTORY_MAP canonized + Decision rule | Done |
| Routing surfaces: PROCESS_ROUTER (5 rows + judgment-loop section), START_HERE (tree, strategy/generative tables, resume, reading order, anti-patterns), skills/README (5 rows + `decisions` entry), `.cursorrules` + template (`{DECISIONS}`, Before-Claiming-Completion items 3–5, refreshed rows) | Done |
| `framework-verify.sh` — new "Decision loop wiring" block (template + 7 columns + conventions + 5 writers + auditor + director routing); bootstrap smoke test confirms `decisions/DECISIONS.md` scaffolds in a fresh target | Done |
| Gates: framework-verify PASS (rsync `--no-g` shim for the sandbox chgrp issue), gate-verify PASS (n/a — no ledger), touch-scope PASS (25 files), blast-radius WARN (10 areas, cross-cutting by design — acknowledged) | Done |

---

> Older session summaries (2026-09-10 evidence-guard hardening, 2026-08-21 advisory capability, both 2026-08-19 closes, and earlier) moved to `context/HANDOFF.archive.md` (Context budget, CONVENTIONS). Newest-first; nothing deleted.

## Pending for next session

| # | Task | Priority |
|---|------|----------|
| 1 | Smoke-test `@biz-advisory` on `future-strategy` against its own feedback case (`.work.biz/feedback/20260820-small-rescue-team.md`): does a cold run clear the calibration bar (reframe, ranked options with precedent, anti-advice, decisive pick)? Gaps become new BIZ-10 patterns (UNKNOWNS #12) | High |
| 1b | Smoke-test the biz-session verbs on a live target project: standalone `commit` (session stays open), `add` (stage-only), `close commit scoped`, task-ref extraction into `.work.biz/active-ref` | High |
| 1c | Retry `future-strategy` close commit/push with the patched biz-session — `reasonix.toml` sandbox now allows its own `.work.biz/` + `.git/`; pending `.work.biz` changes + the `reasonix.toml` edit are uncommitted there | High |
| 1d | **First live decision-loop run** — exercise it end to end on a real project: `@biz-strategy certify` or `@biz-advisory advise` must append a row to `decisions/DECISIONS.md`, and `@biz-review quarterly` must score it and produce a calibration row (UNKNOWNS #15) | High |
| 1e | Validate the reality check (certify checks 11–12) against a real strategy — does the arithmetic gate catch a genuinely unviable plan without blocking a viable one on missing data (UNKNOWNS #16) | High |
| 1f | Validate the A–D evidence ladder in practice — does an agent actually discriminate between tiers, or does every claim land at B/C (UNKNOWNS #17) | Medium |
| 1g | Tier 2, deliberately deferred: `@biz-market-validate` value-of-information gate + write the experiment result back into `strategy/assumption-ledger.md`; retire or upgrade the six orphaned `concepts/` stubs (BIZ-01–06, referenced by no skill); apply `biz-discovery`'s 84-day base rate to time-box live deals | Medium |
| 2 | Owner review/commit of the uncommitted `future-strategy` changes — the earlier slim-down (HANDOFF/NEXT/UNKNOWNS/CONTENT_STATUS + 17 status.md files + HANDOFF.archive.md) **plus today's thin-client update merge** (merged `.cursorrules`, `.work.biz` skeleton appends, new `strategy/README.md` + `reference/BRAND_STATUS.md`); its `PATHS.md` still carries stale `/mnt/work/Projects/.ai*` paths | High |
| 3 | First `@biz-sources find` run on a live project — seed the catalog, verify the vetting step holds (UNKNOWNS #13) | Medium |
| 4 | Validate pillar loop + quarterly alignment on real tracker data (needs ≥1 quarter of pillar-tagged publishes) | Medium |
| 5 | Substack + Threads guides are untested — no project has published to either. Validate against real output before trusting the cadence and format rules | Medium |
| 6 | Regenerate `.tmp/*.skill` archives — now also missing biz-archive, biz-advisory, biz-sources and the archive/context-budget changes | Medium |
| 7 | Test appeal standard + hardened `biz-writing` against a new LinkedIn draft and measure engagement vs `post_01_the_spreadsheet_nobody_owns` | Medium |
| 8 | Smoke-test `@biz-strategy amend` + re-certify path on a host with out-of-tree positioning docs | Medium |
| 9 | `.work.biz/touch-scope` was refreshed for this session and is accurate as of the v0.8.0 commit; delete or re-declare it at the next scoped edit session (Key decision 10) | Low |
| 10 | Owner decision: deletion candidates (`.work.biz/prompts/20260814-marker-detection-deploy-repo-removal-audit.md` — `.ai`-only, and now purely historical since `agent.os.framework.md` was removed 2026-11-14; `docs/adoption/FROM_AGENT_OS.md` + `docs/guides/workflows/README.md` stubs; `examples/`; stale `.tmp/*.skill`) | Low |
| 11 | Full dedup refactor: shared publishing-ops skeleton (biz-content/biz-youtube) + I0 context contract (biz-writing/biz-social) — portability tradeoff (UNKNOWNS #11) | Low |
| 12 | **Extract `biz-strategy` reference material** (Decision 2 in the plan) — seam is measured and clean: I1 Greenfield (200 lines) + I2c Reconcile (59) + I2d Career (41) = 300 lines with **zero** verifier couplings; all 11 couplings sit in Design and Certify and must stay in `skill.md`. ~37% cut to per-invocation load. Add a `framework-verify` check that `reference.md` is referenced from `skill.md`, or the split silently orphans content. Needs its own session | High |
| 13 | **Verify the tier split actually reduced session-start load** — the ~177 KB / ~44k token figure was measured against the old flat §7; time one real `@biz-session start` against the new tier 1 and record the number (UNKNOWNS new) | Medium |
| 14 | **Re-wire the fleet at v0.8.0** — 14 consumer repos are still `absent`, and the 7 already wired (`mendarion`, `system-news`, plus 6 hand-merged) now carry pre-v0.8.0 `.cursorrules` blocks that predate BIZ-14 and the release process. One `update` each | Medium |
| 15 | **Consider the same untracked-file fix in the sister frameworks** — `blast-radius-check.sh` and `touch-scope-verify.sh` are homogenized across the family, so Agent OS / UI / CTO / MLT / SOC / Flutter very likely share the blind spot. Verify before assuming; this session only measured Business OS | Medium |

---

## Key decisions (locked in)

| # | Decision |
|---|----------|
| 1 | **Platform guides** live under `skills/biz-social/platforms/` — loaded on demand, not inlined in `skill.md`. |
| 2 | **Topic buckets** canonical in `concepts/content-topic-buckets/` — referenced by biz-writing, biz-content, biz-youtube. |
| 3 | **LinkedIn video** — `@biz-social write linkedin video`; deep rules in `platforms/linkedin-video.md`. |
| 4 | **Anti-AI-artifact** — binding in Content Standard; scan required before content delivery. |
| 5 | **Zero em-dashes/en-dashes** in all generated content. Use periods, commas, colons, or parentheses instead. |
| 6 | **Human voice over literary voice** — contractions allowed, sentence length varied, minor roughness preferred to polished perfection. |
| 7 | **Actionable frameworks belong in the post body or a carousel**, not hidden in the first comment. |
| 8 | Four-tier content: `biz-writing` → `biz-social` → `biz-content` / `biz-youtube`. |
| 9 | Strategy artifacts in `.work.biz/strategy/` only. `plans/strategy_*.md` are historical/ad-hoc; on conflict, `strategy/` wins. |
| 10 | `.work.biz/touch-scope` is session-local — declare before scoped edits; not required in git. |
| 11 | **`biz-strategy amend`** records mid-cycle strategy changes + changelog; never certifies — re-certify required before gated work. |
| 12 | **Audience hierarchy** — primary (sharpness-tested) + secondary + opportunistic; static profile must respect the fork. |
| 13 | Gated skills (brand, pricing, content publish/plan/challenge) **self-check** `gates.md` strategy-ready; director gate is second layer. |
| 14 | **`CONTENT_STATUS.md`** is the canonical publish/status tracker; bootstrap creates it; publish flows update it. |
| 15 | **`reference/VOICE_PROFILE.md`** is the canonical voice definition — how *this owner* sounds, on every platform. The Content Standard's anti-AI-artifact rules are an unoverridable floor; its generic human-voice rules are overridable defaults. On format the platform guide wins; on voice the profile wins. |
| 16 | **Voice is defined by reference sample, not description.** Descriptions drift across sessions, samples don't. |
| 17 | **`reference/VOICE_RETRO.md`** measures whether the voice rules work: owner edits per piece must fall over time. Same edit class three times means amend `VOICE_PROFILE.md`, not the owner correcting forever. |
| 18 | **`@biz-strategy reconcile`** exists so correcting a file that contradicts its own certification does not cost four gates. Only for decisions the certified record already asserts but were never transcribed. Moves no gate; logs as **(correction)**. |
| 19 | **Graded claims** are mandatory on commentary: Verified / Inference / would-check, in the text. Commentary inherits other people's facts; grading stops their errors becoming yours. |
| 20 | **Gate status reading is tolerant** — a gate is met when its status *starts with* `PASS`, so hand annotations like `PASS 2026-07-25 - verified live` are valid. Gate ids match on a normalized form. |
| 21 | **Per-platform trackers** (`pipeline/<platform>-tracker.md`) are created on first publish, not at bootstrap. `CONTENT_STATUS.md` stays the cross-platform index. |
| 22 | **Bootstrap manifest sync rule** — `templates/bootstrap.sh`, `templates/README.md`, `scripts/biz-deploy-basic.sh` `WORK_FILES`, `skills/biz-deploy-basic/skill.md`, and `skills/biz-bootstrap/skill.md` § I1 must list the same files. `WORK_FILES` is the one that fails silently. |
| 23 | **All skill ids carry the `biz-` prefix** (v0.6.0) — one naming scheme, no exceptions; `session-control` remains an alias of `biz-session`. Old ids (`content-social`, `content-writing`, `deploy-*`, `session-biz`, `business-ideas`, `product-service-ideas`) exist only in pre-v0.6.0 CHANGELOG sections. |
| 24 | **One writer per gate is binding** — `active-deal` is promoted by `@biz-discovery run` alone; `@biz-proposal write` is not a promoter. |
| 25 | **Content Status Protocol is binding on all content skills** — every content skill reads `CONTENT_STATUS.md` before drafting and records into it after producing or publishing; a missing tracker is created from its template at record time, never a reason to skip the record. Publishes that happened outside any skill are recorded via `@biz-social log`. Lifecycle: draft → ready → published (+ blocked, hold). |
| 26 | **`blast-radius-check.sh` measures the next commit, not the tree** — staged content wins when anything is staged; working-tree-vs-HEAD only when nothing is staged. This is what makes the split-into-scoped-commits workflow executable. |
| 27 | **OPERATOR_PROFILE lives in `reference/`, not `strategy/`** — it is input to positioning decisions, not a positioning decision. In `strategy/` it would trip the drift check on every career update and could even demote gates; in `reference/` it never interferes with the gate machinery. Same reasoning keeps it out of the weekly date comparison. |
| 28 | **The drift check compares positioning files only** — one-pager, target-buyer-profile, offer-scope, channel-plan, pricing. The ledger, changelog, and linkedin-icp are non-positioning by design; flagging them trained operators to ignore the check. Dead load-bearing assumptions still surface via monthly re-validation routing through amend. |
| 29 | **Pillar assignment happens at registration, never retroactively in bulk** — a published piece with no pillar is a recording failure. Pillars are the bridge that lets quarterly reviews aggregate conversations by strategic message. |
| 30 | **Evidence claims need a citation or a directional marker; a machine check was rejected** — grep cannot tell a claim about the world from advice, and 83 false-positive-prone hits would drown real findings. The rule lives in CONVENTIONS § Evidence discipline and is enforced by prose review. |
| 31 | **The appeal standard never overrides truth** — sharper is never worth invented detail. When proof points are thin, the fix is `PROJECTS.md`, not embellishment. |
| 32 | **The publish record lives with the piece, the tracker tracks the live inventory** — archiving writes a per-piece `status.md` (never a centralized `ideas.archive/status.md`, which would need rewriting every run); only after that record is verified does the row leave CONTENT_STATUS. Lifetime aggregates (By platform Last publish, By pillar conversations) stay in the tracker. |
| 33 | **Context budget: history is moved, never deleted** — session-start files (HANDOFF, NEXT, UNKNOWNS, CONTENT_STATUS) stay lean; older material moves to sibling `*.archive.md` files with a pointer line. biz-session close performs the slim. |
| 34 | **Change-safety gates are warn-only in the pre-commit hook by default** — `hooks/pre-commit` runs touch-scope-verify + blast-radius-check with `--warn-only` on every commit (prints findings, never blocks); `GATES_ENFORCE=1 git commit …` restores blocking, `WARN_ONLY=1` forces warn-only. Tracking hooks (prepare-commit-msg ref prefix, commit-msg Co-authored-by rejection, post-commit commit-ref metadata) unchanged. Decided so the operator can commit/push from the shell without being stopped by the gates. |
| 35 | **Pricing rules have one canonical home** — binding rules in `standards/20260621-PRICING-STANDARD.md` (fixed-price only, 50% upfront, never discount — reduce scope instead); post-delivery offer table canonical in `skills/biz-pricing/skill.md` § Post-Delivery Offers; `biz-proposal` points at both instead of restating them. |
| 36 | **`biz-advisory` is counsel-only — it never moves gates.** When advice converges on a direction, the handoff is `@biz-strategy` / `@biz-market-validate`; certification stays with the gate writers. The rescue-team feedback case is its standing calibration bar. |
| 37 | **The advisory-source catalog is per-project** (`.work.biz/research/sources.md`, curated by `@biz-sources`); the framework ships only verify-before-citing seeds — no source is cited as fact until fetched and dated. |
| 38 | **Host write guards are a host feature, and biz-session pre-empts them** — before any git step, re-read the session files the close just wrote and keep an acceptance-criteria todo active; a host denial (`blocked: establish a concrete todo…`, `persistent read-evidence requirement…`) is retryable once before the checklist may mark git failed. |
| 39 | **The judgment loop is the missing third loop** — voice (`VOICE_PROFILE`→`VOICE_RETRO`) and assumptions (`@biz-review monthly`) were measured; decisions were not. `.work.biz/decisions/DECISIONS.md` closes it: append-only, one row per consequential decision (money, >1 week of time, a price, a buyer, a primary channel, a public position) with a falsifiable expected outcome, a confidence, a reversibility class, a kill/review trigger, and a review date. |
| 40 | **A decision is only real if it can be wrong** — the ledger's Expected-outcome field must carry a number and a date (or an observable event). Prose decisions ("we'll focus on LinkedIn") are unfalsifiable and therefore unscorable; the record rule refuses them rather than storing them. |
| 41 | **One writer per artifact, mirroring one-writer-per-gate** — five skills append decision rows (`biz-strategy certify`/`amend`, `biz-advisory advise`, `biz-pricing set`/`revise`, `biz-market-validate test`, `biz-proposal write`) but exactly one scores them (`@biz-review quarterly`). Scoring is never done by the skill that made the call. |
| 42 | **Certification now requires arithmetic** — a strategy whose revenue ceiling at the floor price does not cover the income target before runway ends, or whose required prospects/week exceed the primary channel's realistic capacity, cannot certify. The fix is `probe`, not certifying anyway. |
| 43 | **The 30%-unknown count was the wrong metric** — it weighted a trivial gap and an existential one equally. Replaced by the load-bearing test: no assumption anchoring buyer, problem, offer, primary channel, or price may be Unknown or rest on grade-C/D evidence; peripheral unknowns stay capped at 30%. |
| 44 | **A citation is not a source quality** — evidence grades `A` (first-party/primary) / `B` (named third-party with method) / `C` (vendor, media, single anecdote) / `D` (memory, undated) are written next to the claim *in addition to* the citation. Grade the claim, not the author; syndicated copies are not corroboration. Freshness: 18 months, 12 in fast-moving domains. |
| 45 | **`@biz-director` must never dead-end** — when no intent row matches, it asks one splitting question (never a menu of skill names), defaults to `@biz-advisory` for "what should I do / is this right" (whose hand-off *is* the orchestration), defaults to session+review status for orientation in disguise, and reaches gap detection only after that. |
| 46 | **A release is four artifacts that move together** — CHANGELOG entry, README badge, git tag, and pushing commit *and* tag. Versions are monotonic against `CHANGELOG.md`, not against the tag list: if a past release was never tagged, tag forward from the next one and record the gap, never back-tag below a published version. v0.6.2 / v0.6.3 / v0.7.0 stay untagged as a documented gap. Binding text: `CONVENTIONS.md` § Release process. |
| 47 | **Plans of record live in `plans/plan_<topic>.md`; `reports/` holds dated audits that are never rewritten.** An audit that proposes changes is both: findings in `reports/`, approved work in `plans/`. Binding text: `CONVENTIONS.md` § Plan vs report. |
| 48 | **No detector-evasion claim, ever, and the natural-voice floor binds every lead-facing artifact** — not just content skills. Detectors are not a usable oracle: they over-flag non-native English and under-detect actual AI text. The floor is justified by reader trust, and second-language English is voice, not a defect to be optimised away. Binding text: `CONTENT-STANDARD.md` § Lead-facing artifacts. |
| 49 | **`@biz-session <verb>` is canonical for Business OS work.** `session-control` is an alias of convenience for single-framework repos only; Agent OS owns a different skill of that name with its own repo-mode detection and `.work/` paths, so in a cohabitation repo the bare alias resolves to Agent OS unless stated otherwise. |
| 50 | **`START_HERE` §7 is tiered, and tier 1 is by definition what `@biz-session start` §S1 reads.** A reading list the start protocol does not implement is a list agents either ignore or over-read; both cost more than the split. Byte figures live in dated plans, never in the routing doc, so it cannot drift. |
| 51 | **`standards/20260621-BRAND-GUIDE.md` stays thin by operator decision (2026-11-14)** — 2,527 B while carrying the `brand-ready` gate. Deliberate, not an oversight; do not "fix" it by padding. |
| 52 | **Change-safety gates measure untracked files too.** Staged content still wins when anything is staged (that is what makes split-into-scoped-commits executable), but with nothing staged both gates now include `git ls-files --others --exclude-standard`. A scaffold or a new skill folder is a touched path. |
| 53 | **Skill size is ratcheted, not policed by taste.** `framework-verify` fails when a `skill.md` grows past its byte budget; the three grandfathered files are named in the script. Raising a baseline is a deliberate written act, and the intended direction is extraction into a sibling `reference.md`, the pattern `biz-social/platforms/` already uses. |

---

## Quick reference

| Need to... | Read / Run |
|------------|-----------|
| What to do next | `.work.biz/plans/NEXT.md` |
| Cross-border jobs or clients (resident ≠ buyer) | `concepts/geo-sourcing/prompt.md` (BIZ-14) |
| Natural-voice rules for a resume / proposal / outreach | `standards/20260621-CONTENT-STANDARD.md` § Lead-facing artifacts |
| Cut a release | `CONVENTIONS.md` § Release process |
| Graded evidence base | `docs/sources/verified-sources.md` (7 sections, 42 rows) |
| Situational advice ("what should I do?") | `@biz-advisory - <situation>` |
| Advisory pattern library | `concepts/advisory-patterns/` (BIZ-10) · `@biz-advisory patterns` |
| Advisory source catalog | `.work.biz/research/sources.md` · `@biz-sources find - <topic>` |
| LinkedIn video | `skills/biz-social/platforms/linkedin-video.md` |
| Platform guides | `skills/biz-social/platforms/` |
| Content quality bar | `standards/20260621-CONTENT-STANDARD.md` |
| LinkedIn text/carousel rules | `skills/biz-writing/skill.md` § LinkedIn post |
| Strategy change mid-cycle | `@biz-strategy amend` then `@biz-strategy certify` |
| Publish status tracker | `.work.biz/reference/CONTENT_STATUS.md` |
| Decision ledger + calibration | `.work.biz/decisions/DECISIONS.md` · `@biz-review quarterly` |
| Are the numbers realistic? | `@biz-strategy certify - why` · `@biz-strategy probe - reality` |
| Evidence strength (grades A–D) | `CONVENTIONS.md` § Evidence grades · `@biz-sources find - <topic>` |
| Decision-loop rules | `CONVENTIONS.md` § Decision loop |
