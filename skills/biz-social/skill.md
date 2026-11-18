---
name: biz-social
description: >-
  Platform-specialized social media content generation across Reddit, Instagram,
  LinkedIn (text, carousel, native video), Facebook, X (Twitter), YouTube
  (long-form + Shorts), Substack, and Threads. Produces content calibrated to
  each platform's unique audience, culture, formatting
  norms, and engagement mechanics — always grounded in the host project's
  strategy, voice profile, and target buyer. For community discovery (finding
  subreddits, Instagram accounts, Facebook groups), use @biz-community find. For
  pure writing craft and long-form content (blog articles, case studies, landing
  pages, email sequences), use @biz-writing.
  biz-social write, biz-social research, biz-social repurpose,
  biz-social strategy, biz-social plan, biz-social icp,
  biz-social status, biz-social log.
  LinkedIn: write linkedin, write linkedin carousel, write linkedin video.
  YouTube: write youtube, write youtube shorts.
---

# biz-social

**Canonical path:** `.ai.biz/skills/biz-social/skill.md`

**Platform guides:** `skills/biz-social/platforms/{reddit,instagram,linkedin,linkedin-video,facebook,x,youtube,substack,threads}.md` — loaded on demand for the requested platform.

Generate platform-native social media content. Every platform has a different culture, audience expectation, and consumption pattern. A LinkedIn post pasted into a Reddit subreddit will be deleted — or worse, mocked. A Facebook group post formatted like an Instagram caption will be ignored. This skill produces content that belongs on each platform.

**Core principle:** Every piece of content must deliver genuine value to the specific audience on that platform. No cross-posting identical content. No generic marketing language dressed up as a platform post.

**Jump to section:** [Parse invocation](#parse-invocation) · [I0 Project context](#i0--project-context-contract-run-before-writing-anything) · [Platform matrix](#platform-culture--audience-matrix) · [Universal format](#universal-platform-format) · [R1 Reddit](#r1--reddit-content) · [R2 Instagram](#r2--instagram-content) · [R3 LinkedIn](#r3--linkedin-content) · [R3V LinkedIn Video](#r3v--linkedin-native-video) · [R4 Facebook](#r4--facebook-content) · [R5 X](#r5--x-twitter-content) · [R6 YouTube](#r6--youtube-content) · [R7 Substack](#r7--substack-content) · [R8 Threads](#r8--threads-content) · [I2 Research](#i2--research-mode) · [I3 Repurpose](#i3--repurpose-mode) · [I4 Strategy](#i4--strategy-mode) · [I5 Plan](#i5--plan-mode) · [ICP mode](#linkedin-icp-mode) · [I6 Status](#i6--status-mode) · [I7 Log](#i7--log-mode)

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-social write reddit - <topic>` | Generate a Reddit post (self-post, comment, AMA thread) |
| `@biz-social write instagram - <topic>` | Generate Instagram content (caption + visual brief, carousel script, story) |
| `@biz-social write linkedin - <topic>` | Generate a LinkedIn text post calibrated to professional audience |
| `@biz-social write linkedin carousel - <topic>` | Generate a LinkedIn document/carousel (slide copy + caption, no outbound URL) |
| `@biz-social write linkedin video - <topic>` | Generate a complete LinkedIn native video package (script, shot list, captions, post copy, posting ritual) |
| `@biz-social write facebook - <topic>` | Generate Facebook content (group post, page update, community post) |
| `@biz-social write x - <topic>` | Generate an X (Twitter) post (tweet, thread, reply) calibrated to real-time, concise format |
| `@biz-social write youtube - <topic>` | Generate a YouTube long-form script (8–15 min educational video) |
| `@biz-social write youtube shorts - <topic>` | Generate a YouTube Shorts script (15–60 sec, up to 3 min when justified) |
| `@biz-social write substack - <topic>` | Generate a Substack post (long-form essay or newsletter issue) |
| `@biz-social write threads - <topic>` | Generate a Threads post (opinion take, open question, short teaching) |
| `@biz-social research reddit - <topic/keyword>` | Find trending discussions, active threads, and content gaps on Reddit |
| `@biz-social research instagram - <topic/keyword>` | Find trending formats, audio, hashtags, and competitor content on Instagram |
| `@biz-social research linkedin - <topic/keyword>` | Find active conversations, trending posts, and content white space on LinkedIn |
| `@biz-social research facebook - <topic/keyword>` | Find active group discussions, trending topics, and content opportunities on Facebook |
| `@biz-social research x - <topic/keyword>` | Find trending topics, active conversations, hashtag movements, and content gaps on X/Twitter |
| `@biz-social research youtube - <topic/keyword>` | Find trending topics, title gaps, thumbnail gaps, and competitor content on YouTube |
| `@biz-social research substack - <topic/keyword>` | Find trending topics, competing newsletters, and content gaps on Substack |
| `@biz-social research threads - <topic/keyword>` | Find trending conversations and content opportunities on Threads |
| `@biz-social research <platform>` | General topic/trend research for a platform (without a specific keyword) |
| `@biz-social repurpose - <source> to <platform>` | Adapt existing content for a different platform |
| `@biz-social repurpose - <source>` | Repurpose one piece into formats for every platform the channel plan sanctions |
| `@biz-social strategy` | Assess which platforms fit the project's target buyer; recommend platform mix |
| `@biz-social icp` | Run BIZ-08 LinkedIn ICP analysis and save to `.work.biz/strategy/linkedin-icp.md` |
| `@biz-social plan <platform> - <horizon>` | Platform-specific content calendar (e.g., `30 days`, `Q3`) |
| `@biz-social status` | Read-only: per-platform state, cadence drift, and channel-plan divergence (see I6) |
| `@biz-social log - <piece> - <platform> [url]` | Record a publish into `CONTENT_STATUS.md` (see I7). Use when something was posted outside a publish flow |

**Default:** `write` if no verb matches. If the user gives a free-text request like "write me a reddit post about X" with no verb, treat it as `write reddit - <their words>`.

---

## I0 — Project Context Contract (run before writing anything)

Load context in priority order. Stop when you have enough. Platform calibration is only as good as the audience profile it's built on.

### Priority 1 — Host project strategy (Business OS)

Read, if they exist:

| File | What it gives you |
|------|-------------------|
| `.work.biz/strategy/target-buyer-profile.md` | Who consumes this content, their fears, values, vocabulary |
| `.work.biz/strategy/linkedin-icp.md` | How the buyer shows up on LinkedIn — titles, hook language, format preference |
| `.work.biz/strategy/one-pager.md` | Niche, unified offer, price range, geography |
| `.work.biz/strategy/channel-plan.md` | Primary channel — determines which platforms are primary vs secondary |
| `.work.biz/reference/OPERATOR_PROFILE.md` | Who the author actually is: skills, constraints, career stage. Keeps claims inside what the operator can deliver and prove. A skeleton-full of `<` placeholders counts as missing; say so |
| `.work.biz/reference/PROJECTS.md` | The proof-point bank: real projects with numbers behind every concrete result; respect its disclosure status |
| `.work.biz/reference/CONTENT_STATUS.md` | What already exists on every platform: never re-write a `published` piece for the same platform; prefer advancing a `ready` or `draft` piece over starting fresh |
| `.work.biz/context/HANDOFF.md` | Recent decisions; avoid contradicting them |

### Priority 2 — Voice profile (binding when present)

Read `.work.biz/reference/VOICE_PROFILE.md`. This is the canonical definition of how *this owner* sounds, and it applies to **every** platform.

If it is absent, check these legacy locations before falling back: `.work.biz/ideas/VOICE_STANDARD.md`, `.work.biz/reference/VOICE_STANDARD.md`, `.work.biz/reference/voice-profile.md`. If you find voice rules only in a legacy location, use them and tell the operator to consolidate them manually into `.work.biz/reference/VOICE_PROFILE.md`.

Apply it as follows:

| Layer | Wins on |
|-------|---------|
| Content Standard § Anti-AI-artifact rules | Always binding. Zero em-dashes and en-dashes regardless of what any other file says |
| Voice profile | Tone, rhythm, structure, vocabulary, point of view |
| Platform guide | Format, length, CTA placement, posting mechanics |

If the profile lists **reference samples**, read the sample matching the requested format before drafting and match its rhythm, not just its topic. If it lists **texture** rules, treat them as deliberate: do not normalize long comma-joined sentences, regional English patterns, or fragments into polished prose. If it names an **owner pass** as mandatory, say so explicitly when delivering and label the output a draft.

Without a voice profile, output will be correctly de-AI-ified but generically human. Say so in the context summary and point the operator at `templates/work/reference/VOICE_PROFILE.md.template`. The same applies when the profile exists but is still a skeleton (`<` placeholders remain, or no reference sample is filled): treat it as absent and warn plainly, because an unfilled profile adds a step without adding value (CONVENTIONS § Voice loop).

### Priority 3 — Project identity

Read `.cursorrules` — its `REPLACE:` tokens resolve to `PROJECT_NAME`, `UNIFIED_OFFER`, `TARGET_BUYER`, `PRICE_RANGE`. These anchor tone and positioning across all platforms.

### Priority 4 — Tech stack fingerprint

- `.work.biz/reference/PROJECTS.md` → the curated proof-point bank; read it before scanning the repo
- `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `docker-compose*.yml` → real tech to cite
- `README.md` → what the project actually does
- Any `work/`, `case-studies/`, or `docs/` folder → real proof points

**Non-tech hosts:** if no stack manifest exists and the project is clearly not technology work, tilt the specificity requirement toward domain evidence from `reference/PROJECTS.md` and `reference/OPERATOR_PROFILE.md` instead of forcing technical detail.

### Priority 5 — Brand standard

Read `standards/*BRAND-GUIDE*`, `standards/*CONTENT-STANDARD*`, and `standards/*PLATFORM-ALGORITHM-STANDARD*` if present. These are binding.

### Priority 6 — Fallback example

If none of the above yield a usable brand/audience, load `references/project-context.example.md` (a worked example showing the expected shape and depth) and state explicitly: **"No project context found; using generic professional defaults calibrated to the example profile."** Then proceed with professional-quality defaults and the structure rules below.

### Context summary (emit briefly before drafting)

```
LOADED CONTEXT
  Project:      <name or "unnamed — generic defaults">
  Offer:        <one line or "unspecified">
  Audience:     <buyer persona or "general tech-aware readers">
  Voice:        <"VOICE_PROFILE.md (locked <date>)" | "legacy: <path>" | "none — generic human defaults">
  Reference sample: <path used for this format, or "none for this format">
  Stack:        <concrete tech or "unspecified">
  Primary channel: <from channel-plan or "unspecified">
  Platform fit:   <"in channel-plan" | "NOT in channel-plan — flag before publishing">
  LinkedIn ICP:   <titles + hook vocabulary or "unspecified — using BIZ-08 defaults">
  Gaps:         <what's missing that the user should supply for better output>
```

**Channel-plan check.** If the requested platform is not listed in `.work.biz/strategy/channel-plan.md`, or appears on its "explicitly not channels" list, say so before delivering. Draft anyway if asked, but do not let tooling quietly expand the channel mix past what the strategy sanctions. Point at `@biz-strategy amend` as the way to change the plan on the record.

If critical gaps exist (no audience, no offer), name them and ask **one** consolidated question only if they would materially change platform selection or content direction. Otherwise proceed with profession-quality defaults.

**LinkedIn only:** If `linkedin-icp.md` is missing but LinkedIn is the platform, note the gap and apply BIZ-08 defaults (specific hooks, carousel for save-worthy frameworks, no buzzwords). Suggest `@biz-content challenge` or running BIZ-08 after delivery if the user is building a cadence.

---

## Platform Culture & Audience Matrix

Before writing for any platform, understand who you're writing for and the cultural norms.

| Platform | Primary audience signals | Content consumption pattern | Trust mechanics | Self-promotion tolerance |
|----------|--------------------------|----------------------------|-----------------|--------------------------|
| **Reddit** | Niche communities (subreddits), topic-first, pseudonymous | Deep reading in chosen subs; browse by Hot/Top | Demonstrated expertise over time; karma history; post history | **Extremely low.** 9:1 ratio rule — 90% participation, 10% or less self-reference. Violators are banned. |
| **Instagram** | Visual-first, younger skew (18-34 dominant), discovery-driven | Rapid scroll; 1-3 second attention grab; Reels dominate reach | Aesthetic consistency; authenticity; social proof (follower count, engagement) | Moderate. Acceptable if value-first. "Link in bio" model. |
| **LinkedIn** | Professional, career-motivated, B2B decision-makers | Feed scroll; article reading; native video; industry-aware but busy | Credentials, track record, mutual connections, specificity, on-camera presence | **Higher than others.** Thought leadership is the format. Pitch tolerated after value delivery. |
| **Facebook** | Groups are hyper-engaged communities; Pages are broadcast | Groups: threaded, conversational. Pages: feed scroll. | Community membership; consistent helpful presence; local relevance | Varies wildly. Groups: low tolerance, moderator-enforced. Pages: moderate. |
| **X (Twitter)** | Real-time, news-driven, tech/VC/journalist-heavy, high velocity | Rapid-fire feed; 280-char limit shapes consumption; threads for depth | Wit, speed, insider knowledge, being first to insight. Followers/lists = credibility. | Moderate-low. Self-promotion is common but must be wrapped in value. Quote-tweet culture rewards sharp takes. |
| **YouTube** | Search-driven, education/entertainment hybrid, high intent | Long-form: intentional viewing. Shorts: rapid scroll in vertical feed. | Consistency, production value, proof of expertise, community interaction | Moderate. Pitch only after value delivery; CTAs must be earned. |
| **Substack** | Self-selected subscribers who opted into depth; email-first | Inbox reading by choice; long-form tolerated and rewarded. In-app feed is discovery only | Sustained depth over months, intellectual honesty, a consistent niche, recommendations from adjacent writers | **Highest of any platform here.** Readers subscribed to you. Paid tiers are an explicit pitch the audience consented to. |
| **Threads** | Text-first, conversational, Instagram-adjacent audience | Rapid scroll, but replies pull people back into threads | Being a present, replying human. Regulars who recognize you | Low. Promotional and link-heavy posts are explicitly deprioritized by ranking. |

---

## Platform Audience Specialization

The same person behaves differently on each platform. Content must account for this.

### How the same target buyer shows up per platform

| Element | Reddit | Instagram | LinkedIn | Facebook | X (Twitter) | YouTube |
|---------|--------|-----------|----------|----------|-------------|---------|
| **Identity** | Pseudonymous, interest-based | Curated, visual identity | Real name, professional identity | Real name, personal + community identity | Real name or pseudonymous; persona-based | Anonymous or persona-based; intent-driven |
| **Mindset** | Learning, debating, problem-solving | Discovery, inspiration, entertainment | Career growth, industry awareness, hiring | Community belonging, local connection, peer support | Real-time awareness, breaking news, hot takes, networking | Learning, entertainment, research before purchase |
| **Attention span** | Willing to read long-form if valuable | Seconds. Visual hook or scroll past. | Moderate. Will read 200-300 words; will watch 30–90 sec video if hook earns it. | Variable. Groups: moderate. Feed: short. | Seconds per tweet. Tweet chains earn sustained reading if the anchor is strong. | Long-form: 8–15 min if value is sustained. Shorts: 0–3 sec hook. |
| **Trust trigger** | Specific, verifiable claims. No marketing language. | Visual authenticity, social proof, consistency. | Deep expertise demonstrated. Specific results. Named clients. On-camera authenticity. | Peer validation. Group membership. Mutual friends. | Insider knowledge, speed, contrarian-but-correct takes, consistency over time. | Demonstrated expertise, consistent uploads, transparent proof, community engagement. |
| **Rejection trigger** | Self-promotion, vagueness, link-dropping | Overt selling, inauthentic polish, stock imagery | Thought leadership without proof. Buzzword bingo. Low-energy or over-polished video. | Spammy posts. Breaking group rules. Uninvited pitching. | Over-polished corporate voice, threadbois, engagement farming, stale takes. | Clickbait, wasted time, sales-first openings, low production value that undermines expertise. |

The two text platforms added later sit at opposite ends of the same axis, so they get their own row set:

| Element | Substack | Threads |
|---------|----------|---------|
| **Identity** | Real name, authorial identity. The reader chose *you*, not a topic | Real name, conversational identity. Instagram-adjacent, less formal than LinkedIn |
| **Mindset** | Deliberate reading, often at a chosen time. Learning in depth | Ambient browsing, but willing to argue. Wants an exchange, not a broadcast |
| **Attention span** | Longest of any platform here. 700–2,000 words is normal, not indulgent | Seconds for the post; minutes for a reply thread that engages them |
| **Trust trigger** | Sustained depth across months. Intellectual honesty. Recommendations from writers they already trust | Being a present, replying human. Recognition from repeated exchanges |
| **Rejection trigger** | Padding, format-first titles ("Part 3"), paywalling the actual value, issue-number preambles | Brand voice, engagement bait, links in the post, posting and vanishing |

**Rule:** Never use a LinkedIn post as a Reddit post. Never use an Instagram caption as a Facebook group post. Each platform gets purpose-built content.

**The two hard directional rules:** compression down is fine, expansion up is not. Substack long-form repurposes cleanly to every shorter surface; a LinkedIn post expanded into a Substack piece reads as padded. And a LinkedIn post ported to Threads fails on register, because Threads ranking actively penalizes the formality LinkedIn rewards.

---

## Universal Platform Format

The platforms share a common anatomy. Start from this skeleton, then apply the platform-specific deltas in R1–R8.

**One exception.** Substack is the only surface here where the reader opted into depth by subscribing, so the compression this skeleton assumes is a downgrade there. On Substack, narrative prose beats the hook/body/CTA anatomy. See R7.

### Universal post structure

```
HOOK
  — The first thing the audience sees. It must earn attention in under 3 seconds.
  — Specificity > mystery. Lead with the reader's problem, a concrete result, or a tension.
  — Appeal standard: the first two lines carry a concrete scene, a named moment, or a number.
  — No clickbait, no ALL CAPS, no hollow intensifiers, no "you won't believe."

BODY
  — One idea per paragraph or segment. White space and rhythm matter.
  — Show, don't tell: replace adjectives with data, examples, names, numbers.
  — Include at least one specific proof point per post (a number, a tradeoff, a hard-won lesson).
  — Appeal standard: the post takes a position an informed peer could disagree with,
    names what breaks and for whom (stakes), and keeps the specificity quota
    (one proper noun, number, or named artifact per 150 words). See
    standards/20260621-CONTENT-STANDARD.md § Appeal standard.
  — Technology tilt (mandatory for tech-positioned projects): cite concrete stack, failure mode, or metric.
  — Remove marketing language: solution, platform, revolutionary, game-changing, cutting-edge, best-in-class, scalable, robust, seamless, innovative.

CTA / ENGAGEMENT PROMPT
  — One clear action, platform-appropriate. Earned, not tacked on.
  — Invite conversation, save, share, or a channel-native next step. No "DM me" where it violates culture.
```

### Universal anti-patterns (DO NOT)

- Cross-post identical content across platforms without rewriting structure, tone, and emphasis.
- Use hollow intensifiers: very, really, truly, game-changing, revolutionary, cutting-edge, robust, scalable (unquantified).
- Lead with credentials or product instead of the reader's problem.
- Drop unearned self-promotion or external links where the platform penalizes them.
- Use engagement bait ("Agree?", "Tag someone who...", "Share if you agree...", "Upvote if...").
- Post low-resolution visuals, heavy text overlays, or stock imagery that signals inauthenticity.
- Post and disappear. The first 30–120 minutes after publishing determine reach on most platforms.

### Universal posting cadence principles

- **Consistency > frequency.** A predictable rhythm outperforms sporadic bursts.
- **The first hour is critical.** Reply to comments, engage with replies, and signal algorithmic momentum early.
- **Batch creation, single-platform adaptation.** Create the core insight once; rewrite the packaging per platform.
- **Leave reactive slots open.** 20–30% of calendar slots should be reserved for trending topics, comments, and community replies.

Platform-specific posting windows and frequency live in each R-section below.

---

## I1 — `write` mode

### Step 1 — Determine platform + type

Resolve from the request:

1. **Platform** — reddit, instagram, linkedin, facebook, x, youtube, substack, threads (required)
2. **Content type** — depends on platform (see each platform section below)
3. **Goal** — educate, build trust, demonstrate expertise, start conversation, attract leads
4. **CTA** — what action should the reader take (if any)? Platform-appropriate CTA only.

### Step 2 — Load platform-specific rules

Load the platform guide from `skills/biz-social/platforms/<platform>.md` for formatting, structure, anti-patterns, and posting cadence. The R1–R8 markers below are thin pointers; the detailed rules live in the platform files.

### Step 3 — Draft with quality rules

Apply the [Universal Platform Format](#universal-platform-format), plus the platform-specific deltas from the loaded platform guide.

Before finalizing, run an **AI-artifact scan**: zero em-dashes (—) or en-dashes (–); no hedging fillers, generic transitions, passive-voice defaults, empty intensifiers, repetitive triplet cadence, literary flourishes, or other tics listed in `standards/20260621-CONTENT-STANDARD.md` § Anti-AI-artifact rules. Rewrite any flagged sentence into plain, specific, human speech.

### Step 4 — Deliver

Provide the complete, ready-to-post content. Below a divider, offer:

1. **Platform notes** — why this post works for this platform specifically
2. **Alternate hooks** (2 options — different angles)
3. **Posting time suggestion** — best window for this platform + audience
4. **Engagement plan** — 1-2 sentences on what to do after posting

### Step 5 — Register the piece (Business OS projects)

If `.work.biz/` exists, record the piece in `.work.biz/reference/CONTENT_STATUS.md` so later sessions know it exists (create the file from `templates/work/reference/CONTENT_STATUS.md.template` if missing):

- Add an **Items** row: piece title, status `ready` (or `draft` when an owner pass is still required), target platform in the Note column.
- **Assign the pillar**: name which strategic pillar (from the tracker's **By pillar** list, traceable to one-pager/offer) this piece advances. If the pillar list is empty, define it from the strategy docs first.
- Refresh the **By platform**, **By pillar**, and **Summary** rows.
- Remind the operator: once posted, record the publish (date + URL) here or via `@biz-social log`. The tracker is only true if publishes land in it.

Skip this step for `research` mode and for throwaway fragments the user explicitly did not want kept.

---

## R1 — Reddit Content

Load `skills/biz-social/platforms/reddit.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for reddit.

---

## R2 — Instagram Content

Load `skills/biz-social/platforms/instagram.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for instagram.

---

## R3 — LinkedIn Content

Load `skills/biz-social/platforms/linkedin.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for linkedin.

---

## R3V — LinkedIn Native Video

Load `skills/biz-social/platforms/linkedin-video.md` for the complete LinkedIn video mentor guide: scripting, shooting, editing, captions, first-frame optimization, analytics, and the 30-day video challenge. Apply it when invoking `@biz-social write linkedin video` or when coaching the operator through LinkedIn native video production.

---

## R4 — Facebook Content

Load `skills/biz-social/platforms/facebook.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for facebook.

---

## R5 — X (Twitter) Content

Load `skills/biz-social/platforms/x.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for x.

---

## R6 — YouTube Content

Load `skills/biz-social/platforms/youtube.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for youtube.

---

## R7 — Substack Content

Load `skills/biz-social/platforms/substack.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for substack.

Substack is the one platform in this skill that is an owned email list first and a discovery network second. Two consequences override the universal skeleton: narrative prose beats compressed hook/body/CTA structure, and long-form is the compounding asset while Notes are only the funnel. Read the guide before drafting; do not infer Substack rules from the LinkedIn or newsletter format rules.

---

## R8 — Threads Content

Load `skills/biz-social/platforms/threads.md` and apply its platform-specific rules when writing, researching, planning, or repurposing for threads.

Threads is a conversation-velocity platform, not a smaller X. Its real cost is operational rather than editorial: the first 30–60 minutes after posting permanently set the reach ceiling, so a post nobody is present to reply to is largely wasted. Never recommend Threads without stating that presence requirement.

---

## I2 — `research` mode

Discover trending topics, active discussions, and content gaps on a specific platform — grounded in the project's target buyer and niche. Use this mode before writing to ensure relevance, or when looking for content ideas.

### Research workflow

1. **Load project context** per I0. The target buyer profile determines which communities and topics are relevant.
2. **Identify the research target** — platform + optional keyword/topic from the user's request.
3. **Survey the landscape** using the platform-specific research methods below.
4. **Output a research brief** with actionable content opportunities.

### Research output format

```markdown
## Research Brief — {Platform} — {Topic/Keyword}

Research brief: trending discussions, content gaps, and recommended content for {Platform}.
Status: Draft — {date}
Needs: {the decision or review required, or `none`}

### Trending now
| Thread/Post/Trend | Why it's trending | Relevance to {PROJECT_NAME} |
|-------------------|-------------------|------------------------------|
| [description] | [context] | [high / medium / low — reason] |

### Content gaps (questions people are asking with no good answers)
| Question / Pain point | Where found | Content opportunity |
|----------------------|-------------|---------------------|
| [specific question] | [subreddit / hashtag / group / search query] | [what a good answer would cover] |

### What competitors/peers are posting
| Source | What they posted | What's missing | Our angle |
|--------|-----------------|----------------|-----------|
| [account / subreddit / group / channel] | [summary] | [gap or weakness] | [how we'd do it better] |

### Recommended content for this platform
1. **[Hook seed]** — [why it would work]
2. **[Hook seed]** — [why it would work]
3. **[Hook seed]** — [why it would work]

### Timing
- Best posting window: [day + time]
- Urgency: [evergreen / trending now — act within 48 hours / seasonal]

## Next action

{one action in the exact syntax to run/type, or `Next action: none — <reason>`}
```

Close the research brief per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` / `**Needs your answer:**` / exactly one `**Next step:**`).

### Platform-specific research methods

For the platform being researched, load the corresponding platform guide from `skills/biz-social/platforms/<platform>.md` and use the Research methods section at the end of that file.

### Research quality rules

1. **Research must be grounded in the project's target buyer.** Don't report trending topics that are irrelevant to the project's niche, even if they're popular.
2. **Label confidence.** Distinguish between: "Confirmed active discussion (linked thread with 200+ comments this week)" and "Inferred interest (topic appears in comments but no dedicated thread yet)."
3. **No fabricated data.** Do not invent specific threads, usernames, or engagement numbers. Describe patterns and types of discussions observed. If live web research is not possible, explicitly state: **"Unable to perform live platform research. Recommendations below are based on known patterns for this niche/platform. Verify with live research before committing to topics."**
4. **Prioritize content gaps over saturated topics.** A question with 50 upvotes and no good answer is higher value than a topic with 5,000 upvotes and 500 comprehensive responses.
5. **Time-stamp trending items.** Anything flagged as "trending now" should include: "Act within 48 hours or verify it's still active before creating content."

---

## I3 — `repurpose` mode

Take one piece of content and produce platform-adapted versions. Each must stand alone — no "see original post for context."

### Repurpose workflow

1. **Identify the core insight.** What's the single most valuable idea in the source content? Reduce it to one sentence.
2. **Map to each platform using the transformation table below.**
3. **Rewrite, don't reformat.** Platform adaptation means changing the structure, tone, and emphasis — not just the length.

### Platform transformation table

| From | To | What changes |
|------|----|--------------|
| Blog article / long-form | **Reddit** | Extract one compelling finding. Lead with the problem, not the solution. Add discussion prompt. Remove all marketing language. |
| Blog article | **Instagram** | Distill to one visual concept. Carousel or reel script. Short caption with hook + key point + CTA. |
| Blog article | **LinkedIn** | Extract the single strongest insight. Personal framing. Story-led structure. 200-300 words. |
| Blog article | **LinkedIn video** | Turn the strongest lesson into a 60–90 sec talking-head or screen-recording script with one proof point. |
| Blog article | **Facebook Group** | Frame as a lesson learned. Community-oriented language. Discussion prompt at end. |
| Blog article | **X (Twitter)** | Extract 5-7 key points. Lead with the most counterintuitive. Build a thread. One insight per tweet. |
| Blog article | **YouTube long-form** | Build a scripted 8–15 min video with segmented body, retention resets, and search-optimized title. |
| Blog article | **YouTube Shorts** | Extract the single most visual or counterintuitive takeaway. 15–60 sec hook → proof → loop-friendly CTA to long-form. |
| LinkedIn post | **Reddit** | Strip professional framing. Add technical detail. More detached, analytical tone. |
| LinkedIn post | **Instagram** | Convert the insight into a carousel narrative. Add visual brief. Shorten caption by 60%. |
| LinkedIn post | **LinkedIn video** | Turn the insight into a 30–90 sec talking-head script; use the post as post copy and add a conversation CTA. |
| LinkedIn post | **X (Twitter)** | Condense to 280 characters or a 5-8 tweet thread. Sharpen the hook. Add speed. |
| LinkedIn post | **YouTube Shorts** | Turn the insight into a 30–60 sec talking-head or screen-recording hook with one proof point. |
| Reddit post | **LinkedIn** | Add professional context. Soften blunt/technical language. Add career/business implications. |
| Reddit post | **Instagram** | Extract the most visual/counterintuitive element. Build a reel script around one "aha" moment. |
| Reddit post | **X (Twitter)** | Extract the strongest claim. Build a thread around it. Speed up the pacing. |
| Reddit post | **YouTube long-form** | Expand the thread into a structured tutorial with timestamps and screen proof. |
| Instagram content | **Reddit** | Strip visual references. Add technical depth and written explanation. Longer form. |
| Instagram content | **LinkedIn** | Add business context. Connect insight to professional outcomes. |
| Instagram content | **X (Twitter)** | Convert visual concept to text thread. Describe what the visual shows. Distill to key takeaway. |
| Instagram content | **YouTube Shorts** | Reuse the Reel as a Short directly if vertical + under 3 min; otherwise re-cut the core hook. |
| X (Twitter) thread | **Reddit** | Expand into self-post. Add context, deeper analysis, discussion prompts. |
| X (Twitter) thread | **LinkedIn** | Convert to 200-300 word post. Add professional framing. Slightly softer tone. |
| X (Twitter) tweet | **Instagram** | Visualize the takeaway. Carousel or quote card. Short caption. |
| X (Twitter) thread | **YouTube long-form** | Turn the thread into a scripted video, one tweet ≈ one segment, with title from the hook tweet. |
| Video/podcast transcript | **All platforms** | Extract 3-5 quotable insights. Each becomes one platform-adapted post. Long-form video → blog/LinkedIn; Shorts clips → Instagram/YouTube Shorts/X. |
| YouTube long-form | **Reddit** | Extract one technical lesson. Lead with problem, include code/screenshots, end with discussion prompt. |
| YouTube long-form | **LinkedIn** | Summarize the core insight in 200–300 words with professional framing. |
| YouTube long-form | **LinkedIn video** | Cut one 60–90 sec segment with a strong standalone hook and native-first captions. |
| YouTube long-form | **X (Twitter)** | Turn each segment into a tweet; hook tweet = title promise; thread builds the case. |
| YouTube long-form | **Instagram** | Carousel from segments or Reel from the strongest 60-sec clip. |
| YouTube long-form | **YouTube Shorts** | Cut one counterintuitive moment or quick win per Short; CTA back to the full video. |
| YouTube Shorts | **Instagram Reel** | Repost directly if under 90 sec and vertical; trim to Instagram's strongest 30–60 sec otherwise. |
| YouTube Shorts | **X (Twitter)** | Extract the spoken hook as a tweet; attach the video or a GIF. |
| YouTube Shorts | **LinkedIn** | Add business context to the takeaway; keep under 150 words. |
| YouTube Shorts | **LinkedIn video** | Upload natively; add LinkedIn-specific first-frame text and conversation CTA. |
| LinkedIn video | **LinkedIn text post** | Transcribe the core insight and proof point into a 200–300 word post. |
| LinkedIn video | **LinkedIn carousel** | Expand the video's 3–5 beats into 6–12 slides with the hook on slide 1. |
| LinkedIn video | **YouTube Shorts** | Re-export vertical version if needed; ensure the 0–3 sec hook is self-contained. |
| LinkedIn video | **Instagram Reel** | Use as-is if vertical/under 90 sec; otherwise re-cut the strongest 30–60 sec. |
| LinkedIn video | **X (Twitter)** | Extract the screenshot-worthy line as a tweet; attach the video or quote card. |

### Multi-platform repurpose output

When repurposing to all platforms, produce the blocks below. **Only produce blocks for platforms the project's `channel-plan.md` actually sanctions.** A full nine-platform dump is almost always the wrong deliverable: it looks productive while creating publishing obligations the operator has no capacity to meet. If no channel plan exists, produce the three closest fits and name what you skipped and why.

```
CORE INSIGHT: [one sentence — the DNA of all versions]

REDDIT VERSION
  Subreddit suggestion: [which community]
  Title: [hook]
  Body: [full post]

INSTAGRAM VERSION
  Format: [reel / carousel / story]
  Caption: [full caption]
  Visual brief: [what to create]

LINKEDIN VERSION
  Hook: [first line]
  Body: [full post]

LINKEDIN VIDEO VERSION
  Format: [talking head / screen + voice / BTS]
  0–3 sec hook: [first spoken line]
  Body beats: [3–5 bullet points]
  On-screen text: [key overlays]
  Caption note: [burned-in captions required]
  CTA: [conversation prompt]

X (TWITTER) VERSION
  Format: [single tweet / thread]
  Hook tweet: [first tweet — the thread anchor]
  Body: [remaining tweets or full tweet]
  Media suggestion: [image/video if applicable]

FACEBOOK VERSION
  Context: [Group or Page? Which group?]
  Body: [full post]

YOUTUBE VERSION
  Format: [long-form / Shorts / both]
  Long-form title: [title]
  Long-form segment outline: [3–4 segments with retention points]
  Shorts hook: [0–3 sec hook]
  Thumbnail concept: [3–5 words + visual focal point]

SUBSTACK VERSION
  Title: [the idea, not the format]
  Subtitle: [the stake or tension — do not restate the title]
  Opening line: [scene or problem; no greeting, no issue number]
  Narrative outline: [3–5 beats as prose sections, not bullets]
  Length target: [400–700 short / 700–2,000 long-form]
  Note (funnel): [1–3 paragraph note whose job is to pull toward this piece]

THREADS VERSION
  Post: [≤500 chars, conversational, one idea]
  Reply opening: [the unresolved tradeoff or real question left open]
  Presence window: [when the operator must be available for 60–90 min]
```

**Repurposing asymmetry.** Compression is easy and expansion is not. A Substack long-form piece repurposes cleanly down to LinkedIn, X, and Threads. The reverse does not work: a LinkedIn post expanded into a Substack piece reads as padded, because the compression that made it good on LinkedIn removed the narrative the Substack reader subscribed for. When the source is short-form and the target is Substack, say that the piece needs new material rather than delivering inflated filler.

---

## I4 — `strategy` mode

Assess which platforms fit the project's target buyer profile. Output a platform recommendation matrix.

### Strategy workflow

1. Load target buyer profile from `.work.biz/strategy/target-buyer-profile.md`
2. Load channel plan from `.work.biz/strategy/channel-plan.md`
3. Assess each platform against:
   - Does the target buyer spend meaningful time here?
   - Does the platform support the price range?
   - Does the platform's content format match the offer's proof points?
   - What's the operator's existing presence on each platform?

### Output format

```markdown
## Platform Strategy — {PROJECT_NAME}

Platform strategy: which platforms fit the target buyer, and the recommended platform mix.
Status: Draft — {date}
Needs: {the decision or review required, or `none`}

**Primary platform:** {platform} — {rationale in one sentence}
**Secondary platforms:** {list}
**Skip for now:** {list with brief reasons}

### Reddit
  Fit: {EXCELLENT / GOOD / POOR}
  Recommended subreddits: {list based on buyer profile}
  Content approach: {one sentence}

### Instagram
  Fit: {EXCELLENT / GOOD / POOR}
  Content format recommendation: {reels / carousels / stories}
  Visual style: {one sentence}

### LinkedIn
  Fit: {EXCELLENT / GOOD / POOR}
  Post frequency: {recommendation}
  Format mix: {text / carousel / video / combination}
  Video readiness: {ready now / needs minimum setup / defer until text+carousel proven}
  Content pillars: {2-3 themes}

### Facebook
  Fit: {EXCELLENT / GOOD / POOR}
  Approach: {Groups first / Pages / Skip}
  Group suggestions: {if applicable}

### X (Twitter)
  Fit: {EXCELLENT / GOOD / POOR}
  Tweet frequency: {recommendation}
  Thread cadence: {1-2x/week recommended for deep content}
  Content pillars: {2-3 themes}

### YouTube
  Fit: {EXCELLENT / GOOD / POOR}
  Format mix: {long-form / Shorts / both}
  Upload cadence: {capacity-dependent: e.g., 1 long-form + 3–5 Shorts/week at medium-high capacity; 1 long-form/2 weeks + 2 Shorts/week at low-medium capacity}
  Content pillars: {2-3 themes}
  Search vs. discovery emphasis: {one sentence}

### Substack
  Fit: {EXCELLENT / GOOD / POOR}
  Cadence: {weekly / biweekly long-form on a fixed day}
  Free vs paid: {all-free authority play / paid tier — and the honest revenue math}
  Recommendation targets: {3-5 adjacent publications to earn recommendations from}
  Time to inbound: {6-12 months typical for a services business}

### Threads
  Fit: {EXCELLENT / GOOD / POOR}
  Cadence: {2-5/week, only as many as the presence window allows}
  Presence capacity: {can the operator hold 60-90 min after each post? If no, fit is POOR regardless of audience match}
  Content pillars: {2-3 themes}

### 30-day action plan
  Week 1: {action}
  Week 2: {action}
  Week 3: {action}
  Week 4: {action}

## Next action

{one action in the exact syntax to run/type, or `Next action: none — <reason>`}
```

Close the strategy report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` / `**Needs your answer:**` / exactly one `**Next step:**`).

### Strategy rules (these override an enthusiastic reading of the matrix)

1. **Recommend fewer platforms than the operator asks for.** More surfaces is almost never the answer for a solo operator. One platform done consistently beats four done sporadically, and the framework's own strategy standard requires picking a single primary channel.
2. **Rate fit on capacity, not just audience match.** A platform where the buyer lives but the operator cannot sustain the cadence is a POOR fit, not an EXCELLENT one. State the weekly hour cost explicitly for each recommendation.
3. **Check the existing channel plan before recommending anything new.** If `channel-plan.md` already names a primary channel, your job is to serve it, not to relitigate it. If a platform appears on its "explicitly not channels" list, do not recommend it without naming the recorded reason it was excluded and what has changed since.
4. **Distinguish authority channels from pipeline channels.** Substack and YouTube build authority over 6–12 months. If the project needs revenue sooner than that, say so plainly and route the recommendation toward conversation-led motions instead of content volume.
5. **If content volume has already been tried without pipeline results, say so.** Check `.work.biz/analysis/` and `reference/CONTENT_STATUS.md` for prior performance. Recommending more platforms after impressions failed to convert repeats a known-failed experiment at higher cost.

---

## I5 — `plan` mode

Build a platform-specific content calendar. Output a Markdown table.

### Plan table format

The calendar document opens with a Status/Needs header (what this is; `Status: Draft` + date; one-line Needs) and closes with exactly one `## Next action`, per the Document clarity contract.

| Day | Date | Platform | Type | Topic | Pillar | Hook seed | Visual needed | Repurpose source |
|-----|------|----------|------|-------|--------|-----------|---------------|-----------------|

### Planning rules

- Every topic must trace to a loaded audience pain or the operator's proven work
- Every topic names the strategic pillar it advances (the 3–5 messages from one-pager/offer, as listed in `CONTENT_STATUS.md` § By pillar); report any pillar the calendar leaves silent
- Vary content types — don't post the same format 5 days in a row
- Leave 2-3 slots per week for reactive/trending content (especially Instagram and YouTube Shorts)
- For Reddit: plan 1-2 posts per week max. Focus on comment engagement daily.
- For Instagram: 3-5 feed posts + 5-7 stories per week
- For LinkedIn: 2-4 posts per week; include 1 native video every 1–2 weeks once minimum setup is available
- For X (Twitter): 3-5 tweets + replies daily. 1-2 threads per week.
- For Facebook Groups: 2-3 posts + daily comment engagement
- For YouTube: 1 long-form video per week + 3–7 Shorts; schedule Shorts on non-upload days to maintain consistency signal

---

## Platform Image Dimension Quick Reference

| Platform | Feed post (square) | Feed post (vertical) | Story | Profile pic | Cover/banner |
|----------|-------------------|---------------------|-------|-------------|--------------|
| **Reddit** | N/A (text-first) | N/A | N/A | 256x256px | Banner: 1920x384px (10:1) |
| **Instagram** | 1080x1080px (1:1) | 1080x1350px (4:5) | 1080x1920px (9:16) | 320x320px | N/A |
| **LinkedIn** | 1080x1080px | 1080x1350px (4:5) | N/A | 400x400px | 1584x396px (personal) |
| **Facebook** | 1080x1080px | 1080x1350px (4:5) | 1080x1920px | 320x320px | 851x315px (page) |
| **X (Twitter)** | 1080x1080px (1:1) | 1080x1350px (4:5) | N/A | 400x400px | 1500x500px (banner) |
| **YouTube** | 1280x720px thumbnail (16:9 preview) | N/A | N/A | 800x800px | 2560x423px (desktop safe: 1546x423px) |

---

## Cross-Platform Content Value Ladder

Different platforms support different levels of depth. Structure your content pyramid:

```
        ▲
       /  \
      / DEEP \         Blog article, case study, technical paper, YouTube long-form
     /  1x/mo  \       → One insight, fully explored
    /───────────\
   /   EXPAND    \     LinkedIn carousel, Reddit self-post, newsletter, YouTube playlist
  /    2-4x/mo    \    → One insight, structured explanation
 /─────────────────\
/    SOCIAL LAYER    \ Instagram reel, LinkedIn post, X tweet/thread, Facebook Group, YouTube Shorts
      3-5x/week       → One insight, one takeaway, platform-native format
```

**Rule:** Every piece of deep content should generate 3-5 social-layer posts. Don't write everything from scratch — ladder it.

---

## Quality check before delivering (run internally)

- [ ] Is the content calibrated to this specific platform's culture and audience?
- [ ] Does the piece's implied buyer match `strategy/target-buyer-profile.md` (primary or a named secondary)? If it addresses a different audience than the strategy serves, revise or flag before delivering.
- [ ] Does the CTA point to a current offer in `strategy/offer-scope.md`? No bare calendar links without a one-line offer bridge; no framings from superseded positioning.
- [ ] Freshness: if anything under `strategy/` is newer than the last certification (or `gates.md` lacks strategy-ready PASS), surface that before delivering publish-ready copy.
- [ ] Does the first line/frame/hook earn its place?
- [ ] **Appeal:** does the piece take a position an informed peer could disagree with?
- [ ] **Appeal:** do the first two lines/frame carry a scene, named moment, or number?
- [ ] **Appeal:** are the stakes named (what breaks, for whom, at what cost) and is the feeling at the stakes moment present?
- [ ] Is there at least one specific number, name, or proof point?
- [ ] Have I removed all hollow adjectives and marketing language?
- [ ] Is the length appropriate for this platform?
- [ ] Is the CTA platform-appropriate (no "DM me" on Reddit, no external links in body on Instagram)?
- [ ] **LinkedIn:** No URL in the body or a first comment. Name the resource in words; point at Featured or the bio. Run `bash scripts/prose-rhythm-check.sh` on narrative drafts and report PASS, FAIL, or SKIP.
- [ ] **LinkedIn carousel:** One idea per slide, ≤40 words/slide, hook on slide 1, no links on slides?
- [ ] **LinkedIn video:** Is the first frame a silent hook? Are captions burned in? Is there one clear takeaway, one proof point, and a conversation-prompt CTA?
- [ ] **YouTube:** Are title + thumbnail evaluated as a pair and CTR-optimized?
- [ ] **YouTube long-form:** Are retention resets planned every 3–4 minutes?
- [ ] **YouTube Shorts:** Is the 0–3 second hook present and is there a clear CTA to long-form/channel?
- [ ] Would this post be upvoted/liked/shared by the target audience, not just the author?
- [ ] Is the technology tilt present (for tech-positioned projects)?
- [ ] Are self-references earned and disclosed, not promotional?
- [ ] Would this content survive 30 seconds of scrutiny by a skeptical platform-native user?

If any box is unchecked, fix it before delivering.

---

## Completion gate (cannot be skipped)

You may only claim the task complete when all are true:
1. The deliverable is written, platform-appropriate, and ready to post.
2. Project context was loaded per I0; any critical gaps were surfaced.
3. The quality check above passes.
4. Platform-specific anti-patterns were avoided.
5. A concrete next step is proposed (e.g., "post to r/subredditname on Tuesday AM," "design the carousel slides in Canva," "run @biz-social repurpose on this for Instagram," "create the thumbnail in 1280x720px before upload").

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

---

## Time budget

| Mode | Time |
|------|------|
| `write` (single platform, short-form) | 15-25 min |
| `write linkedin carousel` | 25-35 min |
| `write linkedin video` (script + shot list + captions + post copy + posting ritual) | 30-45 min |
| `write youtube` (long-form script + title/thumbnail/description) | 35-50 min |
| `write youtube shorts` | 15-25 min |
| `write` (single platform, long-form, e.g. Reddit self-post) | 30-45 min |
| `research` (single platform, focused topic) | 15-25 min |
| `research` (single platform, broad scan) | 25-40 min |
| `repurpose` (one source → one platform) | 15-20 min |
| `repurpose` (one source → all sanctioned platforms) | 60-100 min |
| `strategy` | 10-15 min |
| `plan` | 20-30 min |
| `icp` | 15-25 min |
| `status` | < 2 min |
| `log` (per piece) | 1-2 min |

---

## LinkedIn ICP mode

`@biz-social icp` runs the BIZ-08 LinkedIn Ideal Customer Profile analysis and saves the output to `.work.biz/strategy/linkedin-icp.md`.

This is **not** a biz-writing mode. It produces the targeting brief that makes LinkedIn content and outreach precise.

### Workflow

1. Read `.work.biz/strategy/one-pager.md` and `.work.biz/strategy/target-buyer-profile.md`.
2. If they are missing, run a short probe (≤5 questions) to capture:
   - The niche / target buyer
   - The unified offer
   - The buyer's job titles, seniority, and company stage
   - The buyer's LinkedIn behavior (what they post, comment on, save, share)
   - The pain points and trigger events that make them buy
3. Draft the ICP document following `concepts/linkedin-icp/prompt.md`.
4. Save to `.work.biz/strategy/linkedin-icp.md`.
5. Report: ICP saved; next steps (`@biz-content challenge`, `@biz-social write linkedin`).

### Output format

```markdown
# LinkedIn ICP — {PROJECT_NAME}

LinkedIn ICP analysis: the targeting brief for LinkedIn content and outreach.
Status: Draft — {date}
Needs: {the decision or review required, or `none`}

## Profile signal
- Titles: [list]
- Seniority: [e.g., VP / Director / Founder]
- Company stage: [seed / Series A / established]
- Geography: [if relevant]

## Behavioral signal
- Posts about: [topics]
- Comments on: [topics]
- Saves/shares: [content types]
- Active times: [days / times]

## Pain & trigger
- Top 3 pains: [list]
- Buying triggers: [events that make them look for help]

## Hook language
- Words they use: [list]
- Words that repel them: [list]

## Content fit
- Best formats: [text / carousel / video / newsletter]
- Proof they need: [case studies, metrics, credentials]

## Next action

{one action in the exact syntax to run/type, or `Next action: none — <reason>`}
```

---

## I6 — `status` mode

Read-only. Report what context is loaded, which platforms are actually running, and where the operator's stated plan and real behavior have diverged. Write nothing.

This mode exists to answer "where do I actually stand across platforms", which no other mode covers: `@biz-content status` covers LinkedIn and `@biz-youtube status` covers YouTube, leaving every other platform unreported.

### Workflow

1. Run I0, including the voice profile lookup. Do not ask questions; report gaps instead.
2. Read `.work.biz/strategy/channel-plan.md` for sanctioned channels, their roles, and any "explicitly not channels" list.
3. Read `.work.biz/reference/CONTENT_STATUS.md` for the cross-platform index of what exists.
4. Read every `.work.biz/pipeline/*-tracker.md` for per-platform performance.
5. Read `.work.biz/analysis/` if present for prior performance evidence.
6. Compare and report. Do not soften a divergence.

### Output format

```
CONTENT STATUS — {PROJECT_NAME}

CONTEXT
  Strategy:     <certified <date> | uncertified | absent>
  Voice:        <VOICE_PROFILE.md (locked <date>) | legacy: <path> | none>
  Buyer:        <one line or "absent">
  Primary channel: <from channel-plan or "unspecified">

PLATFORMS
  <platform>  <role>  <cadence committed vs actual>  <last published>  <conversations produced>
  ...

DIVERGENCE
  Producing but not sanctioned:  <platforms with assets but absent from channel-plan>
  Sanctioned but not producing:  <platforms in the plan with no recent activity>
  Cadence drift:                 <platforms under half their committed cadence 3+ weeks>
  On the exclusion list:         <platforms the plan explicitly rules out>

EVIDENCE CHECK
  Reach without conversations:   <platforms with activity and an empty conversations table>
  Untracked platforms:           <platforms with assets but no tracker file>

GAPS
  <what is missing that would materially improve output>

NEXT
  <single highest-leverage action>
```

Close the status report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` / `**Needs your answer:**` / exactly one `**Next step:**`) — the `NEXT` block above does not substitute for this close.

### Reporting rules

1. **Name divergence plainly.** A platform with published assets that the channel plan does not list is drift, not a minor inconsistency. Report it in both directions: producing without sanction, and sanctioned without producing.
2. **Reach without conversations is the headline finding, not a footnote.** If a platform shows sustained activity and an empty conversations table, say that it is producing authority rather than pipeline. That is the single most common and most expensive content failure for a services business.
3. **Never recommend adding a platform from this mode.** Status reports state; it does not expand scope. If the operator asks for more platforms, route to `strategy` mode, which is required to weigh capacity.
4. **Report absent trackers as untracked, not as zero.** No file means unmeasured, and claiming zero performance from missing data is the same error as claiming success from it.

---

## I7 — `log` mode

Record a publish (or a status change) into `.work.biz/reference/CONTENT_STATUS.md`. This is the explicit path for content that shipped outside any publish flow, which is most content: the operator posts a piece from their phone, or a draft written last week goes live without a skill in the loop. Without this mode the tracker starves and every later session loses the publish record.

### Invocation shapes

| User says | Meaning |
|-----------|---------|
| `@biz-social log - <piece> - <platform>` | Record a publish today |
| `@biz-social log - <piece> - <platform> - <url>` | Record with the live URL |
| `@biz-social log - <piece> - <platform> - <date>` | Backdate the publish |
| "I published the RAG post on LinkedIn yesterday" | Same as above; parse piece, platform, date from the sentence |

### Workflow

1. Read `.work.biz/reference/CONTENT_STATUS.md`. If missing, create it from `templates/work/reference/CONTENT_STATUS.md.template` first (self-heal rule).
2. Find the piece in the **Items** table. If it exists as `ready` or `draft`, promote that row; do not add a duplicate. If it does not exist, add a row. Either way, make sure the row names its pillar; if the operator does not know, assign it from the tracker's **By pillar** list and the one-pager.
3. Set status `published`, the publish date, and platform / URL. Ask for the URL only if it materially helps retrieval; never block the record on a missing URL.
4. Refresh the **By platform** row (published count, last publish date, conversations column if one was reported), the **By pillar** row, and the **Summary** counts. Update **Last updated**.
5. Run the file's "What to do after a publish" checklist: platform tracker row (create `pipeline/<platform>-tracker.md` from the template on first publish there), `reference/VOICE_RETRO.md` entry (create from template if missing), `plans/NEXT.md`, `context/HANDOFF.md`.
6. Confirm in one line what was recorded. No commentary beyond that.

### Rules

- `log` never drafts content and never recommends new content. It writes tracker state only.
- If the platform is not in `strategy/channel-plan.md`, still record the publish and flag the drift in the confirmation line, exactly as the tracker's `not sanctioned` rule requires.
- Multiple pieces in one invocation are fine; record each, then confirm as a short list.

---

## Sources and caveats

Benchmarks in this skill are a mix of platform-reported data, widely cited industry studies, and directional rules of thumb observed across creators. Because social-platform algorithms and audience behavior change frequently:

- Treat percentages, multipliers, and reach estimates as **hypotheses to validate**, not guarantees.
- Always cross-check claims against your own analytics, niche data, and primary sources where a business decision depends on them.
- Marks like `[Source: ...]` point to the origin of a specific claim; marks like `[Unverified — directional benchmark]` are heuristics that should be tested in your own account before scaling.

---

## Gates & dependencies

**No hard gate:** `write`, `research`, `repurpose`, `icp`, `log`, and `status` modes can run at any time, like `biz-writing`. Output improves dramatically when the host project is bootstrapped (`@biz-bootstrap init`) and strategy-certified (`@biz-strategy certify`).

**Requires `strategy-ready`:** `strategy` and `plan` modes need a certified strategy (`@biz-strategy certify`) because they commit to a platform mix and publishing calendar.

### Composing with other skills

| Skill | When |
|-------|------|
| `@biz-writing write` | Draft the core long-form content first, then use `@biz-social repurpose` to platform-adapt it |
| `@biz-community find` | Find communities (subreddits, groups, accounts) to post in. Run before `@biz-social write reddit` or `write facebook` |
| `@biz-community engage` | Day-to-day comment engagement — complements platform-specific posts |
| `@biz-content publish` | LinkedIn publishing ops (calendar, tracker, challenge, engagement cadence) |
| `@biz-content challenge` | 30-day LinkedIn plan — run before a batch of `write linkedin` / `write linkedin carousel` / `write linkedin video` drafts |
| `@biz-content challenge - video` | 30-day LinkedIn video challenge — run to build the video habit and gather performance data |
| `@biz-youtube publish` | YouTube publishing ops (tracker, calendar, challenge, status) |
| `@biz-youtube plan` | Capacity-appropriate YouTube cadence and series planning |
| `@biz-strategy certify` | Ensure target buyer and channel plan are defined before committing to a platform strategy |
| `@biz-writing audit` | Audit a draft before platform-adapting it |
| `@biz-social research` | Research trending topics and content gaps before writing |

---

## Related skills

| Skill | When |
|-------|------|
| `@biz-community` | Find and engage with communities across all platforms |
| `@biz-writing` | Draft core content (articles, case studies, long-form) to repurpose |
| `@biz-content` | LinkedIn-specific publishing ops and tracking |
| `@biz-youtube` | YouTube-specific publishing ops, tracker, and 30-day challenge |
| `@biz-brand` | Brand voice, visual identity, and presence audit |
| `@biz-strategy` | Target buyer definition, channel plan |
