---
name: biz-content
description: >-
  Write and publish content that demonstrates expertise and attracts inbound
  leads. Supports LinkedIn posts, articles, native video, 30-day challenges,
  and repurposing.
  biz-content publish, biz-content plan, biz-content challenge, biz-content status.
---

# Skill: biz-content

## Purpose
Write and publish one piece of content (LinkedIn post, article, or native video) that demonstrates your expertise and attracts inbound leads. No pitching. No "DM me."

> **Platform scope:** This skill covers LinkedIn publishing ops (tracker, calendar, engagement cadence, A/B hook testing, consistency challenges, native video workflows). For generating content calibrated to other platforms (Reddit, Instagram, Facebook), use `@biz-social`. For pure writing craft (blog articles, case studies, landing pages, email sequences), use `@biz-writing`. For drafts, invoke `@biz-social write linkedin`, `write linkedin carousel`, or `write linkedin video` after planning.

## I0 - Gate pre-check

Before any mode executes, read `{WORK_BUSINESS_ROOT}/gates.md`. This skill's gate is **brand-ready**: publishing drives traffic to a profile and website, so those surfaces must already match the offer or the content converts into a dead end. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine and does not change the verdict.

- If the file does not exist, or `strategy-ready` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): strategy-ready not certified
  Required state: {WORK_BUSINESS_ROOT}/gates.md with strategy-ready PASS
  Current state: <what was found>
  To proceed: run `@biz-strategy greenfield` then `@biz-strategy certify`
```

- Else if `brand-ready` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): brand-ready not confirmed
  Required state: {WORK_BUSINESS_ROOT}/gates.md with brand-ready PASS
  Current state: <what was found>
  To proceed: run `@biz-brand audit` then `@biz-brand overhaul`
```

- Exception: `status` mode is read-only and runs without the gate.

This check applies to `publish`, `plan`, and `challenge` modes (`status` exempt). To draft content before brand-ready, use the ungated `@biz-writing` or `@biz-social write` instead.

## I0b - Voice profile (binding when present)

Read `.work.biz/reference/VOICE_PROFILE.md` before drafting or reviewing any copy. If absent, check `.work.biz/ideas/VOICE_STANDARD.md`, `.work.biz/reference/VOICE_STANDARD.md`, and `.work.biz/reference/voice-profile.md`.

The Content Standard's anti-AI-artifact rules are the floor and always bind (zero em-dashes and en-dashes). The voice profile governs tone, rhythm, structure, and vocabulary above that floor, and its **texture** rules are deliberate: do not normalize them into polished prose. If it lists a **reference sample** for the format you are producing, read it and match its rhythm. If it makes an **owner pass** mandatory, label the output a draft and say so in the delivery.

Report which voice source you loaded, or state plainly that none exists and the output will be generically human. A profile that is still a skeleton (`<` placeholders remain, no reference sample filled) counts as none: warn plainly, because an unfilled profile adds a step without adding value (CONVENTIONS § Voice loop).

## I0c - Operator proof (read before drafting)

Read `.work.biz/reference/OPERATOR_PROFILE.md` and `.work.biz/reference/PROJECTS.md` if they exist. The profile bounds what the author can credibly claim; the bank supplies the numbers and named results. Draw every concrete result from `PROJECTS.md` and respect its disclosure status. A skeleton profile (full of `<` placeholders) or an empty bank counts as missing: say so in the delivery note, because content without real proof points is generic by construction.

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-content publish` | Run the publish workflow (topic → draft → review → post → engage) |
| `@biz-content plan` | Seasonal calendar + batch scheduling |
| `@biz-content challenge` | 30-day LinkedIn consistency plan (default) |
| `@biz-content challenge - createimpact` | Same plan framed for LinkedIn #CreateImpact |
| `@biz-content challenge - 30d linkedin` | Explicit 30-day LinkedIn challenge |
| `@biz-content challenge - video` | 30-day LinkedIn native video challenge |
| `@biz-content status` | Content performance tracker review |

**Default:** `publish` if no verb matches and the user wants to create/post content now.

---

## Mode: publish — Write and post one piece

### 0. Load the content status tracker

Read `.work.biz/reference/CONTENT_STATUS.md`. If it does not exist, create it from `templates/work/reference/CONTENT_STATUS.md.template` before proceeding (self-heal rule, see CONVENTIONS § Content Status Protocol).

- Never pick a topic already marked `published` for LinkedIn.
- If pieces are marked `ready` or `draft`, prefer publishing or finishing one of them over starting a new piece. Say which one you are advancing.

### 1. Choose Topic

Pick from one of the four canonical topic buckets in `concepts/content-topic-buckets/prompt.md` (BIZ-09):

| Bucket | LinkedIn hook angle |
|--------|---------------------|
| **Architecture lesson** | A design decision, tradeoff, or mistake — with the specifics. |
| **AI in practice** | Real AI/ML experience — not hype, not theory. |
| **Experience-based insight** | Judgment that only comes from years of doing this. |
| **Project behind-the-scenes** | Specific, credible, ships — show the work with numbers. |

**Rule of thumb for hooks:** If you can replace your company name with anyone else's and the hook still works, it's too generic. Your hook should be specific enough that only YOU could have written it.

### 2. A/B/C Hook Testing
For the same story idea, draft 3 different hooks and pick the strongest:

| Style | Example |
|-------|---------|
| **Hook A: Question-based** | "What's the #1 mistake founders make when choosing a tech stack?" |
| **Hook B: Result-first** | "How I built a financial platform in 7 months — solo" |
| **Hook C: Controversy-light** | "I don't use serverless for production platforms. Here's why." |

**Selection rule (appeal standard):** whichever hook wins, it must carry a concrete scene, a number, or a defensible position, and the post behind it must take a stance an informed peer could disagree with. A question-based hook earns its place only when the post answers it with something specific and owned, not a neutral survey. If none of the three hooks clears the bar, the story idea is not ready; sharpen it.

Test across posts: track which style gets the most engagement in your content tracker. After 8 posts, double down on what works.

### 3. Structure the Post
- **Hook** (1 line): Makes them want to read. Specific > general.
- **Story** (3-5 lines): What happened. Specific details (tech, timeline, problem).
- **Lesson** (1-2 lines): What you learned or what matters.
- **No pitch.** No CTA. Just value.

**Visual specs (if adding an image):**
- LinkedIn post image: 1200×628px, PNG or JPG, <5MB
- Carousel: 4-8 slides, 1080×1080px per slide, left-aligned text
- Use brand colors, no stock photos

### 4. Write First Draft
- Write like you talk. No jargon where plain English works.
- Use line breaks. Walls of text don't get read.
- Keep it under 300 words for posts, 1500 for articles.

### 5. Review Against Rules
- Does it demonstrate expertise? ✅
- Does it include specific details? ✅
- Is there zero pitching? ✅
- Would you want to hire the person who wrote this? ✅
- Appeal standard passed? ✅ — check `standards/20260621-CONTENT-STANDARD.md` § Appeal standard: defensible position, scene/number in the first two lines, named stakes with the feeling at the moment, specificity quota.
- AI-artifact scan passed? ✅ — check `standards/20260621-CONTENT-STANDARD.md` § Anti-AI-artifact rules (em-dashes, hedging, generic transitions, passive voice, empty intensifiers, banned constructions).

### 6. Publish + Engage
- Post it
- Within 30 min of posting, comment on 5-10 relevant posts from your target audience
- Reply to every comment on your post within 24 hours

### 7. Record the publish (mandatory)

Update `.work.biz/reference/CONTENT_STATUS.md` before the session ends:

1. Mark the piece `published` in the **Items** table with the date and post URL. Confirm the row names its pillar; assign one from the **By pillar** list if it was still blank.
2. Refresh the **By platform** row (published count, last publish date), the **By pillar** row, and the **Summary** counts.
3. Follow the file's "What to do after a publish" checklist: platform tracker row, `reference/VOICE_RETRO.md` entry, `plans/NEXT.md`, `context/HANDOFF.md`, weekly metrics.

If the operator reports later that they posted a piece outside this flow, record it the same way (or via `@biz-social log`).

### 8. Repurpose (Get 4 Assets From 1 Effort)

After publishing, repurpose the same content into different formats:

| Format | When | Where |
|--------|------|-------|
| Original LinkedIn post | Day 1 | LinkedIn |
| Expanded LinkedIn article (1500 words) | Day 3 | LinkedIn Articles |
| LinkedIn native video (60–90 sec, same story) | Day 5 | LinkedIn video post — use `@biz-social write linkedin video - <topic>` |
| PDF version (case study or guide) | Day 7 | Website lead magnet |

**Why repurpose:** Each format reaches a different audience segment. The video watchers may not read the post. The article readers want depth. One core insight = 4 assets.

## Mode: plan — Content Calendar

### Seasonal Content Calendar (Q1-Q4)

| Quarter | Theme | Focus |
|---------|-------|-------|
| **Q1 (Jan-Mar)** | "New year, new platform" | Planning, architecture foundations, choosing the right stack |
| **Q2 (Apr-Jun)** | "Building in public" | Behind-the-scenes of current projects, lessons learned mid-build |
| **Q3 (Jul-Sep)** | "Deep dives" | Technical architecture deep-dives, AI integration patterns, scaling lessons |
| **Q4 (Oct-Dec)** | "Reflections" | Yearly lessons, what you'd do differently, planning for next year |

Align your posts to the current quarter's theme. It makes your content feel timely and deliberate.

### Batch Scheduling
Block 2-3 hours to write 4 posts at once. Follow the 45-60 min per post time budget, but save setup/context-switching time by doing all topic selection and hook drafting in one pass.

## Mode: challenge — 30-day LinkedIn consistency

Time-boxed posting program for **share expertise, grow impact, post consistently**. Use for LinkedIn official programs (e.g. #CreateImpact) or any 30-day cadence.

### Before you start

1. **`@biz-brand audit`** — profile communicates one expertise area in 5 seconds
2. **LinkedIn ICP** — if `.work.biz/strategy/linkedin-icp.md` is missing, run BIZ-08 (`concepts/linkedin-icp/prompt.md`) first
3. Read `standards/*PLATFORM-ALGORITHM-STANDARD*` — binding link and format rules

### Format mix (non-negotiable)

| Format | Frequency | Why |
|--------|-----------|-----|
| **Text post** | 2–3× / week | Stories, lessons, hot takes |
| **Carousel (document)** | ≥1× / week | Highest organic reach on LinkedIn (3–5× text) |
| **Video** | 1× / 1–2 weeks once minimum setup is available | Trust-building, demos, behind-the-scenes, quick tips |

Draft carousels with `@biz-social write linkedin carousel - <topic>`. Draft text with `@biz-social write linkedin - <topic>`. Draft video with `@biz-social write linkedin video - <topic>`.

### 30-day plan table

Output this table as a document: open it with a Status/Needs header (≤4 lines per the Document clarity contract in `skills/SKILL_DEPENDENCIES.md`) and close it with exactly one `## Next action`; keep Decisions and Open questions as separate numbered lists if either exists. Rotate topic buckets; no same bucket 3 days in a row.

| Day | Format | Topic bucket | Hook seed | Challenge tag | Draft command |
|-----|--------|--------------|-----------|---------------|---------------|
| 1 | text | Architecture lesson | Opening expertise statement | #CreateImpact if createimpact mode | `@biz-social write linkedin - …` |
| 3 | video | Architecture lesson / AI in practice | Mistake or number hook | — | `@biz-social write linkedin video - …` |
| 2 | — | — | Rest / engage only | — | Comment on 5 ICP posts |
| … | … | … | … | … | … |

**Cadence:** 3 posts per week (e.g. Tue / Thu / Sat or Mon / Wed / Fri). Non-post days = comment engagement on target buyer posts (10 min).

**#CreateImpact mode:** Add `#CreateImpact` on **one post per week** (days 1, 8, 15, 22, 29). Do not tag every post.

### Posting ritual (every publish day)

1. Post body, with no external URL, and no URL in a first comment either. Name a resource in words and point to Featured or the bio.
2. Reply while you are at the keyboard. A flat first hour is not a dead post: LinkedIn keeps posts circulating for two to three weeks. Do not delete and repost because hour one was quiet.
3. Comment on 5–10 ICP posts in the same sitting. Answer later comments too; the post is live for weeks, not for an hour.
4. Update `.work.biz/reference/CONTENT_STATUS.md` — mark the piece published with date and platform
5. Log in tracker (`status` mode): format, hook style, impressions at 48h

### Weekly review (end of weeks 1–4)

| Question | Action if no |
|----------|--------------|
| Carousel outperformed text? | Increase carousel ratio next week |
| Comments from target titles? | Revisit `linkedin-icp.md` hooks |
| <200 impressions after 6 posts? | Change hook style or posting time (see Failure Mode below) |

### Challenge completion

After 30 days: run `@biz-content status`, identify best hook × format combo (including video vs. text vs. carousel if video was used), continue at 2–4 posts/week using `@biz-content plan`.

### Video-specific challenge (`@biz-content challenge - video`)

Use this when the operator wants to make LinkedIn native video a primary trust-building habit. It follows the same discipline as the default challenge but adds production coaching and video-specific metrics.

| Week | Frequency | Focus |
|------|-----------|-------|
| **Week 1** | 2 videos | Talking-head tips using mistake/number/controversy hooks. |
| **Week 2** | 2 videos + 1 screen/voice demo | Test which format gets better 3-second view rate and watch time. |
| **Week 3** | 3 videos | Add BTS or story format; test emotional vs. tactical hooks. |
| **Week 4** | 3 videos | Double down on the best-performing format from weeks 1–3. |

**Daily non-post ritual:** 10 minutes of genuine comments on target buyer posts before publishing.

**Weekly review questions:**

- Which hook formula kept the highest 3-second view rate?
- Which video type (talking head / screen + voice / BTS) had the best average % watched?
- Did any video generate comments from target titles? If not, revisit `linkedin-icp.md` hooks.
- Is the operator hitting the minimum setup (phone + window light + lapel mic)? If not, block setup time before week 2.

**Completion:** After 30 days, run `@biz-content status`, identify the winning hook × video-type combination, and commit to a sustainable LinkedIn video cadence (e.g., 1 video/week + 2 text/carousel posts/week).

## Mode: status — Content Performance Tracking

First read `.work.biz/reference/CONTENT_STATUS.md` and report it: what is published, ready, or stuck in draft on LinkedIn, and when the last publish was. Then reconcile: any post the operator names that is missing from the tracker gets recorded now (that is what this tracker is for). Only then review performance:

### Content Tracker Template

| Post | Topic Bucket | Format | Hook Style | Impressions | Engagement | Inbounds | Notes |
|------|-------------|--------|------------|-------------|------------|----------|-------|
| | | text / carousel / video | A/B/C / video hook formula | | | | |

After 8 posts, look for patterns:
- Which hook style gets the most engagement? → Use that more.
- Which topic bucket gets the most inbounds? → Double down.
- What got zero engagement? → Stop doing that topic.

### Content Benchmarks
- B2B LinkedIn posts average **1,688–1,877 impressions** per post (Oktopost, 9,346 posts analyzed)
- Individual profiles typically get less reach than company pages
- **500+ impressions** is a fair starting threshold

## Time Budget

| Step | Time | Notes |
|------|------|-------|
| Choose topic | 5 min | Pick from the 4 buckets |
| Write hook | 5 min | Must be specific enough that only you could write it |
| Write body | 15-20 min | Keep under 300 words |
| Review against rules | 5 min | Checklist above |
| Publish + engage | 15 min | Post + 5-10 comments on others' posts |
| **Total per post** | **45-60 min** | Can batch 4 posts in 2-3 hours |

## Success Criteria

A post is successful when:
- It passes the "would I hire the person who wrote this?" test
- It has **zero pitching**, zero "DM me", zero self-promotion
- It contains at least one specific detail that only someone with real experience would know
- **500+ impressions** within 48 hours with comments that are not from bots
- **For video:** 3-second view rate >30% and average % watched >40% (directional; validate against your own analytics)

## Failure Mode: "I posted and got zero engagement"

This is normal for the first 3-5 posts. LinkedIn's algorithm needs to learn who your audience is.

If after 6 posts you're still getting <200 impressions:

1. **Change your hook style** — if you used questions, try controversy-light. If you used results, try questions.
2. **Change your posting time** — try 7-8am or 12-1pm in your target timezone (US Eastern)
3. **Engage more** — LinkedIn amplifies people who give engagement. Spend 10 min/day commenting on others' posts before publishing your own
4. **Check your network size** — <500 connections limits your reach. Add 10 relevant connections/week
5. **Consider the content itself** — are you sharing a lesson or stating an opinion? Opinion + evidence outperforms pure lessons

**If the underperformer is a video:**

1. **Diagnose the first frame** — most viewers decide without sound. Does the first frame + overlay text communicate the hook in under 1 second?
2. **Check the 0–3 second spoken hook** — no preamble, no music, no "Hey everyone." Start mid-sentence with the promise.
3. **Check captions** — burned-in captions are mandatory; if they are missing or too small, silent viewers scroll past.
4. **Check the lesson specificity** — a generic tip in video form fails faster than in text because the camera exposes uncertainty. Add one number, name, or screenshot.
5. **Check energy and eye line** — low-energy delivery or eyes drifting off-lens kills trust. Re-record the hook until it feels direct.

If you reach 10 posts with consistent <200 impressions despite trying all of the above, the channel may not work for your niche. Test on a different platform — if you get the same result, the problem is the offer, not the channel.

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).
