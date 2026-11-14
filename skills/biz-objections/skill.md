---
name: biz-objections
description: >-
  Respond to common sales objections with empathy, evidence, and a path
  forward — without discounting or defending.
  biz-objections handle, biz-objections roleplay, biz-objections status.
---

# Skill: biz-objections — Handle Sales Objections

## Purpose
Objections are not rejections. They're questions the prospect needs answered before they can buy. This skill gives you responses for the 7 most common objections in high-ticket services, organized by the psychology behind them.

## Core Principles

- **Never defend.** The moment you defend your price or approach, you've lost. Instead, get curious.
- **Never discount on the first objection.** Discounting trains the client to object more. Address the concern first.
- **Objections are about one of three things:** Value (don't see the ROI), Trust (don't believe you can deliver), or Risk (afraid of making a bad decision). Identify which one before responding.

**Lead-facing floor (binding).** When an objection response is delivered in writing rather than spoken — an email, a proposal addendum, a message thread — `standards/20260621-CONTENT-STANDARD.md` § Lead-facing artifacts binds on it. Run the AI-artifact scan before it is sent and report that it ran. This matters more here than elsewhere: an objection is a trust moment, and a scripted-sounding answer confirms the buyer's suspicion rather than answering it. Never describe output as undetectable or AI-proof; § Lead-facing artifacts rule 2 forbids the claim.

## Modes

### handle
Identify objection type (Value/Trust/Risk), choose response from the 7 common objections. Core principles: never defend, never discount first, objections are about Value/Trust/Risk.

### roleplay
Practice responding to objections. The user plays the prospect, the AI plays the seller (or vice versa). Use the 7 objections as scenarios.

### status
Track objection patterns. Summarize recent objections encountered, categorize by type (Value/Trust/Risk), and suggest adjustments to positioning or discovery.

## I0 — Gate pre-check

Before `handle` executes, read `{WORK_BUSINESS_ROOT}/gates.md`. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine. Gate ids normalize, so a `## active deal` heading resolves to `active-deal`.

- If the file does not exist, or `active-deal` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): no active deal
  Required state: {WORK_BUSINESS_ROOT}/gates.md with active-deal PASS
  Current state: <what was found>
  To proceed: run `@biz-discovery run` to qualify a deal, or use
              `@biz-objections roleplay` to practice without a live deal
```

Handling an objection needs the specific deal's context: what they said, their budget signal, who else decides. Without it the response is generic and unusable.

- Exception: `roleplay` and `status` run without the gate. `roleplay` exists precisely for practice before a real deal.

## The 7 Common Objections

### 1. "That's more than I expected / That's expensive"

**Psychology:** They don't yet see the value, or they're comparing you to a freelancer.

**Response (4-step):**

1. **Acknowledge + Validate:** "I hear you. It's a significant investment. Let me explain why it's priced that way."
2. **Reframe to value, not cost:** "The last project like this cost the client [specific cost of NOT doing it — lost revenue, compliance risk, wasted team time]. Compared to that, the engagement pays for itself if it [solves that specific problem]."
3. **Reference your differentiator:** "The reason I charge a fixed price instead of hourly is that I'm selling you an outcome, not my time. I take the risk of scope surprises. A freelancer charges by the hour and the risk is on you."
4. **Offer options, not discounts:** "If the full scope is too much right now, here's an alternative: a Phase 1 that solves the most critical piece for [lower price]. We can always expand later."

**Phrases to avoid:** "I can do it for X instead" (discounting without addressing the concern), "But my rate is reasonable" (defensive), "Let me see what I can do" (weak).

### 2. "I need to think about it / Let me get back to you"

**Psychology:** They're uncertain, overwhelmed, or avoiding a hard decision. "Think about it" almost always means "No" unless you help them through it.

**Response:**

1. **Get specific:** "Totally fair. Can I ask what specifically you need to think through? Sometimes it helps to talk it out."
2. **Name the real objection:** "Often when people say that, it's one of three things: budget, timing, or confidence in the approach. Which one resonates most?"
3. **Reduce the decision weight:** "What if we start with a paid 2-week discovery phase — $X — and by the end you'll have a clear scope and price for the full build. No commitment beyond that."
4. **Set a follow-up:** "When should I check back in with you? I'll send a calendar reminder now so neither of us forgets."

### 3. "Can you show me similar work / Do you have case studies?"

**Psychology:** They need proof you can deliver. This is healthy — they're qualifying you seriously.

**Response:**

1. **Yes, always.** "Absolutely. I have several. Let me share the most relevant one."
2. **Reference the most relevant project from `.work.biz/reference/PROJECTS.md`** (create from `templates/work/reference/PROJECTS.md.template` if missing) that matches their industry or problem type.
3. **Tell the story, don't just send a link:** "One client needed [problem]. I built [solution] using [tech]. It took [timeframe]. The result was [outcome]. Here's the case study."
4. **If you don't have an exact match:** "I haven't built exactly that, but here's something similar: [related project]. The architecture pattern is the same — the domain logic changes."

**Don't lie or exaggerate.** If you don't have a case study, say "This is the kind of project I'm looking to do more of." Honesty about limits is itself a trust signal.

### 4. "We're not ready yet / Timing isn't right"

**Psychology:** No urgency, or the pain isn't acute enough.

**Response:**

1. **Test if it's real:** "What would need to change for the timing to be right?"
2. **If it's budget timing:** "When does your next budget cycle open?"
3. **If it's priority:** "If the problem isn't urgent enough yet, that's fine. Let me stay on your radar."
4. **Leave value behind:** "No problem. I'll send you a link to the AIDA case study — it gives a sense of how I approach these projects. If the timing shifts, reach out."
5. **Add to nurture sequence:** Move them to a 30-day follow-up in your pipeline tracker. Send a useful article or case study once a month. Stay top-of-mind without being pushy.

### 5. "We're talking to other people / We need to compare"

**Psychology:** They're risk-averse and want to validate your price/approach against alternatives.

**Response:**

1. **Lean in:** "Great — you should. I'd do the same. Can I ask who else you're considering?"
2. **If they name a specific competitor or alternative:** Acknowledge it neutrally. "They do good work. Here's what I'd consider when comparing us: [your differentiator — e.g., fixed price, you're the single point of contact, your specific architecture experience]."
3. **Offer to help them evaluate:** "If it helps, I can give you a few questions to ask any provider. Things like how they handle scope changes, what their delivery guarantee is, how communication works."
4. **Set a deadline (optional):** "I'll keep my proposal open until [date 2 weeks out]. After that my calendar starts filling and I'd need to re-scope based on availability."

### 6. "We're going to build it in-house"

**Psychology:** They think hiring a team or training existing staff is cheaper than outsourcing. They may also want to keep the IP/internal knowledge.

**Response:**

1. **Validate the instinct:** "That makes sense. Building in-house gives you more control. Let me share what I've seen happen in practice."
2. **Name the hidden costs:**
   - "The cost isn't just salaries — it's the 3-6 months for a new team to ramp up on your domain"
   - "It's the architecture decisions made by people who haven't made them before — technical debt that costs 10x to fix later"
   - "It's the opportunity cost of your team maintaining vs. building your product"
3. **Offer the hybrid model:** "What if I handle the architecture and build the foundation (3-4 weeks), then your team takes over the ongoing features? You get the architecture right without a long-term commitment."
4. **If they're determined:** "Fair enough. If you ever need a senior hand on deck for architecture reviews or tough problems, I'm here. That's a smaller engagement — $3k-$5k for a focused sprint."

### 7. "We need a full team, not one person"

**Psychology:** They assume one person can't deliver what a team can. They're comparing you to an agency with 5-10 people.

**Response:**

1. **Acknowledge the concern:** "I understand the concern. Most people who say that assume one person is slower or less capable. Here's the reality of what I deliver vs. a team:"
2. **Flip their frame:**
   - "In my experience, a team of 5 spends significant time in meetings and handoffs — I've found that I spend less than 5% on overhead. The rest is building."
   - "I've been building platforms for 36 years. I make decisions in hours that a junior team would debate for days."
   - "I deliver faster than a team of 3 because I don't have to coordinate. I just build."
3. **Reference your portfolio:** "I built [AIDA/Teleprompter] solo in 7 months. A typical agency would charge 3x for the same outcome."
4. **Offer a small bet:** "Let me prove it. A 2-week paid sprint — $X — and you'll see what I can deliver. If you're not impressed, you're out nothing."

## Objection Flowchart (Quick Reference)

```
Objection comes up
├─ Is it about VALUE? (They don't see ROI)
│   └─ Reframe to value, not cost. Show the cost of NOT solving it.
├─ Is it about TRUST? (They're not sure you can deliver)
│   └─ Share relevant case study. Offer small paid diagnostic.
├─ Is it about RISK? (Afraid of making a bad decision)
│   └─ Reduce commitment size. Offer Phase 1 only. Set proposal deadline.
└─ Can't tell which?
    └─ Get curious: "Help me understand — is this more about budget, timing, or confidence in the approach?"
```

## When the Objection Is Real (Not Just a Test)

Sometimes the objection is valid. The budget genuinely isn't there. The timing is genuinely bad. Their need is genuinely different from what you offer.

**In those cases:**
- Don't push. Don't discount. Don't chase.
- Leave the door open: "I understand. If things change, I'm here."
- Ask for a referral: "No hard feelings. If you know anyone else who has this problem, I'd appreciate an introduction."
- Move them to the "Nurture" stage in your pipeline tracker. Follow up in 60-90 days non-pushily.

## Failure Mode: "I keep getting the same objection and can't get past it"

If the same objection comes up in every conversation:
1. **It's not an objection — it's a gap in your positioning.** If everyone says "we need a team, not one person", your messaging is setting the wrong expectation. Reframe your offer as delivering outcomes, not hours.
2. **Your discovery call may be skipping qualification.** If you're constantly getting "it's too expensive", you're talking to people who can't afford you. Screen for budget earlier.
3. **Write a preemptive answer into your LinkedIn About section and website.** If the objection is so common you know it's coming, address it before they ask: "One person? Yes. 36 years of experience means I deliver faster than most teams of 3."

## Time Budget

| Step | Time | Notes |
|------|------|-------|
| Identify objection type | In the moment | Value vs. Trust vs. Risk (see flowchart) |
| Choose response | In the moment | Reference the 7 objections above |
| Deliver response | 1-3 min | Stay calm, don't defend |
| Confirm resolution | 30 sec | "Does that address your concern?" |
| **Total per objection** | **2-5 min** | Most objections resolve in one exchange |

## Success Criteria

An objection is handled well when:
- The conversation continues (they don't end the call or go dark)
- You did NOT discount, defend, or get emotional
- They either agree to move forward or you gave them a clear off-ramp
- You know whether the objection was resolved or it's a genuine dead end

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

## Related Files

- `.work.biz/strategy/one-pager.md` (unified offer — ground responses in the real offer)
- `.work.biz/strategy/offer-scope.md` (what the offer IS / IS NOT)
- `.work.biz/reference/PROJECTS.md` (case study references for the "similar work" objection; create from `templates/work/reference/PROJECTS.md.template` if missing)
- `skills/biz-discovery/skill.md` (precedes objections — better discovery means fewer objections)
- `skills/biz-pricing/skill.md` (for the pricing objection specifically)

## Status Tracking

> Current status recorded in `.work.biz/pipeline/pipeline_tracker.md`.

| Field | Status |
|-------|--------|
| Current state | Pending |
| Last input received | — |
| Last update date | — |
| Notes | — |
| Next step | Activate in Phase 3 when objection arises |
