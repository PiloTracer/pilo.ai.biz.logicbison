# NEXT — Tactical Next Actions

## Current Phase

| Phase | Status |
|-------|--------|
| Strategy | Pending (host project); framework amend + gate self-checks shipped |
| Brand | Pending (gated on strategy-ready) |
| Pipeline | Pending |
| Sales | Pending |
| Execution | Multi-platform content layer: canonical voice profile, 9 platform guides, per-platform ops trackers, graded claims, voice convergence |

## Recommended next

1. **First live decision-loop run** — on a real project, `@biz-strategy certify` or `@biz-advisory advise` must append a row to `decisions/DECISIONS.md`, and `@biz-review quarterly` must score it into the Calibration table. This is the one test that decides whether the judgment layer works or becomes another empty artifact (UNKNOWNS #15).
2. **Validate the reality check** (`biz-strategy` certify checks 11–12) on a real strategy — does the arithmetic gate catch a genuinely unviable plan without blocking a viable one on missing data (UNKNOWNS #16).
3. **Retry `future-strategy` close commit/push with the patched biz-session** — its `reasonix.toml` `[sandbox] allow_write` now includes `/mnt/work/Projects/future-strategy/.work.biz` and `/mnt/work/Projects/future-strategy/.git`; uncommitted there: pending `.work.biz` changes + the `reasonix.toml` edit.
4. **Smoke-test `@biz-advisory` on `future-strategy`** against its own feedback case (`.work.biz/feedback/20260820-small-rescue-team.md`) — does a cold run clear the calibration bar (reframe pass, ranked options with precedent, anti-advice, decisive recommendation)? Gaps become new BIZ-10 patterns (UNKNOWNS #12).
5. **Owner review/commit of the remaining uncommitted `future-strategy` changes** — the earlier slim-down plus the thin-client update merge (merged `.cursorrules` with family-path re-point + Source-resolution wiring, `.work.biz` skeleton appends, new `strategy/README.md` + `reference/BRAND_STATUS.md`); its `PATHS.md` still carries stale `/mnt/work/Projects/.ai*` paths.
6. **First `@biz-sources find` run on a live project** — seed `.work.biz/research/sources.md` and confirm both the vetting step and the new A–D grading step hold (UNKNOWNS #13, #17).
7. **Smoke-test `@biz-archive` on a live target** (`future-strategy` once its uncommitted changes land) — `status` dry run, catch-up path for archived pieces missing `status.md`, tracker row removal.
8. **Smoke-test the remaining biz-session verbs on a live target project** — standalone `commit` keeps the session open, `add` stages without committing, `close commit scoped` commits bookend files only; source-role close commit push was exercised 2026-09-10.

## Active tasks

| # | Task | Status | Notes |
|---|------|--------|-------|
| 2 | Owner review of uncommitted `future-strategy` changes | Pending | Consumer repo; slim-down set + today's update merge (.cursorrules, .work.biz appends, 2 new skeletons); PATHS.md stale |
| 5 | Validate Substack + Threads guides against real published output | Pending | Both untested; no project has published to either |
| 6 | Regenerate `.tmp/*.skill` archives | Pending | Include voice profile, Substack/Threads, reconcile, platform tracker, graded claims, content status protocol, biz-archive, biz-advisory, biz-sources |
| 7 | Smoke-test `@biz-strategy amend` + re-certify | Pending | Fold out-of-tree docs; confirm changelog + stale NEXT flags |
| 8 | Verify REPLACE tokens filled for adopter projects | Pending | Pre-existing carry-over |
| 9 | Validate hardened content rules with a live LinkedIn draft | Pending | Compare hook/engagement to `post_01_the_spreadsheet_nobody_owns` |
| 11 | Validate Content Status Protocol on a live target project | Pending | Run publish + `@biz-social log` cycle end-to-end, incl. pillar assignment + VOICE_RETRO entry |
| 13 | Validate `@biz-strategy career` on a live project | Pending | Fill OPERATOR_PROFILE end-to-end; check the cross-check against certified strategy |
| 14 | Validate pillar loop + quarterly alignment on real tracker data | Pending | Needs a project with ≥1 quarter of publishes tagged by pillar |
| 16 | Smoke-test new biz-session verbs on a live project | Pending | Source-role close commit push exercised 2026-09-10 (host-guard patch); target-role standalone commit, add, close commit scoped still unvalidated |
| 18 | Smoke-test `@biz-archive` on a live project | Pending | status dry run; catch-up for archived pieces missing status.md; verify tracker slim + aggregates stay truthful |
| 19 | Owner decision: deletion candidates + full dedup refactor | Pending | Deletion candidates listed in HANDOFF pending #10; dedup tradeoff in UNKNOWNS #11 — needs explicit owner ask before any deletion |
| 21 | Smoke-test registry fill on a live thin-client target | Done 2026-08-21 | `@biz-deploy-basic update` on `future-strategy`: sister tokens resolved at deploy, verifier validated the merged `.cursorrules` (PASS) after the pipefail fix; target's custom standalone layout (no registry rows) reports info-level "custom cell" notes by design |
| 22 | Advisory capability: `@biz-advisory` + `@biz-sources` + BIZ-10 | Done 2026-08-21 | 24th/25th skills; mandatory reframe pass + anti-advice + decisive recommendation calibrated on the rescue-team feedback case; 10-pattern library in `concepts/advisory-patterns/`; source catalog at `.work.biz/research/sources.md` with verify-before-citing seeds; registered across 10 surfaces; v0.6.2 |
| 23 | Smoke-test `@biz-advisory` on a live project | Pending | Calibration run against the rescue-team case (UNKNOWNS #12); gaps feed BIZ-10 |
| 24 | First `@biz-sources find` run on a live project | Pending | Seed + vet the catalog (UNKNOWNS #13) |
| 25 | Retry `future-strategy` close commit/push with patched biz-session | Pending | reasonix.toml sandbox now allows its own .work.biz + .git; pending .work.biz changes + reasonix.toml edit uncommitted there |
| 26 | Validate the decision loop end-to-end on a live project | Pending | certify/advisory appends a row to `decisions/DECISIONS.md`; `@biz-review quarterly` scores it into the Calibration table (UNKNOWNS #15) |
| 27 | Validate the reality check (`biz-strategy` certify 11–12) on a real strategy | Pending | Does the arithmetic gate catch an unviable plan without blocking a viable one on missing data (UNKNOWNS #16) |
| 28 | Validate the A–D evidence ladder in practice | Pending | Discrimination check — does the agent grade below B/C, or does everything collapse to one tier (UNKNOWNS #17) |
| 29 | Tier 2 (deferred 2026-10-09, not started) | Pending | `@biz-market-validate` value-of-information gate + result write-back to `assumption-ledger.md`; retire/upgrade the six orphaned BIZ-01–06 concept stubs; apply the 84-day base rate in `@biz-discovery` |

## Recently completed

| # | What was done | Date |
|---|---------------|------|
| 0 | v0.6.3 judgment-quality layer: decision ledger + calibration loop (`decisions/DECISIONS.md`, CONVENTIONS § Decision loop); reality check — arithmetic + outside view — as `biz-strategy` Element 8 and certify checks 11–13; evidence grades A–D + freshness; load-bearing unknown gate replacing the 30% count; `@biz-director` never-dead-end orchestration + judgment-route disambiguation; framework-verify Decision-loop wiring block; gates green (blast-radius WARN acknowledged, 10 areas) | 2026-10-09 |
| 0 | Evidence-guard hardening: biz-session host-guard preconditions + retry-once shipped (C6b/M5/I5); future-strategy reasonix.toml sandbox allow_write fixed; gates green | 2026-09-10 |
| 0 | v0.6.2: `@biz-advisory` (situational counsel: reframe pass, ranked options with precedent, anti-advice, decisive pick) + `@biz-sources` (advisory-source curation) + BIZ-10 Advisory Patterns; `future-strategy` thin-client update merged + verified; `biz-cursorrules-verify.sh` pipefail fix | 2026-08-21 |
| 0 | `biz-deploy-repo` removed (skill + script + all registry/routing/verifier references) per owner directive; 23 skills remain | 2026-08-19 |
| 0 | v0.6.1: cross-framework sister discovery + Frameworks registry (sister-discovery.sh, deploy fill, verifier checks, framework-verify wiring) + Agent OS root check with ask-user fallback; biz.md gap list resolved | 2026-08-19 |
| 0 | Framework consistency audit + bloat reduction: 9 contradiction/dead-ref fixes, pricing dedup (PRICING-STANDARD + biz-pricing canonical), pre-commit change-safety gates warn-only by default; committed by owner as 33f9547 | 2026-08-19 |
| 0 | biz-session brought to full parity with Agent OS session-control (standalone commit/add/scoped, task-ref + active-ref, secrets scan, checklist reports); routing surfaces synced across 9 files; gates green (blast-radius WARN acknowledged — routing sync) | 2026-08-13 |
| 0 | Content Status Protocol + `@biz-social log`; tracker read/write wired into all four content skills; self-heal rule; staged-aware `blast-radius-check.sh` with real self-test; UNKNOWNS #6 resolved; routing docs synced | 2026-08-10 |
| 0 | v0.6.0: `biz-*` skill id rename across the whole framework; 29-fix consistency sweep (deploy `--update` path doubling, phantom status verbs, Substack/Threads parse rows, one-writer active-deal, unsourced biz-referrals stats); gates green | 2026-08-06 |
| 1 | Canonical VOICE_PROFILE + VOICE_RETRO; Substack + Threads guides; `@biz-social status`; per-platform tracker; `@biz-strategy reconcile`; graded claims; gate-parser fixes; bootstrap/deploy manifest sync; 8 consistency fixes | 2026-07-30 |
| 2 | Strategy amend mode + audience hierarchy + path conventions; gate self-checks on brand/pricing/content; biz-review drift; CONTENT_STATUS template + bootstrap | 2026-07-21 |
| 2 | Harden anti-em-dash and anti-AI-artifact rules across content skills (Content Standard + biz-writing + biz-social + linkedin platform guide) | 2026-07-13 |
| 3 | Tighten LinkedIn quality gates in `biz-writing` skill (specific hook, stakes, credibility, no hidden frameworks) | 2026-07-13 |
| 4 | LinkedIn native video mentor guide + skill integration (`platforms/linkedin-video.md`) | 2026-07-09 |
| 5 | Anti-AI-artifact rules in Content Standard + content skill checklists | 2026-07-09 |
| 6 | Split biz-social into platform guides; canonical topic buckets (BIZ-09) | 2026-07-09 |
