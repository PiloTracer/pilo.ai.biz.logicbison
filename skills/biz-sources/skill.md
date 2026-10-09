---
name: biz-sources
description: >-
  Curate and mine business-advisory sources so the operator's advice base keeps
  improving: positioning, pricing, sales, outreach, niche research,
  productized/fractional services, AI-services market. Finds, vets, and
  organizes books, essays, newsletters, communities, market data, and competitor
  artifacts into a living catalog (.work.biz/research/sources.md) with what each
  source is good for and how to mine it. biz-sources find, biz-sources list,
  biz-sources add, biz-sources status.
---

# biz-sources

**Canonical path:** `.ai.biz/skills/biz-sources/skill.md`

Keep the operator's **evidence base** alive. Advice is only as good as what it draws on: this skill finds, vets, and organizes external sources (books, essays, newsletters, communities, market data, competitor artifacts) into a living catalog the other skills mine during their evidence passes — instead of re-searching the web from scratch every time or, worse, advising from memory.

**Evidence-first alignment:** a source enters the catalog only after being checked (it exists, it says what we claim, its date/freshness is known). Unchecked suggestions are marked **Unverified** and never cited as fact until verified.

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-sources find - <topic>` | Research the topic, vet candidates, add the best 3–8 to the catalog with mining notes. |
| `@biz-sources list` | Show the catalog grouped by domain, with freshness flags. |
| `@biz-sources add - <source name or URL> - <domain>` | Add one operator-named source after a verification pass. |
| `@biz-sources status` | Read-only: catalog size, coverage by domain, stale entries. |

**Default:** `list` if no verb matches. A bare topic (`@biz-sources - value pricing`) is treated as `find - <topic>`.

---

## Catalog location

`.work.biz/research/sources.md` in the host project. If missing, create it with this structure (one `## <domain>` section per domain):

```
| Source | Type | What it's good for | How to mine it | Grade | Verified | Freshness |
|--------|------|--------------------|----------------|-------|----------|-----------|
```

**Grade** is the evidence grade the source can support, per `CONVENTIONS.md` § Evidence grades: `A` first-party/primary (the operator's own data, a vendor's own live pricing page, filings) · `B` named third-party research stating method and sample · `C` vendor, consultancy, or media claim; single anecdote · `D` unsourced or undated. Grade the claim the source is being cited for, not the author — a practitioner is `A` on their own numbers and `C` on the market's. A source the framework cannot grade is a source whose claims cannot carry a decision.

Domains (extend as needed): **Positioning & strategy** · **Pricing** · **Sales & outreach** · **Niche & market research** · **Productized / fractional services** · **AI-services market** · **Content & audience** · **Operator craft** (decision-making, writing, negotiation).

---

## I0 — Seed catalog (starting points, not gospel)

Well-known starting points per domain. These are **seeds**: verify each before citing it as evidence in advice (web check + date). Prefer primary artifacts (the author's own page, the live pricing page) over commentary.

- **Positioning & strategy** — April Dunford, *Obviously Awesome* (positioning method); her talks/essays. Good for: niche and reframe work.
- **Pricing** — Blair Enns, *Pricing Creativity*; Jonathan Stark's value-pricing writing. Good for: escaping hourly, fixed-price logic. Cross-check against `standards/*PRICING-STANDARD*` (binding).
- **Sales & outreach** — Blair Enns, *The Win Without Pitching Manifesto*; Josh Braun's outreach writing. Good for: discovery calls, cold outreach that doesn't beg.
- **Niche & market research** — Indie Hackers (operator-reported revenue), First Round Review, Lenny's Newsletter, YC's library. Good for: demand signals, pricing norms, market-entry stories.
- **Productized / fractional services** — live marketplaces and fractional-team providers (e.g. GoFractional; fractional engineering/CXO firms — search current players at research time, the market moves). Good for: proof a purchasing model exists, packaging and price anchors.
- **AI-services market** — current surveys and marketplace data (Upwork/McKinsey/Stanford AI Index as of research date). Good for: "companies pay for AI-assisted delivery" claims — always dated.
- **Operator craft** — Patrick McKenzie's (patio11) essays on running small software businesses. Good for: pricing courage, positioning, sales calls.

Never assert "the standard says X" from memory of this seed list — open the source.

---

## I1 — `find` mode

1. **Frame the need.** Which decision will this source inform? (A source without a consumer question is hoarding.) Note the skill or decision that will use it.
2. **Research.** Web-search the topic; prefer primary sources, recent dates, and sources that state their evidence. Gather 2–3× the final count as candidates.
3. **Vet.** For each candidate: does it exist (fetch the page)? Does it actually say what's claimed? How fresh is it? Who pays the author (bias check)? Cut anything that fails.
4. **Grade it.** Assign the `A`–`D` evidence grade the source can support for the claim it is being kept for (CONVENTIONS § Evidence grades). A catalog of grade-C sources is still useful — it just cannot be the foundation of a decision, and the grade is what stops it from quietly becoming one.
5. **Catalog entry.** Add the best 3–8 with a specific "what it's good for" and "how to mine it" (which chapter/section/search query inside the source answers the need).
6. **Report** what was added, what was rejected and why (honesty over volume), and which domains remain thin.

## I2 — `list` mode

Render the catalog grouped by domain. Flag entries older than **18 months** — and older than **12 months** in fast-moving domains (AI services, platform algorithms, marketplaces) — as **re-verify before citing** (CONVENTIONS § Freshness). Report the grade mix per domain: a domain where every entry is grade C is a domain where decisions are currently resting on marketing.

## I3 — `add` mode

Verify the operator-named source (exists, says what's claimed, freshness, bias), then catalog it. If verification fails, say so and don't add it.

## I4 — `status` mode (read-only)

Report: total entries, per-domain coverage, thin/absent domains relative to the operator's active strategy (loaded per the context contract — `.work.biz/strategy/*`), stale entries. Close per the Operator handoff contract (Form A when nothing is needed; Form B otherwise).

---

## Quality check before delivering

- [ ] Every added entry was actually fetched/checked (no cataloged-from-memory)?
- [ ] Each entry names the decision it serves and how to mine it?
- [ ] Each entry carries an evidence grade (A–D) for the claim it supports?
- [ ] Freshness recorded; stale entries flagged at the right threshold (18 months, 12 in fast-moving domains)?
- [ ] Rejections reported honestly?
- [ ] Claims cross-checked against binding standards where they overlap (pricing, conventions)?

---

## Completion gate

1. Catalog written/updated at `.work.biz/research/sources.md`.
2. Every entry verified or explicitly marked **Unverified**, and graded `A`–`D`.
3. Thin domains reported, with the grade mix per domain.
4. One concrete next step (e.g. "mine the positioning sources for the pending reframe via `@biz-advisory`").

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** the catalog follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists when present; exactly one `## Next action`; no leftover scaffolding).

---

## Time budget

| Mode | Time |
|------|------|
| `find` | 20–40 min per topic |
| `list` / `status` | < 2 min |
| `add` | 5–10 min |

---

## Gates & dependencies

No hard prerequisite gate. Runs any time. Most valuable before evidence-heavy work: `@biz-advisory` (evidence pass), `@biz-ideas` (market claims), `@biz-market-validate` (experiment design), `@biz-pricing set` (price anchors).

## Related skills

| Skill | When |
|-------|------|
| `@biz-advisory` | Consumes the catalog during its evidence pass |
| `@biz-ideas` / `@biz-products` | Ground "why now" and market-size claims |
| `@biz-review monthly` | Re-verify stale catalog entries during assumption re-validation |
