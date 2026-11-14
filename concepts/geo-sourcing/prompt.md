# Geographic sourcing — playbook

The decision models behind `@biz-career search` (where the jobs are) and `@biz-strategy` Element 4 / channel plan (where the clients are), for an operator whose country of residence is **not** the country of their buyer. The skills hold the procedure; this document holds the method and its evidence. Every market claim names its row in `docs/sources/verified-sources.md` § Geographic sourcing, with grade and date. Where evidence is thin it says so.

This concept exists because the rest of the framework's evidence base is US/UK-centric (OPM, NBER, AER, Ladders). An operator in San José cannot use a US channel table to decide where to spend Tuesday.

---

## 1. The shape of the problem

A cross-border operator is not choosing *whether* to sell abroad. They are choosing **which of three concentric markets to spend their weekly hours in**, and the three have different economics:

| Ring | Who is in it | Typical buyer motive | What the operator competes on |
|------|--------------|----------------------|-------------------------------|
| **Domestic** | Local employers and local businesses | Local presence, local references, local liability | Trust and proximity; usually the smallest pool and the lowest price ceiling |
| **Regional** | The whole language/culture region, remote-eligible | Same-time-zone, same-language delivery at lower cost than the north | Speed of communication, cultural fluency, regional rate norm |
| **Northward / cross-border** | US, Canada, EU buyers hiring remotely or nearshoring | Arbitrage plus time-zone overlap plus risk reduction | Outcome and reliability, **not** price — see §4 |

The mistake this concept exists to prevent: treating the domestic ring as the market because it is the one the operator can see. It is almost always the smallest.

**Measured example (Costa Rica, Nov 2026).** Indeed listed ~115 Costa Rica remote roles against ~8,100–10,600 "Latin America developer remote" listings (catalog § Geographic sourcing, grade A/B, first-party board data). That is roughly **two orders of magnitude**. A search confined to domestic postings is not a smaller version of the same search; it is a different and far weaker strategy.

---

## 2. Size the ring before choosing a channel

Do this in order, with numbers, before any channel enters the plan. Every figure gets a grade.

| Step | Measure | Where it comes from | Grade achievable |
|------|---------|---------------------|------------------|
| 1 | Live openings for the target role **in the operator's country** | Levels.fyi filtered by title + location; Indeed country query | **A/B** — first-party board counts |
| 2 | Live openings for the target role **region-wide, remote-eligible** | Indeed/LinkedIn remote + region query | **A/B** |
| 3 | Named employers who have hired for this role in the country in the last 12 months | Board postings, company career pages, LinkedIn People filter | **A** — observable |
| 4 | Local professional network depth | LinkedIn member count for the role + country | **B** — first-party platform count |
| 5 | The buyer's stated vetting process | Vendor and agency guides, plus the operator's own interviews | **C** — infer, then confirm in calls |

**The ratio between step 1 and step 2 is the decision.** If it is more than about 10x, the domestic ring cannot carry a search or a pipeline on its own and the plan must be built region-wide from the start. Costa Rica's ratio in Nov 2026 was roughly 70–100x.

**Network depth is a referral asset, not a client base.** Costa Rica shows ~16K professional developer LinkedIn accounts (catalog, grade C, vendor-sourced). A pool that size is dense enough that warm introductions travel, and far too small to be a market. Both facts point the same way: **build the network locally, sell regionally and northward.**

---

## 3. Channel classes by ring

A channel enters the plan only with a named route and a weekly hour budget, exactly as BIZ-13 §2 requires. Geography changes which channels are available, not that rule.

| Ring | Channel class | Examples verified for LatAm | Note |
|------|---------------|-----------------------------|------|
| Domestic | Local employers with a regional delivery centre | The multinationals that anchor the local pipeline: Intel, Amazon, HP/HPE, VMware, IBM, Microsoft, Oracle in Costa Rica (catalog, grade C, corroborated across three agency sources) | These hire locally at scale and are the realistic first employer-of-record route |
| Domestic | Local universities and alumni networks | UCR, TEC | Referral source, not a client |
| Regional | LatAm-focused talent platforms | Tecla, Revelo, Howdy, Strider, Lupa, DevSignal, Terminal, BairesDev, Athyna (catalog, grade C — vendor list, unranked, no placement data) | Presence is cheap; being in the pool is not the same as being chosen |
| Regional | Region-specific boards | Torre.ai, lathire.com (LATAM Jobs), RemoteRocketship, Working Nomads, Jobgether | Lower volume, higher intent match |
| Northward | Direct approach to a hiring manager with relevant proof | — | The highest-leverage channel in every ring, and the only one the operator fully controls |
| Northward | Buyer-side review platforms | Clutch, GoodFirms | Where a US buyer shortlists a supplier they have never met. A solo consultant with no Clutch profile is invisible in this motion |
| Both | Personal-profile LinkedIn publishing | see `platforms/linkedin.md` and catalog § LinkedIn distribution | Interest-graph distribution means a post reaches buyers who do not follow you — which is the entire point for a cross-border operator with no local network among buyers |

**Rule.** At least one channel must be in the northward ring, and at least one must be a direct approach rather than a platform listing. A plan made only of platforms rents its pipeline from someone else's ranking.

---

## 4. Positioning against the arbitrage

The buyer's motive for hiring cross-border is cost. That is documented and not in dispute: LatAm senior rates reported at $30–55/hr against $80–150/hr in the US, a 50–65% gap, with 2.6M+ developers in the region (catalog, grade C, vendor with a self-interest in the framing).

**The trap.** Selling on price puts the operator in competition with 2.6M people and a rate floor that keeps dropping. The arbitrage is the buyer's reason to *look* at the region; it cannot be the operator's reason to be *chosen*, because it is not a differentiator the operator owns.

**The reframe, in the form BIZ-10 uses.** Do not sell "same work, cheaper." Sell the constraint the buyer is actually managing:

| Do not sell | Sell instead |
|-------------|--------------|
| Lower hourly rate | Same working hours as your team, so a blocker is a conversation and not a 24-hour round trip |
| "Senior developer" | The specific production system already shipped, with the write-access and risk level it carried |
| English proficiency as a claim | English proficiency as evidence: the buyer's real fear is a mis-scoped requirement, so answer it with a written artefact, not an adjective |
| Availability | A named outcome with a date, and a kill signal the buyer can hold you to |

For a Costa Rica operator the time-zone argument is the strongest single asset and it is *not* price: Costa Rica sits in US Central time, which is why the nearshore literature leads with overlap rather than cost (catalog, grade C, consistent across Auxis, ParallelStaff, Apt). The English-proficiency data is a supporting argument and should be quoted carefully: EF EPI 2025 reports 516 nationally but **604 for IT professionals**, with Heredia 576 and San José 546, and TOEFL iBT 90, second-highest in LatAm. Use the IT-professional figure with its source; the national figure understates the actual delivery population.

---

## 5. Contracting and legal reality

A cross-border offer fails on paperwork more often than on skill. Establish the shape before quoting.

| Question | Why it decides the deal | Costa Rica position (verify before relying) |
|----------|------------------------|----------------------------------------------|
| Employee, contractor, or EOR? | Determines who carries tax, social security and termination risk | **Ley 9738 (2019)** governs voluntary telework and requires it in writing; **Ley 10168 (2022)** adds digital-disconnection rights. Grade **A** for the statutes, **C** for any vendor summary of them |
| What is the employer's landed cost? | A buyer comparing a US hire to a nearshore hire is comparing loaded cost, not salary | Reported ~26.83% employer burden (2026) plus *aguinaldo* (grade C, vendor). Verify against CINDE or CCSS before it appears in a proposal |
| Who invoices whom, in what currency? | Determines the operator's FX exposure and whether the rate is a margin or a hope | — |
| Is there a paid pilot before scale? | The buyer's risk-reduction step; the operator's cheapest proof channel | Reported norm is **2–4 week paid pilots before scaling** (catalog, grade C, AgileEngine). Treat it as the expected shape of a first engagement and price it deliberately, not as a discount |

**Rule.** `@biz-pricing set` must not produce a rate for a cross-border engagement until the contracting shape is known. A rate quoted before the burden and the invoicing path are established is a guess with a currency attached.

---

## 6. What the evidence does not support

1. **Any conversion rate by geography.** No source in the catalog measures how a LatAm-based applicant converts versus a US-based one. The ring choice rests on pool size (grade A/B) and on mechanism, not on a measured conversion differential.
2. **The nearshore growth rate.** "~13% annual digital employment growth" traces to CINDE via an agency page (grade C). Cite CINDE or mark it `directional`.
3. **Salary bands as a quote anchor.** Costa Rica software-engineer bands appear as $54K–$72K, $4,500–7,000/month senior, and $54K–$80K across three vendor sources that do not reconcile. Use Robert Half's employer-verified band where one exists, otherwise quote a range with its source attached.
4. **That a platform listing produces work.** The platform lists in the catalog are vendor-published, unranked, and carry no placement data. Presence is a cheap experiment, not a channel with a known yield — which is exactly what `@biz-market-validate` is for.

---

## 7. How the skills consume this

| Skill | What it takes from here |
|-------|-------------------------|
| `@biz-career search` | §2 ring sizing before the 20–40 target list is built; §3 channel classes; the kill signal must be expressed in conversations per week per ring, not total applications |
| `@biz-career negotiate` | §5 contracting shape must be settled before a number is discussed; §4 reframe is the answer to "why should we pay more than the regional rate" |
| `@biz-strategy` Element 4 (channel plan) | §3 northward requirement; §4 positioning against the arbitrage |
| `@biz-pricing set` | §5 rule — no rate before the contracting shape is known |
| `@biz-market-validate test` | §6.4 — a platform listing is an experiment with an unknown yield, so it gets a value-of-information test, not a forecast |
| `@biz-advisory advise` | §1 three-ring map as the reframe when an operator says "there is no work here" |

---

## Next action

Run §2 for the operator's actual country of residence and role, write the five numbers with their grades into `reference/OPERATOR_PROFILE.md`, and only then build the target list.
