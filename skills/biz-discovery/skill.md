---
name: biz-discovery
description: >-
  Run a discovery call that qualifies the buyer, uncovers their real problem,
  and moves them toward a proposal. biz-discovery run, biz-discovery prepare,
  biz-discovery status.
---

# Skill: biz-discovery — Discovery Call

## Modes

This skill supports three modes via the `biz-discovery` command:

| Mode | Command | Description |
|------|---------|-------------|
| **prepare** | `biz-discovery prepare` | Pre-call checklist: research prospect, pick relevant case study, prepare questions |
| **run** | `biz-discovery run` | Full call structure with 4 phases. Follow-up email within 24 hours. Log to pipeline tracker. |
| **status** | `biz-discovery status` | Read-only state report of discovery pipeline |

**Lead-facing floor (binding).** The 24-hour follow-up email and the call recap are read by a prospect who is deciding whether to keep talking, so `standards/20260621-CONTENT-STANDARD.md` § Lead-facing artifacts binds on both. Run the AI-artifact scan before the recap or follow-up leaves, and report that it ran. A recap that reads as templated tells the prospect they were not actually listened to, which undoes the call. Never describe output as undetectable or AI-proof; § Lead-facing artifacts rule 2 forbids the claim.

---

## I0 — Gate pre-check

Before `prepare` or `run` executes, read `{WORK_BUSINESS_ROOT}/gates.md`. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine. A status of `ACTIVATED`, `NOT ATTEMPTED`, or `NONE` is **not** met.

- If the file does not exist, or `pipeline-ready` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): pipeline-ready not confirmed
  Required state: {WORK_BUSINESS_ROOT}/gates.md with pipeline-ready PASS
  Current state: <what was found>
  To proceed: run `@biz-pricing set`, fill .work.biz/pipeline/outreach-cadence.md
              and the pipeline tracker, then `@biz-review status`
```

Taking a discovery call without a price range and a tracker means improvising on the call and losing the deal record afterward.

- Exception: `status` mode is read-only and runs without the gate.

---

## Mode: prepare — Pre-Call Checklist

**Research basis:** SPIN Selling (Neil Rackham) and BANT are validated sales methodologies. Average B2B sales cycle is 84 days (Prospeo, 2026). Deals closed within 50 days have 47% win rate; deals beyond 50 days drop to 20%.

**Pre-call checklist (tick off before every call):**

- [ ] Re-read the prospect's LinkedIn profile and company website
- [ ] Note what triggered them to have this conversation
- [ ] Prepare 1 specific question about their company or situation
- [ ] Open case study library — which case study is most relevant to them?
- [ ] Check where they are in your pipeline tracker and what you already discussed
- [ ] Have a quiet place, charged laptop, stable internet, camera on
- [ ] Have a glass of water ready
- [ ] Close all other tabs and notifications

**What to have open during the call:**
- Calendar (to schedule follow-up immediately)
- Notes app or document (to capture key points)
- This skill sheet (as reference)
- Case study you selected

---

## Mode: run — Call Structure (30 min call)

### Phase 1: Open (2 min)

Goal: Establish trust and set the frame.

**Structure:**
- Thank them for their time
- Set the agenda: "I'd like to understand your situation first, then if it makes sense, I'll share how I typically approach this kind of project. Sound fair?"
- Start with a broad question: "What's going on that made you want to have this conversation?"

**Rules:**
- Do NOT pitch in the first 5 minutes
- Do NOT interrupt
- Your goal is to listen 80% of this call

---

### Phase 2: Discover (15-20 min)

Goal: Uncover the real problem, the impact, and whether they're serious.

**Use the SPIN framework (adapted for services):**

| Type | Question | Example |
|------|----------|---------|
| **S**ituation | Current state | "How are you handling [problem] today?" |
| **P**roblem | What's wrong | "What's not working with that approach?" |
| **I**mplication | What it costs them | "What's that costing you in time/revenue/risk?" |
| **N**eed-payoff | What success looks like | "If you could wave a magic wand, what would the solution look like?" |

**BANT qualification checklist — capture these:**

- [ ] **B**udget — What budget range are they expecting?
- [ ] **A**uthority — Who else is involved in the decision? Can they make the call?
- [ ] **N**eed — What triggered this conversation now? Have they tried to solve this before?
- [ ] **T**imeline — What's their timeline? Must-have vs nice-to-have?
- [ ] What would success look like in measurable terms?

**Red flags to watch for:**
- "We're just exploring" (no trigger event, no timeline)
- "I need to run this by my partner/board/CTO" (no authority — ask to include them in next call)
- "Can you just give me a ballpark number?" (they're price-shopping, have not described their problem)
- Significantly undersized budget vs. problem scope
- They won't commit to a follow-up meeting
- They're comparing you to a commodity provider

---

### Phase 3: Match (5-10 min)

Goal: Show them you understand their problem and have done this before.

- Summarize what you heard: "So if I understood correctly, you need X because of Y, and the timeline is Z. Is that right?"
- Share a relevant case study or experience: "I worked on a similar situation with [anonymized client]. Here's what we did and what happened."
- Connect the dots: "Your situation is different because [specific detail they shared], but the architecture approach would be similar."
- Do NOT give a price yet. Do NOT commit to a specific scope yet.

**If they push for a price:**
"I can give you a range based on similar projects, but I'd need to understand your specific requirements better before I can give you a real number. Here's what I'd suggest: let me write up a proposal based on what we discussed, with a few options."

---

### Phase 4: Next Steps (3 min)

Goal: Clear, agreed-upon action.

| Outcome | Next Step |
|---------|-----------|
| Strong fit | "I'll send a proposal within 48 hours. It will have 2-3 scope options with pricing. Review it and let's schedule a follow-up to discuss." |
| Needs more info | "Let me schedule a 30-min follow-up to dig into [specific area] before I scope this." |
| Weak fit | "Based on what I'm hearing, I'm not sure I'm the right fit for this. Here's what I'd recommend instead: [referral or alternative approach]." Don't chase bad fits. |
| Not ready | "No pressure. Here's something useful: [link to a case study or article]. If the timing changes, reach out anytime." |

**Always send a follow-up email within 24 hours** summarizing what you heard, what you proposed as next steps, and the case study you referenced.

**Follow-up email template:**
```
Subject: Thanks — summary of our call / [Prospect Name]

Hi [Name],

Thanks for the conversation. Here's my understanding of your situation:

[2-3 sentences summarizing the problem in their words]

The approach I'd recommend:
[2-3 sentences on the proposed approach]

I'll send a proposal within 48 hours with a few options. In the meantime, here's the case study I mentioned:
[Link to relevant case study]

Questions?
Best,

[Your Name]
```

**Customize the template for each prospect.** The summary section is the most important part — it proves you listened. If they correct it, your proposal would have been wrong. Better to get corrected now.

---

### After the Call — Pipeline Logging

- Update pipeline tracker with the new stage
- Note: what's their real urgency (1-5)?
- Note: what's their budget comfort (range, not exact)?
- Note: who else is involved in the decision?
- Note: SPIN answers summary
- Add a follow-up task with a date

---

### After the Call — Gate promotion

`biz-discovery run` owns two gates. Promote only what the call actually evidences.

**`sales-ready`** — promote after the first call where every Success Criteria item below is met and the call is logged in the tracker with BANT captured. One completed call proves the process works end to end; a booked-but-not-held call does not.

```markdown
## sales-ready
**Status:** PASS
**Certified:** {date}
**By:** @biz-discovery run
**Evidence:** `.work.biz/pipeline/pipeline_tracker.md` with at least one completed discovery call logged
**Next gate:** active-deal — advance a qualified deal to Conversation stage or later
```

**`active-deal`** — promote when the call ends at Phase 4 with a "strong fit" or "needs more info" outcome and the deal sits at Conversation stage or later in the tracker. A "weak fit" or "not ready" outcome does **not** promote it.

```markdown
## active-deal
**Status:** PASS
**Certified:** {date}
**By:** @biz-discovery run
**Evidence:** `.work.biz/pipeline/pipeline_tracker.md` with at least one deal at Conversation stage or later
**Next gate:** — run `@biz-proposal write`
```

Replace each section in `{WORK_BUSINESS_ROOT}/gates.md` in place, leaving other gates untouched. When the last active deal closes or dies, demote `active-deal` back to `NOT MET` so `@biz-objections` stops claiming a live deal.

---

## Mode: status — Pipeline Report

Run `biz-discovery status` to view:

- Number of active discovery calls in pipeline
- Stage distribution (Open / Discover / Match / Proposal Sent / Won / Lost)
- Aging: calls stalled > 7 days without follow-up
- Conversion rate: discovery call → proposal sent
- Recent activity log
- Closing per the Operator handoff contract — Form A (`Next: nothing - work complete`) when nothing is needed; otherwise Form B (`**Needs your approval:**` and/or `**Needs your answer:**`, then exactly one `**Next step:**`).

---

## Time Budget

| Phase | Time | Notes |
|-------|------|-------|
| Preparation (pre-call checklist) | 15 min | Research prospect, pick case study |
| Open (2 min) | — | Set agenda |
| Discover (15-20 min) | — | Listen 80% |
| Match (5-10 min) | — | Show understanding, share case study |
| Next Steps (3 min) | — | Clear agreed action |
| Follow-up email | 15 min | Within 24 hours |
| Log in pipeline tracker | 5 min | Update stage + notes |
| **Total per call** | **1 hr** | 30 min call + 30 min prep/post |

---

## Success Criteria

A discovery call is successful when:
- You can summarize their problem in your own words and they agree
- You've identified whether they have Budget, Authority, Need, and Timeline
- You have a clear next step (proposal, follow-up call, or "not a fit")
- You've sent the follow-up email within 24 hours
- You know whether to invest more time or move on

---

## Failure Modes

If discovery calls feel good in the moment but never convert to a proposal stage:

1. **You're not getting enough information.** If you can't summarize their problem clearly after 30 minutes, you didn't ask deep enough questions. Use the SPIN framework more aggressively.
2. **You're not identifying red flags.** Go back through the red flags list. If you ignored one during the call, that's why nothing happens.
3. **The follow-up is too slow.** Send the proposal within 48 hours, not "next week." Momentum dies fast.
4. **The prospect doesn't see enough value.** Your "match" phase may be too focused on what YOU do, not what THEY get. Reframe: "If we solve this, what changes for your business?"
5. **You may be booking calls with unqualified prospects.** Review your pipeline: where did these leads come from? If they're from low-quality sources, your pre-call qualification needs to be more aggressive.
6. **No clear next step agreed on the call.** If the call ends with "let me think about it," you didn't close the Next Steps phase. Always leave with an agreed action.

---

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

---

## Related Files

- `.work.biz/reference/PROJECTS.md` — case studies for credibility (create from `templates/work/reference/PROJECTS.md.template` if missing)
- `.work.biz/pipeline/pipeline_tracker.md` — update pipeline stage
- `.work.biz/gates.md` — read in I0; `sales-ready` and `active-deal` promoted after the call
- `.work.biz/strategy/pricing.md` — price range to reference when they push for a number
- `skills/biz-objections/skill.md` — for when objections come up
- `skills/biz-proposal/skill.md` — for writing the proposal after the call
