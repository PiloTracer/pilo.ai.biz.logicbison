# Skill Dependencies & Prerequisite Gates

## Gate Graph

```
biz-bootstrap init
       │
       │  (scaffold only — no gates)
       ▼
biz-strategy greenfield
       │
       │  Produces: strategy-ready (certified by @biz-strategy certify)
       ▼
biz-strategy certify
       │
       │  Gate: strategy-ready must be certified
       ▼
biz-brand audit / overhaul
       │
       │  Produces: brand-ready (strategy-certified + brand overhaul complete)
       ▼
biz-pricing set  ← requires strategy-ready
       │
biz-content publish  ← requires brand-ready (brand assets exist)
biz-youtube publish/plan/challenge ← no hard gate; benefits from brand-ready + strategy-ready
biz-community find/status ← no hard gate
biz-community engage ← requires brand-ready
biz-social write ← no hard gate (improves with strategy-ready; best after @biz-community find)
biz-social research ← no hard gate (improves with strategy-ready)
biz-social repurpose ← no hard gate
biz-social icp ← no hard gate (improves with strategy-ready; produces linkedin-icp.md)
biz-social strategy ← requires strategy-ready
biz-social plan ← requires strategy-ready
biz-archive run/status ← no hard gate (requires CONTENT_STATUS.md with published rows)
        │
        ▼
biz-discovery run  ← requires pipeline-ready; promotes sales-ready + active-deal
biz-proposal write ← requires pipeline-ready (pricing set)
biz-objections handle ← requires active-deal (roleplay is ungated)
biz-referrals ask  ← no strict gate (can start anytime)
       │
       │
├── biz-review weekly  ← requires at least one strategy doc
        ├── biz-market-validate test ← can run at any time (recommended before committing to a strategy)
        ├── biz-pipeline-diagnosis run ← requires pipeline tracker with data
        │
         │  ── Generative skills (no hard gate; run any time) ──
         ├── biz-writing write/plan/repurpose/audit ← run any time (improves with strategy-ready + brand-ready)
         ├── biz-social write/research/repurpose/icp ← run any time (improves with strategy-ready; best after @biz-community find)
         ├── biz-ideas generate/stress/pivot ← run any time (improves with strategy-ready)
         ├── biz-products generate/extend/scope/audit ← run any time (improves with strategy-ready)
         ├── biz-advisory advise/patterns ← run any time (improves with strategy-ready + operator profile)
         └── biz-sources find/list/add ← run any time
```

### Generative skills (no gate)

`biz-writing`, `biz-social`, `biz-ideas`, and `biz-products` are **project-aware generative skills**: they have **no prerequisite gate** for `write`, `research`, `repurpose`, and `audit` modes and can be invoked at any time, even before `biz-bootstrap init`. They load the host project's own context dynamically (`.cursorrules`, `.work.biz/strategy/*`, `README.md`, stack manifests) and fall back to a bundled example profile when none exists. They produce dramatically better output when the host project is bootstrapped and strategy-certified, because audience, offer, stack, and channel are then loaded from project memory rather than guessed.

### Career skill (no gate)

`biz-career` (`search`, `resume`, `interview`, `negotiate`, `status`) covers the **employment** side of the operator's market: role archetypes and a channel plan with a capacity check, a 20–40 company target list with a route per row, CV/resume elaboration restricted to evidenced scope, an interview story bank anchored to resume bullets, and offer evaluation. It has no prerequisite gate; it improves sharply with a filled `reference/OPERATOR_PROFILE.md` (written by `@biz-strategy career`) and hands off to `@biz-brand` (public profile), `@biz-strategy career` (direction), or `@biz-advisory` (a life fork with no obvious answer). It promotes no gate and never fabricates a number, title, date, or credential — a bullet that cannot be traced to evidence is listed as a gap, not written.

### Advisory & sources skills (no gate)

`biz-advisory` (`advise`, `patterns`, `status`) and `biz-sources` (`find`, `list`, `add`, `status`) are **counsel skills** with no prerequisite gate. `biz-advisory` answers situational "what should I do?" questions (reframe pass, ranked options, evidence, anti-advice, decisive recommendation); it improves with strategy-ready and a filled `reference/OPERATOR_PROFILE.md`, and hands off to `biz-strategy` / `biz-market-validate` once a direction is chosen — it never moves gates itself. `biz-sources` curates the advisory-source catalog at `.work.biz/research/sources.md` that feeds the evidence passes of other skills.

### Content-lifecycle utility (no gate)

`biz-archive` (`run`, `status`) moves published content pieces from `.work.biz/ideas/` to `.work.biz/ideas.archive/` per the Archive rule in `CONVENTIONS.md` § Content Status Protocol. It has no prerequisite gate but does useful work only when `reference/CONTENT_STATUS.md` has `published` rows. It never commits, pushes, or deletes; committing staged renames is the owner's call.

## System skills (no gate)

`biz-deploy-basic`, `biz-deploy-files`, and `biz-session` are **infrastructure skills** with no prerequisite gate. They can be invoked at any time to manage Business OS deployment, update, and session lifecycle (`@biz-session start` / `@biz-session close` / `@biz-session context`; `close commit [scoped] [push]` for close-time git; standalone `@biz-session commit` / `commit push` / `add` checkpoint without closing — scope `.work.biz/` in target projects, repo-wide in the source repo). Deployment skills do not interact with the business gate graph. `biz-session` is aliased as `session-control` (`@session-control start`, `@session-control context`, etc.).

## biz-director (meta-skill)

`biz-director` is the universal orchestrator. It has no gate itself — it can be invoked at any time. It reads project state and routes to the appropriate skill, checking that skill's prerequisites before executing.

---

## Gate Descriptions

`{WORK_BUSINESS_ROOT}/gates.md` is the single authoritative ledger of which gates are met. It is created by `@biz-bootstrap init` from `templates/work/gates.md.template` with every gate at `NOT MET`.

**Reading rule.** A gate counts as met only when its `**Status:**` value *starts with* the word `PASS`. Trailing commentary is expected in real ledgers and does not change the verdict, so `**Status:** PASS 2026-07-25 - verified live` is met. `NOT MET`, `NOT ATTEMPTED`, `ACTIVATED`, `NONE`, `FAIL`, `BLOCKED`, a missing `Status` line, and a missing section are all not met. Gate ids match on a normalized form, so `## active deal` resolves to `active-deal`. Projects may add their own extra sections; nothing reads those as gates.

| Gate | State (ledger id) | Evidence | Promoted by (only writer) |
|------|-------------------|----------|---------------------------|
| — | scaffold | `.work.biz/` exists (no ledger entry) | `@biz-bootstrap init` |
| 1 | `strategy-ready` | `.work.biz/strategy/certification.md` | `@biz-strategy certify` |
| 2 | `brand-ready` | `.work.biz/reference/BRAND_STATUS.md` overhaul log with a passing five-second test | `@biz-brand overhaul` |
| 3 | `pipeline-ready` | `.work.biz/strategy/pricing.md` + `.work.biz/pipeline/pipeline_tracker.md` + `.work.biz/pipeline/outreach-cadence.md` | `@biz-review status` |
| 4 | `sales-ready` | Pipeline tracker with a completed discovery call logged | `@biz-discovery run` |
| 5 | `active-deal` | Pipeline tracker with a deal at Conversation stage or later | `@biz-discovery run` |

**Two-layer enforcement.** Every gated skill self-verifies the ledger in its own I0 pre-check, and `biz-director` checks it before routing. Neither layer is the only one.

| Skill | Gate its I0 enforces | Ungated modes |
|-------|---------------------|---------------|
| `biz-brand` | `strategy-ready` | `status` |
| `biz-pricing` | `strategy-ready` | `status` |
| `biz-content` | `strategy-ready` then `brand-ready` | `status` |
| `biz-community` | `brand-ready` (`engage` only) | `find`, `status` |
| `biz-discovery` | `pipeline-ready` | `status` |
| `biz-proposal` | `pipeline-ready` | `status` |
| `biz-objections` | `active-deal` (`handle` only) | `roleplay`, `status` |
| `biz-social` | `strategy-ready` (`strategy`, `plan` only) | `write`, `research`, `repurpose`, `icp`, `log`, `status` |
| `biz-archive` | — (no gate) | `run`, `status` |

**Demotion.** A gate that no longer holds must be demoted, not left as a stale PASS. `@biz-strategy amend` demotes `strategy-ready` and cascades to `brand-ready`, `pipeline-ready`, and `sales-ready`. `@biz-review status` reconciles the whole ledger and demotes any gate whose evidence is missing. `scripts/gate-verify.sh` fails the build when a PASS lacks its evidence.

## Blocked Report Shape

When a skill stops because a prerequisite gate is not met:

```text
BLOCKED (prerequisite): <gate description>
  Required state: <state>
  Current state: <current state>
  To proceed: <command to run next>
```

---

## Operator handoff contract

Every operator-facing response that completes a task must close so the
operator can see — without asking — what, if anything, they must do next.
Every `skills/<id>/skill.md` references this contract, and every
operator-facing report template closes with Form A or Form B.

1. **Terse output.** Report only what changed and what's needed next. No
   restating the task, no filler, no unrequested rationale.
2. **Approvals** go under `**Needs your approval:**` as a numbered list —
   one decision per item, each citing the exact `path:L<n>` to review.
3. **Questions** go under `**Needs your answer:**` as their own numbered
   list — each self-contained, never mixed with decisions.
4. **Exactly one `**Next step:**`** — the immediate command or action in the
   exact syntax to run/type. If several sequential actions exist, present
   only the immediate one.
5. **Form A (nothing needed):** close with a single line, e.g.
   `Next: nothing - work complete`. Do not render empty sections.
6. **Form B (input needed):** `**Needs your approval:**` and/or
   `**Needs your answer:**`, then `**Next step:**`. Omit any section that
   has nothing in it.
7. Report-template sections ("Follow-ups", "Remaining", "Recommended next")
   never substitute for this close — any operator-required approval or
   question inside them must also appear in the labeled closing sections.

Enforcement: `scripts/framework-verify.sh` hard-fails when a skill.md does
not reference this contract.

---

## Document clarity contract

Every generated document (plan, strategy doc, proposal, draft, report,
review, validation log) must make it immediately obvious what it is, what
state it is in, and what — if anything — the reader must do next. Every
doc-generating `skill.md` references this contract.

1. **Status/Needs header (≤4 lines).** Every document opens with:
   - **What** this is (one sentence).
   - **Status** — `Draft` | `In review` | `Approved` | `Superseded` (+ date).
   - **Needs** — one line: the decision or review required, or `none`.
2. **Brevity.** No boilerplate or filler; every section informs a decision
   or an action; the first 5 lines carry the gist.
3. **Exact references.** Claims cite `path:L<n>` (repo-relative);
   quantitative claims are tagged `measured` | `estimated` | `assumption` |
   `unknown`.
4. **Decisions and Open questions in separate lists.** Numbered, each
   self-contained, never mixed, never buried in prose.
5. **Exactly one `## Next action`.** Documents that require follow-through
   end with a `## Next action` section holding one action in the exact
   syntax to run/type. If nothing is needed, one line instead:
   `Next action: none — <reason>`.
6. **No leftover scaffolding.** `REPLACE:*` tokens and instructional
   comments must be stripped or filled before a document is presented as
   complete. Never render an empty or placeholder section.

Enforcement: `scripts/framework-verify.sh` hard-fails when a doc-generating
skill.md does not reference this contract.
