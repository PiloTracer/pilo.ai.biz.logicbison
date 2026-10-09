# HANDOFF — Session Bookmark

> **Date:** 2026-10-09
> **Status:** Closed — 2026-10-09 — judgment-quality layer shipped: decision ledger + calibration loop, reality check (arithmetic + outside view), evidence grades A–D, load-bearing unknown gate, biz-director never-dead-end orchestration

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

## Session summary (2026-09-10, evidence-guard hardening close)

| Step | Status |
|------|--------|
| Investigated thin-client commit/push failures: confirmed "evidence guard" is the Reasonix host write precondition (todo + acceptance criteria + read evidence), not a Business OS feature; repo search + git history clean | Done |
| Patched `skills/biz-session/skill.md`: host-guard preconditions before every git step (re-read HANDOFF/NEXT/UNKNOWNS, active acceptance-criteria todo) + retry-once; wired into C6b, M5, I5, hard rules, anti-patterns | Done |
| Patched `future-strategy/reasonix.toml` `[sandbox] allow_write`: added its own `.work.biz/` and `.git/` (was LogicBison-only, blocking bash git/writes there) | Done |
| Gates: framework-verify PASS (rsync `--no-g` shim for sandbox chgrp), touch-scope PASS (3 files, scope declared), blast-radius PASS (2 areas), gate-verify PASS (n/a) | Done |

---

## Session summary (2026-08-21, advisory capability + future-strategy update close)

| Step | Status |
|------|--------|
| `@biz-deploy-basic update` on `future-strategy`: no-overwrite bootstrap honored; created missing skeletons (`strategy/README.md`, `reference/BRAND_STATUS.md`); flagged `.cursorrules` as merge candidate (custom legacy layout, stale `.ai.biz` refs) | Done |
| Rules-aware merge of `future-strategy/.cursorrules`: all framework primaries re-pointed to verified `pilo.ai.*.logicbison` roots (biz/ai/ui/cto/mlt), Source-resolution section + `AGENT_OS_SOURCE` added, Change-safety / Protected Files / Data-loss / Verification sections added, Business OS skills table refreshed; LogicBison identity, rebranding context, CTO/MLT sections, fallback column preserved | Done |
| `.work.biz` skeleton merge (13 files, append-only): gates.md `## Schema`, HANDOFF Pending/Key-decisions skeletons, VOICE_RETRO Trend/edit-classes added; 10 files already equivalent; user content preserved | Done |
| Fixed `biz-cursorrules-verify.sh` pipefail abort (Agent OS cell grep pipeline missing `|| true` — exited 1 mid-run on any custom `.cursorrules`); post-deploy verification of future-strategy now PASS | Done |
| New skill `@biz-advisory` (24th): situational counsel protocol — context contract, mandatory reframe pass (≥2 "don't sell X — sell Y" reframes), ≥5 ranked options with researched market precedent, mandatory anti-advice, parallel-track sequencing + 30-day frame, decisive recommendation, assumption ledger; calibrated against `future-strategy/.work.biz/feedback/20260820-small-rescue-team.md` | Done |
| BIZ-10 Advisory Patterns (`concepts/advisory-patterns/`): 10 generalized judgment patterns (team-as-product, productized entry offer, trigger-based demand, anchor channel, complementor channel, dual-track hedging, customers-before-company, modular configurations, control-layer positioning, outcome-over-people) | Done |
| New skill `@biz-sources` (25th): curates advisory sources into `.work.biz/research/sources.md` — vet (exists / says-what's-claimed / freshness / bias) or mark Unverified; verify-before-citing seed catalog (Dunford, Enns, Stark, patio11, Indie Hackers, First Round Review, Lenny's, fractional-services marketplaces) | Done |
| Registration across 10 surfaces: skills/README (+ `advise`/`patterns`/`list` verbs), SKILL_DEPENDENCIES (ungated counsel skills), biz-director intents, START_HERE (tree + table), PROCESS_ROUTER, .cursorrules + template, README (25 skills), concepts/README (BIZ-10), CHANGELOG v0.6.2, framework-verify DOC_GENERATING | Done |
| Gates: touch-scope PASS (16 files), blast-radius PASS, gate-verify PASS (n/a), framework-verify all green (25 skills, 15 doc-generating) | Done |

---

## Session summary (2026-08-19, homogenization + v0.6.1 close)

| Step | Status |
|------|--------|
| Verified uncommitted homogenization changeset against `docs/homogenization/biz.md`: sister-discovery.sh, 7-row Frameworks registry in .cursorrules + template, deploy fill, verifier cell checks, framework-verify wiring — all faithful | Done |
| Deploy smoke `/tmp/smoke-biz`: 5 sister tokens filled at deploy time, target verifier PASS | Done |
| Gap list resolved: F2 (`--self-test` present; source-repo run PASSes via new `source` layout), F1 (NEXT template has `## Next action`), stale tmp artifacts gone, `reasonix.toml` allow-list reset (rename-era one-offs) | Done |
| Agent OS root check (owner directive): `agent_os_names`/`find_agent_os_dir` in sister-discovery.sh (family root `pilo.ai.logicbison` preferred, legacy `../.ai` fallback; neither → ask the operator, never guess); template `.ai` row now `REPLACE:AI_PATH`; deploy fills it; verifier validates the filled cell (STALE = FAIL) | Done |
| Gates: framework-verify PASS (incl. new registry wiring + AI_PATH token), touch-scope PASS, gate-verify PASS (n/a), blast-radius WARN (acknowledged) | Done |
| biz.md updated: gaps marked resolved, checklist ticked | Done |
| Release v0.6.1: CHANGELOG cut, tag, GitHub release | Done |

---

## Session summary (2026-08-19, consistency audit close)

| Step | Status |
|------|--------|
| Audited today's commits (087981f, dd4531e) + framework-wide: two deep audits (skills; knowledgebase/standards/templates) + spot-checks of every finding | Done |
| Fixed contradictions/dead refs: active-deal one-writer (BUSINESS-CONVENTIONS), README 23→24, CONVENTIONS phase chain, README `strategy_*.md` path, CHANGELOG duplicate headings, false PROTECTED_SURFACES.json claim, biz-director deploy-basic routing + strategy glob, stale `.work.biz/README` + `prompts/README` | Done |
| Pricing dedup (low-risk, owner-approved): PRICING-STANDARD gains reduce-scope rule; retainer table moved to `biz-pricing` § Post-Delivery Offers; `biz-proposal` points at both | Done |
| `hooks/pre-commit` change-safety gates warn-only by default (owner request: commit/push without blockers); `GATES_ENFORCE=1` restores blocking; tracking hooks unchanged; `.cursorrules` + CHANGELOG documented | Done |
| Context budget slim: older session blocks (07-30, 07-21) moved to `HANDOFF.archive.md` | Done |
| All 14 session files committed + pushed by owner as `33f9547` | Done |
| Gates: touch-scope PASS, framework-verify PASS, gate-verify PASS (n/a) | Done |

---

> Older session summaries (2026-08-19 close and earlier) moved to `context/HANDOFF.archive.md` (Context budget).

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
| 9 | Delete or refresh `.work.biz/touch-scope` when not in a scoped edit session | Low |
| 10 | Owner decision: deletion candidates (`.work.biz/prompts/20260814-marker-detection-deploy-repo-removal-audit.md` — `.ai`-only; `docs/adoption/FROM_AGENT_OS.md` + `docs/guides/workflows/README.md` stubs; `examples/`; stale `.tmp/*.skill`) | Low |
| 11 | Full dedup refactor: shared publishing-ops skeleton (biz-content/biz-youtube) + I0 context contract (biz-writing/biz-social) — portability tradeoff (UNKNOWNS #11) | Low |

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

---

## Quick reference

| Need to... | Read / Run |
|------------|-----------|
| What to do next | `.work.biz/plans/NEXT.md` |
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
