# BIZ-07: Content Platform Algorithms

## Purpose

Every social platform uses a distinct algorithm to determine which content reaches which people and how far it spreads. Understanding these signals is not optional — it is the difference between content that grows a business and content that gets zero reach. This concept applies whenever content is generated for any social platform.

## Questions to explore

1. Which platforms does the target buyer actually use? (LinkedIn, Reddit, X/Twitter, Instagram, Facebook, TikTok, YouTube, Threads?)
2. What content format does each platform's algorithm reward? (Video, carousel, text-only, thread, document?)
3. What engagement signals does each platform prioritize? (Saves, shares, comments, DMs, watch time, dwell time?)
4. What behaviors does each platform penalize? (External links, engagement bait, cross-posted content, reposted content?)
5. What timing and frequency does each platform's algorithm favor? (Best days, hours, posting cadence?)
6. Are there platform-specific anti-patterns to avoid? (e.g., "Agree?" on LinkedIn, "DM me" on Reddit?)
7. Does the content strategy account for the platform's link-handling rules?

## Output

- Platform selection: which platforms to focus on, in priority order
- Per-platform format mapping: which content type for which platform
- Link strategy per platform: where links go (body, comment, bio, none)
- Timing recommendations per platform
- Anti-pattern checklist per platform

## Platform algorithm rules (binding)

### LinkedIn
*(Corrected 2026 against `docs/sources/verified-sources.md` § LinkedIn distribution. Full detail and the grade warnings live in `skills/biz-social/platforms/linkedin.md`; these bullets must not contradict it.)*
- **Zero-click: no external links in the body AND none in the first comment** — the first-comment workaround is now detected and suppressed (reported 20-80% reach reduction). This bullet used to recommend it
- **The first hour is a launchpad, not the verdict** — relevance-over-recency keeps posts circulating 2-3 weeks; do not judge or repost at hour two
- **Dwell time and saves are the dominant signals, ahead of likes** — a "long dwell" classifier per content type and position; saves reported ~5x a like, ~2x a comment
- **Interest graph, not social graph** — topic relevance decides reach to non-followers, so declare 2-3 topic territories and stay in them
- **Carousels and document posts** have the highest organic reach (3-5x text-only, `directional`)
- **Educational beats promotional and personal** (~3-5x reach, grade C)
- **Personal profiles outperform company pages** (~5x engagement) — write as a person, founder-led
- **0-3 hashtags; 10+ is a visibility penalty** and semantic analysis now does the topic matching
- **Polls are effectively dead** (~0.07% engagement) — audience research only, never a growth tactic
- **Meaningful comments** (multi-sentence) > likes; "post and ghost" suppresses you
- **Reply to every comment within 2 hours** to signal engagement
- **An AI-slop filter is reported to tag templated posts and specific vocabulary** — the Content Standard's banned-vocabulary list is a reach rule here, not only taste
- **Best posting time:** Tue-Thu, 8-10 AM or 12-1 PM local audience time
- **Anti-patterns:** "Agree?" (engagement bait, now penalized), "Copy-paste this", personal stories with no professional payoff, same hashtags on every post
- **Creator challenges:** `#CreateImpact` and similar — 2–4 posts/week, ≥1 carousel/week, challenge hashtag on one post/week; use `@biz-content challenge`
- **LinkedIn ICP:** BIZ-08 (`concepts/linkedin-icp/prompt.md`) — calibrate hooks and formats to titles that comment, not lurk

### Reddit
- **Upvote/downvote ratio** is the core ranking signal — net sentiment matters
- **Community-specific rules are supreme** — each subreddit has its own moderation, culture, and self-promotion policies
- **Self-promotion ratio:** roughly 10:1 value-to-promo is the safe zone
- **Title quality is everything** — first impression, cannot be edited
- **Recency** drives visibility — fresh posts get more traction in active subreddits
- **Comment quality matters** — a comment with 9 upvotes and 2 downvotes ranks higher than one with 1 upvote
- **Text posts** often outperform link posts in discussion-heavy subreddits
- **Timing:** post when the subreddit's target demographic is most active (check subreddit traffic stats)
- **Anti-patterns:** link-dropping without engagement, posting the same link to multiple subreddits, marketing-speak, asking for upvotes

### X (Twitter)
- **External links reduce reach** but are not banned — use sparingly
- **Semantic AI** maps content to topic vectors — natural language outperforms keyword stuffing
- **Profile Reputation Score** — active, engaged accounts earn higher baseline visibility
- **First tweet must hook in under 280 chars** — the expandable thread model depends on scroll-stopping openers
- **Recency** drives "What's Happening" / trending sections
- **Threads (5-8 tweets)** perform well for depth; short standalone posts for hot takes
- **Visual content** (images, video clips) increases engagement rates
- **Community Notes** can flag content — factual accuracy matters
- **Best posting time:** Tue-Fri, 9 AM-1 PM local audience time
- **Anti-patterns:** engagement bait ("RT if you agree"), massive hashtag blocks, cross-posting Instagram captions verbatim

### Instagram
- **DM shares are the premier engagement signal** — the algorithm aggressively favors content shared via DM over passive likes
- **No clickable links in captions** — only one link in bio; use "link in bio" CTA or Stories link sticker
- **Reels get highest reach** — short-form video is the primary discovery engine
- **Watch time and retention** are the primary quality signals for Reels
- **Originality engine** actively down-ranks reposted, watermarked, or aggregated content
- **Separate algorithms** for Feed, Stories, Explore, Reels, and Search — each with distinct signals
- **Carousel posts** (multiple images/slides) get higher engagement than single images
- **Stories** drive engagement to feed posts — use them to prime your audience
- **3-5 hashtags** — skip oversaturated tags (#marketing with 175M posts → #B2BMarketingStrategy with <500K)
- **Posting consistency** matters more than raw frequency
- **Anti-patterns:** recycled TikTok watermarked content, link-in-caption (unclickable anyway), 30-hashtag shotgun, posting only static images

### Facebook
- **External links are penalized** — prefer native content. *(The "link in first comment" workaround this bullet used to recommend is **unverified for Facebook** and is confirmed suppressed on LinkedIn as of 2026; do not assume it transfers. No 2026 Facebook-specific evidence is in the catalog, so treat this whole section as `directional` and test on the project's own page.)*
- **Groups have much higher organic reach than Pages** — community-focused distribution is rewarded
- **Personal profiles > business pages** for organic reach
- **Native video gets highest reach** — upload directly, don't link to YouTube
- **"Meaningful interactions"** are prioritized — conversations between people, not one-way broadcasting
- **Recency** is a primary ranking signal
- **Engagement between people** matters more than engagement with brand content
- **Best posting time:** Wed-Thu, 10 AM-3 PM local audience time
- **Anti-patterns:** link-dropping to external sites, engagement bait, over-posting (diminishing returns)

### Cross-platform universal rules

- **Early engagement matters on every platform, but it is not the whole verdict anywhere.** *(Corrected 2026: this rule used to claim the first 60 minutes are the strongest signal on every platform.)* LinkedIn's relevance-over-recency now keeps posts circulating for two to three weeks, so a flat first hour is not a dead post. Answer comments promptly everywhere because it builds the relationship and adds a signal, not because a 60-minute window closes.
- **Platform-native content** outperforms cross-posted content every time
- **Engagement quality (saves, shares, comments) > volume (impressions, passive likes)**
- **Consistency > frequency** — a regular cadence builds algorithmic trust
- **Video/visual content** consistently outperforms text-only across all platforms
- **Reply to engagement** — responding to comments in real time doubles as an algorithmic signal
- **Experiment with new features early** — platforms reward early adopters with bonus reach
