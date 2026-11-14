## R3 — LinkedIn Content

### LinkedIn culture fundamentals

LinkedIn is a professional network where content is consumed in the context of career, industry, and business. The audience is busy, skeptical of marketing, but hungry for genuine insight that makes them better at their job or helps them understand their industry.

**The LinkedIn content shift:** LinkedIn has moved from "resume platform" to "professional content platform." Text-only posts, carousels (PDF-style documents), and short videos all perform.

**The distribution shift (2026, and it changes the tactics below).** Distribution moved from a **social graph to an interest graph**: relevance to a topic, not follower count, decides who sees a post. Two consequences that override older advice in this guide.

1. **Dwell time and saves are the dominant signals, ahead of likes.** LinkedIn Engineering describes a "long dwell" binary classifier calibrated per content type and position, deliberately not a fixed word count. Saves are reported at roughly 5x the reach of a like and 2x a comment; comments around 2x a like. Write so a reader stops, expands, finishes, and wants to keep the thing.
2. **A post is live for two to three weeks, not 24 hours.** Relevance-over-recency means posts resurface. The first hour is a launchpad, not the verdict, so do not judge a post at hour two or delete and repost.

Evidence and grades: `docs/sources/verified-sources.md` § LinkedIn distribution (2026). Almost all of it is agency and tool-vendor published, i.e. grade **C**, and the sources contradict each other on format rankings and on whether reach is rising or falling. Treat every multiplier in this guide as `directional`. The corroborated direction is: personal profile over page, 2-3 declared topic territories, dwell and saves over likes, educational over promotional, links out of the post body.

### LinkedIn content types

| Type | Best for | Format specs |
|------|----------|--------------|
| **Text post** | Insights, lessons, stories, hot takes | 150-300 words is the dwell sweet spot: long enough to force the "see more" click, short enough to finish. Short paragraphs. No external links in body. |
| **Carousel / Document post** | Educational deep-dives, frameworks, guides | PDF upload. 4:5 (1080x1350px) or square. Up to 300 pages, but 6-12 is optimal. Each swipe is a fresh attention signal, which is why this format holds dwell best. |
| **Image post** | Data visualization, quote card, announcement | 1.91:1 to 4:5. 1080px minimum width. |
| **Article** | Long-form thought leadership | Native LinkedIn articles. 800-2,000 words. |
| **Video** | Behind-the-scenes, quick tips, personal stories, demos | 30s-90s sweet spot for feed; up to 5 min when depth is justified. Square (1:1) or vertical (9:16). Captions mandatory. See `linkedin-video.md` for full mentor guide. |
| **Poll** | **Deprioritised — do not plan around it** | Reported at ~0.07% engagement in 2026 analyses (grade C). Acceptable as occasional audience research with no reach expectation; never as a growth tactic. 4 options max, 1-2 week duration. |

### LinkedIn post structure

Apply the Universal Platform Format with these deltas:

```
HOOK (first 1-2 lines — this is the only text visible before "see more")
  — Stop the scroll. Specificity > mystery.
  — Bad: "I learned something important today..."
  — Good: "I chose PostgreSQL over MongoDB for a $40k financial platform. Here's why — and what I almost got wrong."

BODY (3-6 short paragraphs)
  — Personal angle: "I" statements build trust faster than "we" or impersonal analysis.
  — Include specific numbers, named technologies, real timelines.
  — Conversational but substantive.

INSIGHT / THE LESSON
  — The sentence people screenshot and share.
  — Must be specific enough that it feels earned, not generic.
  — "The biggest lesson: when your database has 4,900 rules, normalization isn't optional — it's survival."

CTA / ENGAGEMENT PROMPT (optional, context-dependent)
  — Invite conversation, not clicks.
  — "What's your experience with [technology/approach]?"
  — "Has anyone else solved [specific problem] differently?"

LINKS — ZERO-CLICK (corrected 2026)
  — External links in the post body carry roughly a 60% reach penalty (grade C).
  — The first-comment workaround NO LONGER works: it is now detected and
    suppressed too, with reported reductions from ~20-30% up to ~80%.
    This guide used to recommend it. Do not.
  — Keep the post self-contained. The reader should get the whole idea without
    leaving the feed. Put links in the profile Featured section or the bio, and
    say so in plain words ("the full checklist is in Featured") rather than
    dropping a URL.
  — Exception: a native LinkedIn article or document post is on-platform, so it
    carries no outbound penalty. Prefer those when depth is needed.
```

### LinkedIn-specific quality rules

1. **Personal > corporate.** Posts from individual profiles consistently outperform company page posts. Write as a person, not a brand.
2. **Human voice, not literary voice.** No em-dashes, no en-dashes, no flourishes. Short sentences are fine. Contractions are fine. It should sound like you talking to a colleague, not a report.
3. **The first hour is a launchpad, not the verdict.** *(corrected 2026 — this rule used to say the first 60 minutes decide reach.)* LinkedIn tests a post with a small audience and expands on engagement, but relevance-over-recency now keeps posts circulating for two to three weeks. Still post when your audience is active and still answer comments promptly; just do not read a flat first hour as a dead post, and never delete-and-repost on that basis.
4. **Zero-click: no external links in the body, and none in the first comment either.** *(corrected 2026 — the first-comment workaround is now detected and suppressed.)* Make the post self-contained, and route readers to the profile Featured section or bio in words. Native articles and document posts are on-platform and carry no outbound penalty.
4b. **Write for dwell and for saves, not for likes.** Saves are the strongest engagement signal reported (~5x a like, ~2x a comment), and dwell is the classifier LinkedIn actually describes. Practically: a specific promise in the hook, one idea developed properly, and a line worth keeping. A checklist, a worked example, or a decision rule earns a save; an opinion does not.
4c. **Educational beats promotional and beats personal.** 2026 analyses of 10,000+ posts report educational content at roughly 3-5x the reach of personal updates or promotion (grade C). "Knowledge and advice" is what the interest graph distributes to non-followers, which is the entire mechanism by which a cross-border operator reaches buyers who have never heard of them (`concepts/geo-sourcing/prompt.md` §3).
4d. **Declare 2-3 topic territories and stay in them.** Interest-graph distribution rewards topic authority, so a profile that posts about everything is legible to nobody. Pick the territories from `strategy/one-pager.md` pillars; they are the same 3-5 strategic messages the content tracker already requires.
5. **Reply to every comment within the first 2 hours.** This signals high engagement to the algorithm and builds relationship with commenters.
6. **Carousels (document posts) are the highest-reach format.** LinkedIn's algorithm currently favors document uploads. A well-designed 6-12 slide carousel can outperform text-only posts 3-5x [Unverified — directional benchmark based on LinkedIn creator reports; test with your own analytics].
7. **Video builds the deepest trust.** Native video lets the audience hear your voice and decide if you are the person they want to hire. Use `@biz-social write linkedin video` for full scripting, shooting, editing, and analytics guidance.
8. **Tag strategically.** Tag relevant people only if they would genuinely want to see the post. Random tagging = spam.
9. **Hashtags: 0-3, and treat them as near-obsolete.** *(tightened 2026 from "3-5 max".)* 10 or more is reported as an outright visibility penalty, and semantic analysis now does the topic-matching work hashtags used to do. Zero is acceptable and often best; if used, use the same small set tied to your declared territories.
10. **Founder-led, always.** Personal profiles make up roughly two-thirds of a user's feed and draw about 5x the engagement of company pages; founder/CEO content around 4x (grade C, corroborated across two sources). A solo consultant or fractional operator has no reason to post from a page. If a company page exists, it republishes what the person already posted; it does not replace them.
11. **Assume a slop filter is reading your post.** LinkedIn is reported to tag templated posts and specific vocabulary as low-quality, and one 2026 analysis claims over half of long-form posts are now AI-generated. The banned-vocabulary list in `standards/20260621-CONTENT-STANDARD.md` § Vocabulary red flags is therefore a reach rule here, not only a taste rule: "delve" and "landscape" are named in the reporting.

### LinkedIn anti-patterns (DO NOT)

- "Agree?" posts (engagement bait, algorithm now penalizes)
- "Copy-paste this if you agree" (spam, penalized)
- **Link in the first comment** — corrected 2026; detected and suppressed, reported 20-80% reach reduction. This guide recommended it before v0.7.0.
- **Polls as a growth tactic** — ~0.07% engagement reported; acceptable only as no-expectation audience research
- **10+ hashtags**, or the same hashtag block pasted on every post (looks automated)
- **Back-to-back text-only posts** — reported suppression up to ~20%; alternate formats
- **Engagement pods** — detectable under LLM-based ranking, and the audience they produce is not the buyer
- **"Post and ghost"** — publishing then disappearing; staying to answer in 3+ sentence comments is part of the tactic, not a courtesy
- **Judging a post at hour two** — posts circulate for two to three weeks now
- Em-dashes (—) or en-dashes (–) in post copy
- Literary flourishes: "tapestry", "journey", "symphony", "landscape", "ecosystem"
- "Most people… but the top 1%…" template posts
- Personal stories with no professional insight payoff
- Political/religious content unless directly relevant to your professional niche
- Posting more than 2x/day (diminishing returns, audience fatigue)
- **Any claim that the copy is "undetectable" or "AI-proof"** — forbidden by `standards/20260621-CONTENT-STANDARD.md` § Lead-facing artifacts rule 2, and unfalsifiable besides

### LinkedIn posting time

- Best: Tuesday-Thursday, 8-10 AM or 12-1 PM local audience time
- Second-best: Monday and Friday, same windows
- Avoid: weekends, late nights
- Test and verify for your specific audience

### LinkedIn carousel (document post)

Use when the topic is a **framework, checklist, or step-by-step** — content the ICP would save. Invoke via `write linkedin carousel - <topic>`.

**Specs:** 6–12 slides · 1080×1350px (4:5) or 1080×1080px · PDF upload · ≤40 words per slide

**Deliverable structure:**

```
SLIDE 1 — HOOK
  Title only. The reason to swipe. Specificity > mystery.

SLIDES 2–N — ONE IDEA PER SLIDE
  Headline (≤8 words) + 1–2 supporting lines max.
  Progressive logic: problem → insight → steps → outcome.

FINAL SLIDE — INSIGHT + CTA
  The screenshot-worthy line + conversation prompt (not "DM me").

COMPANION CAPTION (for the post above the document)
  2–4 lines max. Restates hook. No external links.

LINKS — ZERO-CLICK
  None on the slides, none in the caption, none in the first comment.
  The document post is itself the deliverable, so there is no reason to
  send the reader off-platform. If a resource must be referenced, name it
  in words and point to the profile Featured section.

DESIGN NOTES
  Left-aligned text, high contrast, one visual concept per slide.
  No stock photos. Brand colors if loaded from brand guide.
```

**Carousel quality rules:**

1. Slide 1 must work without context — it's the thumbnail in feed.
2. Each slide must be satisfying alone (partial swipes happen), and every swipe is a dwell signal, which is why this format outperforms on the metric LinkedIn actually measures.
3. Prefer numbered frameworks ("3 mistakes…", "5-step…") when the topic allows.
4. Zero-click, same as every other LinkedIn format: no URLs on slides, in the caption, or in the first comment. See § LINKS — ZERO-CLICK above.

### LinkedIn native video

Use when you want to **build trust faster than text or carousel can**. Video lets the audience hear your voice, see your work, and decide whether you are the expert they want to hire. Invoke via `@biz-social write linkedin video - <topic>`.

**Quick reference:**

| Element | Rule |
|---------|------|
| Length | 30–90 seconds for feed; 3–5 minutes only when depth is justified |
| Aspect ratio | 1:1 (square) or 9:16 (vertical); native upload only — no external links |
| Captions | Mandatory and burned-in; most viewers watch without sound |
| First frame | Treat as the thumbnail: face or clear visual + hook text overlay |
| Structure | 0–3 sec hook → one idea with proof → screenshot-worthy lesson → conversation CTA |
| CTA | Ask a professional question; never "DM me" or external link in post copy |
| Posting ritual | First comment within 60 seconds; engage heavily in first 60 minutes |

For the complete production mentor guide — scripting, shooting, editing, captions, equipment, analytics, 30-day challenge, and repurposing — see `skills/biz-social/platforms/linkedin-video.md`.

---

## Research methods

When running `@biz-social research linkedin`, use these methods:


| Method | How to execute |
|--------|---------------|
| **Industry conversation scan** | Search relevant industry terms on LinkedIn. Sort by "Top" and "Latest." What are the active debates? Who's driving conversation? |
| **Competitor content audit** | Review last 20 posts from 5 accounts in the project's space. Note hook styles, formats, engagement patterns, and comment quality. |
| **Content white space** | Identify topics that the project's target buyer cares about but no one is covering well on LinkedIn. Look for shallow posts with high engagement — these are opportunities to go deeper. |
| **Hashtag analysis** | Search 3-5 niche hashtags. What content performs best? What's oversaturated? What's absent? |
| **Poll & question mining** | Find polls and question posts in the space. What gets votes? What gets comments? What reveals audience uncertainty? |

