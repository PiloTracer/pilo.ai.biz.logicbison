## R3V — LinkedIn Native Video

LinkedIn video is the most under-used, high-trust format on the platform. While carousels currently win on raw reach, video wins on **relationship**: viewers hear your voice, see your face, and decide whether you are the person they want to hire. Done well, a 60-second LinkedIn video converts a scroll into a conversation better than a 300-word text post.

This guide treats LinkedIn video as a **teachable production discipline**, not a repurposing afterthought. Use it as a mentor for planning, shooting, editing, posting, and improving LinkedIn native video.

---

### LinkedIn video culture fundamentals

- **Professional context, human delivery.** The audience is on LinkedIn to advance their career or business, but they respond to people, not brands. Speak as a competent peer, not a corporate spokesperson.
- **Silent autoplay dominates.** 70–80% of LinkedIn feed video is watched without sound [Unverified — directional benchmark based on platform behavior reports; test with your own analytics]. The first frame, captions, and on-screen text must carry the hook before anyone presses play.
- **Brevity wins in feed.** 30–90 seconds is the sweet spot for feed-native video. Longer videos (3–5 min) work only when the topic justifies depth and the viewer is already warm.
- **Native upload outperforms links.** Always upload the video file directly to LinkedIn. Links to YouTube, Loom, or Vimeo get throttled.
- **The first hour is a launchpad, not the verdict.** *(Corrected 2026 — this used to say the first 60 minutes rule.)* Early engagement still helps LinkedIn decide whether to expand distribution, but relevance-over-recency now keeps posts circulating for two to three weeks. Post when you can be present to reply, and do not judge a video by its first hour or repost it. See `docs/sources/verified-sources.md` § LinkedIn distribution (2026), grade C.

---

### LinkedIn video content types

| Type | Length | Best for | Production style |
|------|--------|----------|------------------|
| **Talking-head tip** | 30–90 sec | Quick wins, contrarian takes, lessons learned | Single angle, face to camera |
| **Screen + voice** | 60–180 sec | Demos, before/after metrics, tool walkthrough | Screen recording + voiceover; optional face bubble |
| **Behind-the-scenes (BTS)** | 30–90 sec | Project updates, build process, real work | Mobile/handheld, authentic, low polish |
| **Story/reaction** | 60–120 sec | Client lesson, failure, industry observation | Talking head with cutaways or text overlays |
| **Carousel-to-video** | 30–60 sec | Turn a saved carousel into a narrated summary | Voiceover + slide visuals |
| **Interview / conversation clip** | 60–180 sec | Social proof, expertise borrowed from others | Two-person capture or split screen |

**Rule:** Pick one type per video. A talking-head tip that randomly cuts to a screen demo confuses the viewer.

---

### `@biz-social write linkedin video - <topic>` — Full deliverable

Invoke this mode when the user wants a complete LinkedIn video production package: script, shot list, captions, post copy, and posting ritual.

#### Step 1 — Choose the video type

Resolve from the topic and audience:

1. Which type from the table above fits the idea?
2. What is the single takeaway a viewer should remember?
3. What is the proof point (number, name, screenshot, timeline, failure mode)?
4. What emotion should the viewer feel? (curiosity, relief, urgency, recognition)

#### Step 2 — Draft the script

Use this structure. Every section has a job.

```
FIRST FRAME (silent preview)
  — Big, readable text overlay summarizing the hook.
  — Face or relevant visual visible. Avoid black screens or title cards.
  — Example text: "This Postgres mistake cost us 6 days."

0–3 SECOND SPOKEN HOOK
  — Start mid-sentence. No intro music, no "Hey everyone."
  — Match the first-frame promise instantly.
  — Example: "We almost shipped a query that would have tanked the launch."

BODY (one idea, 2–4 short beats)
  — Beat 1: Set up the problem or context in one sentence.
  — Beat 2: Show the proof — screen recording, number, named client/industry, timeline.
  — Beat 3: Reveal the insight or decision point.
  — Beat 4 (optional): Contrast the common mistake with what you did instead.
  — Each beat should be 1 sentence spoken + 1 corresponding text overlay.

LESSON / Screenshot-worthy line
  — The single sentence people would quote.
  — Make it specific enough that only you could say it.
  — Example: "If your query plan shows a sequential scan on a 1M-row table, the index isn't the problem — your data model is."

CTA / CONVERSATION PROMPT
  — Invite a professional response, not a click.
  — Good: "What's the worst query you've seen in production?" or "Has anyone else hit this with Postgres?"
  — Bad: "DM me," "Link in bio," or "Agree?"
```

#### Step 3 — Build the caption + on-screen text plan

```
CAPTION FILE (SRT or burned-in)
  — Caption every spoken word.
  — Keep lines short: ≤32 characters, ≤2 lines at a time.
  — Sync captions to the spoken beat, not just the sentence end.
  — Highlight the hook line in the first 3 seconds.

ON-SCREEN TEXT OVERLAYS
  — Use for the key proof point, the lesson, and the CTA.
  — One phrase per overlay. Do not transcribe the whole video.
  — Font: clean sans-serif, high contrast, large enough to read on mobile.
  — Place in the safe zone: top/bottom 10% of vertical video can be cropped by feed UI.
```

#### Step 4 — Shot list

```
SHOT 1 — HOOK (0:00–0:03)
  Visual: [talking head / screen / BTS clip]
  On-screen text: [first-frame hook text]
  Audio: [first spoken line]

SHOT 2 — CONTEXT (0:03–0:15)
  Visual: [talking head or cutaway]
  On-screen text: [problem statement]
  Audio: [set up the situation]

SHOT 3 — PROOF (0:15–0:45)
  Visual: [screen recording / document / prop / gesture]
  On-screen text: [number or key fact]
  Audio: [proof point]

SHOT 4 — LESSON (0:45–1:05)
  Visual: [back to talking head]
  On-screen text: [screenshot-worthy line]
  Audio: [deliver the lesson]

SHOT 5 — CTA (1:05–1:15)
  Visual: [talking head]
  On-screen text: [question prompt]
  Audio: [ask the question]
```

#### Step 5 — Post copy + resource routing

```
POST COPY (above the video)
  — 2–4 lines. Restate the hook. Add one line of context.
  — No external links. No hashtags in the first line. 0–3 hashtags total, or none.
  — Example:
    "This one Postgres mistake almost delayed the launch by a week.

    60 seconds on what we caught — and the query plan rule we now check every time."

RESOURCE ROUTING (zero-click — corrected 2026)
  — Do NOT put links in a first comment. That workaround is now detected and
    suppressed on LinkedIn, reported at 20–80% reach reduction. This guide
    recommended it before v0.7.1.
  — Put the resource in the profile Featured section or the bio, then name it
    in words in the post copy.
  — Example: "Full case study with the query plan screenshots is in Featured."
  — The video is native and on-platform, so it carries no outbound penalty.
    Let it be the whole deliverable.
```

#### Step 6 — Deliver

Provide:

1. **Video script** (spoken lines + on-screen text + timing)
2. **Shot list** (what to capture)
3. **Caption file template** (or guidance for burned-in captions)
4. **Post copy** (above-video text)
5. **Resource routing note** — where links live instead (profile Featured or bio), never a first comment
6. **Platform notes** — why this works for LinkedIn specifically
7. **Equipment setup** — minimum or upgraded
8. **Posting time suggestion**
9. **Engagement plan** — first two hours, and the two-to-three-week tail

---

### LinkedIn video format specs

| Spec | Requirement |
|------|-------------|
| **Length** | 3 seconds minimum; 10 minutes maximum. Sweet spot: 30–90 seconds for feed. |
| **Aspect ratio** | 1:1 (square) or 9:16 (vertical). 1:1 is safest for desktop + mobile feed. 9:16 maximizes mobile real estate. Avoid 16:9 unless repurposing long-form. |
| **Resolution** | Minimum 1080px on shortest side. 1080×1080 (square) or 1080×1920 (vertical). |
| **Frame rate** | 24–30 fps. |
| **File size** | ≤5 GB, but keep feed videos under 500 MB for upload speed. |
| **Format** | MP4 with H.264 codec. AAC audio. |
| **Captions** | Mandatory. Burned-in recommended for silent autoplay; SRT optional for accessibility. |
| **Thumbnail** | LinkedIn auto-selects a frame. Ensure your first frame is your intended thumbnail. |

---

### 10 proven LinkedIn video hook formulas

Use these as starting patterns. The best hook is specific to your actual experience.

| # | Formula | Example |
|---|---------|---------|
| 1 | **The mistake** | "I almost recommended Kafka for a 1,000-user app. Here's why I changed my mind." |
| 2 | **The number** | "This change cut our API latency from 1.2 seconds to 90 milliseconds." |
| 3 | **The contrarian** | "I don't think most early-stage startups should hire a CTO first." |
| 4 | **The client story** | "A founder told me their last agency billed 80 hours for a login page. I refused to do the same." |
| 5 | **The before/after** | "Six weeks ago this dashboard took 14 seconds to load. Today it takes 0.4." |
| 6 | **The question** | "What's the #1 sign a rebuild is coming? I look for this one pattern." |
| 7 | **The rule broken** | "We broke the 'never rewrite' rule. It was the right call — here's the test we passed first." |
| 8 | **The hidden cost** | "The real cost of that 'free' Shopify plugin was 40 hours of cleanup." |
| 9 | **The framework** | "I use 3 questions to decide if AI actually belongs in a workflow." |
| 10 | **The moment** | "This is the exact moment I knew the project would fail." |

**Rule:** If you can replace your company name with anyone else's and the hook still works, it is too generic.

---

### On-camera delivery guide

Most LinkedIn video underperforms because the speaker sounds like they are reading a press release. Fix it with these rules.

1. **Look slightly past the lens, not at yourself.** If using a phone, mark the lens with a tiny sticker so your eye line lands near it.
2. **Energy 20% above normal conversation.** Monotone kills retention. Practice the first line until it sounds like you mean it.
3. **Use your hands.** Gestures make you believable and keep the frame alive.
4. **One idea per video.** Do not tack on a second lesson because you have time.
5. **Pause before the lesson.** A half-second pause before the screenshot-worthy line makes it land harder.
6. **Record multiple takes of the hook.** The first 3 seconds determine whether someone keeps watching. Get it crisp.
7. **Do not apologize.** No "sorry for the lighting," "just a quick thought," or "this is rough." Own the frame.

---

### Captions, accessibility, and silent playback

- **Burned-in captions are the default for feed video.** They guarantee silent viewers get the message.
- **Use SRT only as a supplement.** LinkedIn accepts SRT uploads, but many viewers never enable them.
- **Caption style rules:**
  - Max 2 lines per caption block.
  - Max 32 characters per line.
  - Keep captions on screen for at least 1 second.
  - Use sentence case, not ALL CAPS.
  - Use [brackets] for sound effects or [music] only when relevant.
- **Safe zones:** Keep all text inside the center 80% of the frame. LinkedIn feed UI can crop edges.
- **Color contrast:** White text with a dark outer glow or black box. Never place light text on a light shirt or background.

---

### First-frame / silent-autoplay optimization

The first frame is your thumbnail. Most viewers decide whether to watch based on it.

- **Show a face or a clear visual.** No blank title cards, no animated logos, no "Episode 12" graphics.
- **Overlay the hook text.** The first frame should already contain the core promise in large text.
- **Avoid motion blur.** Pick a clean frame if LinkedIn auto-selects, or design your opening to be still for 1 second.
- **Match the caption to the visual.** If the text says "This query almost killed the launch," the visual should show the query, the dashboard, or your face mid-explanation — not a stock office photo.

---

### Production setup

#### Minimum viable setup (good enough to start)

| Item | Recommendation |
|------|----------------|
| Camera | Smartphone made in the last 4 years |
| Audio | Wired lapel mic or phone earbuds with mic |
| Lighting | Face a large window; record during daylight |
| Stability | Stack of books or a $20 phone tripod |
| Editing | CapCut, Descript, or phone-native editor |
| Captions | Auto-captions in CapCut/Descript, then corrected |

#### Upgraded setup (when video becomes a primary channel)

| Item | Recommendation |
|------|----------------|
| Camera | Mirrorless (Sony ZV-E10, Canon R50) or high-end phone |
| Audio | Shotgun or wireless lapel mic (Rode, DJI Mic) |
| Lighting | Key light + fill light or softbox kit |
| Background | Clean, relevant wall or shallow depth-of-field office |
| Teleprompter | Optional for scripted talking-head tips |
| Editing | Descript, DaVinci Resolve, or Adobe Premiere |

**Rule:** Better audio beats better video. Viewers forgive soft lighting; they do not forgive bad sound.

---

### Editing rhythm guide

LinkedIn video pacing should feel slightly faster than a YouTube tutorial but slower than a TikTok clip.

- **Cut every 3–7 seconds** if the visual is static talking head. Hold screen recordings longer so viewers can read.
- **Use text overlays as punctuation.** Every time you state a key point, show it on screen.
- **Add a subtle zoom or position shift** at the 10–15 second mark to reset attention.
- **Keep music optional and quiet.** If used, keep it below -20 dB so it does not fight your voice.
- **End on your face, not a graphic.** People connect with people.

---

### Posting ritual for LinkedIn video

1. **Upload the MP4 directly.** Do not paste a YouTube, Loom, or Vimeo link.
2. **Write post copy** (2–4 lines, no external links).
3. **Hashtags: 0–3, or none.** *(Tightened 2026 from "3–5".)* 10+ is a reported visibility penalty and semantic analysis now does the topic matching.
4. **Post when you can engage.** Tuesday–Thursday, 8–10 AM or 12–1 PM local audience time.
5. **Zero-click — no first comment with links.** *(Corrected 2026 — this guide used to say "first comment within 60 seconds".)* The first-comment workaround is now detected and suppressed on LinkedIn, reported at 20–80% reach reduction. Put resources in the profile Featured section or bio and name them in words in the post copy.
6. **First two hours:** reply to every comment in 3+ sentences, and comment on 5–10 posts from your target buyer. Do this because it builds the relationship and adds a signal, not because a 60-minute window closes.

---

### Engagement protocol

- **Reply to every comment in the first 2 hours.** This is non-negotiable for algorithmic distribution.
- **Ask a follow-up question in your reply.** Keep the thread alive.
- **Pin a strong comment** if one surfaces a key point or asks a useful question.
- **Do not argue.** If someone disagrees, acknowledge and invite a direct message if it needs depth.

---

### Analytics interpretation

Track these metrics per video in your content tracker (`@biz-content status`).

| Metric | What it tells you | Action if low |
|--------|-------------------|---------------|
| **Views / impressions** | Distribution | Posting time, hook, or network size is off. |
| **3-second views** | Hook effectiveness | Rewrite the first frame and opening line. |
| **Watch time / average % watched** | Retention | Cut slower sections, add more proof points, tighten pacing. |
| **Engagement rate** | Resonance | Topic may not match audience pain; revisit `linkedin-icp.md`. |
| **Comments vs. likes** | Conversation quality | Comments > likes means the CTA worked. |
| **Follower growth** | Long-term channel value | Keep going; video compounds trust over time. |

**Benchmarks (directional, validate with your own data):**

- 3-second view rate: >30% is decent, >50% is strong.
- Average % watched: >40% is good for feed video.
- Engagement rate: >2% is healthy for B2B video.

---

### Failure modes and fixes

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Lots of impressions, few 3-second views | Weak first frame / hook | Redesign first frame; test 3 different openings. |
| 3-second views high, watch time low | Body drags or lacks proof | Cut every sentence that does not advance the single idea. |
| Views high, comments low | CTA too weak or too self-promotional | End with a specific, professional question. |
| Comments are generic ("Great point!") | Insight too generic | Add a number, name, or contrarian angle. |
| Consistent <200 views after 6 videos | Network too small or topic mismatch | Add 10 relevant connections/week; revisit ICP hooks. |
| Audio sounds hollow or distant | Bad recording environment | Record in a smaller room, closer to mic, with soft surfaces. |
| Captions hard to read | Font too small or poor contrast | Use 60+ pt mobile-sized text with dark outline/box. |

---

### 30-day LinkedIn video challenge

Use this to build the video habit and gather data.

| Week | Frequency | Focus |
|------|-----------|-------|
| **Week 1** | 2 videos | Talking-head tips using hook formulas 1–3. |
| **Week 2** | 2 videos + 1 screen/voice demo | Mix formats; test which gets better watch time. |
| **Week 3** | 3 videos | Add BTS or story format; test emotional vs. tactical hooks. |
| **Week 4** | 3 videos | Double down on the best-performing format from weeks 1–3. |

**Daily non-post ritual:** 10 minutes of genuine comments on target buyer posts before you publish.

**Weekly review:** After each video, log format, hook formula, 3-second view rate, watch time, and top comment. After 8 videos, identify the winning hook × format combination.

---

### Repurposing to and from LinkedIn video

| Source | LinkedIn video output |
|--------|----------------------|
| **LinkedIn text post** | Turn the strongest insight into a 60-sec talking-head script. |
| **LinkedIn carousel** | Narrate the carousel as a 45–90 sec video with slide visuals. |
| **YouTube long-form** | Cut one 60–90 sec segment with a strong standalone hook. |
| **YouTube Shorts** | Upload directly if under 90 sec and vertical; add LinkedIn-specific caption. |
| **Twitter/X thread** | Pick the contrarian tweet and react to it on camera. |
| **Blog article / case study** | Summarize one lesson in 60 seconds with one proof point. |
| **Client call / demo** | Screen-record a 60-sec demo of the most impressive moment. |

| LinkedIn video | Other outputs |
|----------------|---------------|
| **Talking-head tip** | Transcribe into a LinkedIn text post; 3–5 slides for a carousel; clip for Shorts/Reels. |
| **Screen demo** | Expand into a YouTube tutorial or blog case study. |
| **Story/reaction** | Rewrite as a newsletter anecdote or X thread. |

---

### LinkedIn video quality check

Before delivering or publishing, verify:

- [ ] Single clear takeaway — one idea only.
- [ ] Hook lands in the first 3 seconds (spoken + visual + text).
- [ ] First frame works as a silent thumbnail.
- [ ] At least one specific proof point (number, name, screenshot, timeline).
- [ ] Captions burned in and readable on mobile.
- [ ] On-screen text limited to key beats, not full transcription.
- [ ] No external links in post copy.
- [ ] CTA is a conversation prompt, not "DM me."
- [ ] Audio is clear and free of echo/background noise.
- [ ] Lighting shows your face; no harsh shadows or blown-out window behind you.
- [ ] Video uploaded natively, not linked from another platform.
- [ ] Engagement plan covers the first two hours and the two-to-three-week resurfacing tail.
- [ ] Zero-click: no external link in the post copy **and none in a first comment**.
- [ ] Hashtags 0–3, not 3–5 and never 10+.
- [ ] AI-artifact scan passed: no em-dash overuse, hedging fillers, generic transitions, passive voice, or empty intensifiers in the spoken script.

---

### Research methods for LinkedIn video

When running `@biz-social research linkedin` with video intent, add these methods:

| Method | How to execute |
|--------|---------------|
| **Video-first account audit** | Find 5 accounts in your niche that post native video weekly. Note hook style, video length, first-frame design, caption style, and comment quality. |
| **Hook pattern mining** | Scroll LinkedIn with sound off for 10 minutes. Save the first 3 videos that made you stop. Analyze their first frame and opening line. |
| **Silent-autoplay test** | Watch 10 videos without sound. Which ones still communicated value? Which failed? Note the difference. |
| **Comment-desire mapping** | On popular videos in your space, what do commenters ask for? These are your next video topics. |
| **Format test plan** | Post the same core insight as a text post, carousel, and video in the same week. Compare reach and engagement to learn your audience's preference. |

---

### Mentor principles for LinkedIn video

1. **Consistency beats virality.** One video per week for a year beats one viral video and silence.
2. **Your face is the brand.** The more someone sees you explain ideas well, the more they trust you with money.
3. **Teach what you actually know.** The camera exposes bluffing faster than text.
4. **Data teaches; ego resists.** If a video flops, diagnose the hook or the topic, not the algorithm.
5. **Start ugly, get better.** The first 10 videos are practice. Publish them anyway.
