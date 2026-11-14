---
name: biz-brand
description: >-
  Audit and overhaul your LinkedIn profile, website, and brand assets to
  match your unified offer. biz-brand audit, biz-brand overhaul, biz-brand status.
---

# Skill: biz-brand — Brand Audit & Overhaul

## Overview

This skill covers three modes:

| Mode | Command | Description |
|------|---------|-------------|
| **audit** | `biz-brand audit` | Read-only assessment of current LinkedIn, website, and brand assets against the unified offer |
| **overhaul** | `biz-brand overhaul` | Full rewrite of LinkedIn profile, website positioning, and brand asset consistency |
| **status** | `biz-brand status` | Read-only state report of current brand configuration |

**Lead-facing floor (binding).** LinkedIn headline, About section, experience entries and website positioning copy are read by a buyer forming a first judgement in seconds, so `standards/20260621-CONTENT-STANDARD.md` § Lead-facing artifacts binds on everything `overhaul` writes. Run the AI-artifact scan before delivery and report that it ran. Profile copy is the worst place for generated prose, because it is the one artifact whose entire job is to sound like a specific person. Never describe output as undetectable or AI-proof; § Lead-facing artifacts rule 2 forbids the claim.

---

## I0 - Gate pre-check

Before any mode executes, read `{WORK_BUSINESS_ROOT}/gates.md`. A gate is met only when its `**Status:**` starts with the word `PASS`; trailing commentary after `PASS` is fine and does not change the verdict.

- If the file does not exist, or `strategy-ready` is not PASS, stop and emit:

```text
BLOCKED (prerequisite): strategy-ready not certified
  Required state: {WORK_BUSINESS_ROOT}/gates.md with strategy-ready PASS
  Current state: <what was found>
  To proceed: run `@biz-strategy greenfield` then `@biz-strategy certify`
```

- Exception: `status` mode is read-only and runs without the gate.

---

## 1. Audit Mode — `biz-brand audit`

Run this first. It does not change anything.

### 1.1 LinkedIn Audit

Check each of these and report pass/fail:

| Check | Pass | Fail |
|-------|------|------|
| Headline tells a stranger what you do + who you help within 5 seconds | | |
| Headline contains zero skill-lists ("\|" separators, comma lists) | | |
| About section opening (first 2-3 sentences) states one clear offer | | |
| About section includes proof (specific project outcomes) | | |
| About section ends with a CTA | | |
| Featured section contains 3 items that reinforce the same offer | | |
| Banner image has text overlay matching the offer | | |
| Recent 3 posts/comments are on-topic | | |

### 1.2 Website Audit

| Check | Pass | Fail |
|-------|------|------|
| Homepage headline states one offer (not a list of services) | | |
| No generic service-box grid (SEO, Hosting, ERP, etc.) | | |
| Case studies or portfolio is present and linked from homepage | | |
| Calendly link is prominent (top nav, hero, or footer) | | |
| Analytics (Plausible, Umami, or GA4) is installed | | |
| SEO schema (JSON-LD for Person or Organization) is present | | |
| "Who I work with" is stated explicitly | | |

### 1.3 Brand Asset Audit

| Check | Pass | Fail |
|-------|------|------|
| Color palette is consistent across LinkedIn banner, website, and any PDF assets | | |
| Typography matches across platforms | | |
| Logo/avatar is the same or visually consistent | | |
| Tone of voice is consistent (not formal on website, casual on LinkedIn) | | |

### 1.4 YouTube Channel Audit

Run only if the project has an active or planned YouTube presence.

| Check | Pass | Fail |
|-------|------|------|
| Channel name / handle is clear, searchable, and matches the brand | | |
| Banner image states the one offer (not just a name or tagline) | | |
| Channel trailer hooks a first-time visitor in the first 15 seconds | | |
| About section states who the channel helps and links to website / Calendly | | |
| Playlists are organized by topic (not a chronological dump) | | |
| Thumbnails follow a consistent style guide (fonts, colors, face/hook layout) | | |
| Video intro/outro reinforce the same brand promise as LinkedIn/website | | |

**Evidence to reference:** YouTube is the world's second-largest search engine with ~2.5–2.7 billion monthly active users and 500M+ daily searches ([GlobalMediaInsight 2026](https://www.globalmediainsight.com/blog/youtube-users-statistics/), [Digital Applied 2026](https://www.digitalapplied.com/blog/video-marketing-statistics-2026-data-points)). B2B buyers increasingly research long-form video before purchasing — 68% watch video before a buying decision ([Digital Applied 2026](https://www.digitalapplied.com/blog/video-marketing-statistics-2026-data-points)).

### 1.5 Audit Output

After checks are run, produce a summary:

```
Brand Audit — 2026-06-21

LinkedIn:       4/8 passed
Website:        3/7 passed
Brand Assets:   2/4 passed

Overall:        9/19 passed

**Next step:** `biz-brand overhaul`
```

Append the same scores as a row to the **Audit history** table in `.work.biz/reference/BRAND_STATUS.md` (create it from `templates/work/reference/BRAND_STATUS.md.template` if missing) so `biz-brand status` and the `brand-ready` gate have a durable record. Audit never promotes a gate.

---

## 2. Overhaul Mode — `biz-brand overhaul`

### 2.1 LinkedIn Overhaul

#### 2.1.1 Rewrite Headline

Rules:
- No skill-lists (`Project Manager | Developer | AI Enthusiast`)
- Lead with outcome: "I build custom [type] platforms for [who]"
- Under 220 characters
- Pick one pattern below

**Pattern A — Outcome-first:**
```
I build custom AI-powered platforms. Strategy → Architecture → Delivery. One person, end to end.
```

**Pattern B — Buyer-first:**
```
I help non-technical founders build custom platforms — without needing a CTO or a dev team.
```

**Pattern C — Problem-first:**
```
Custom platform development for companies that need serious engineering. 36 years shipping production software.
```

**Pattern D — Short & direct (when character count is tight):**
```
Custom AI platforms. Strategy. Architecture. Delivery. One person.
```

**How to choose:** Post one for 2 weeks. If profile views come from target buyers (founders, CEOs), keep it. If views come from recruiters, switch patterns.

#### 2.1.2 Rewrite About Section

Structure exactly:

```
[Opening — 2-3 sentences]
Who you are and what you do. State the one offer clearly.

[Problem — 1-2 sentences]
The specific problem your buyer has. Make it hurt.

[Proof — 2-4 bullet points]
Specific projects with outcomes. Numbers if possible.

[CTA — 1 sentence]
What they should do next. Link to Calendly or website.
```

Example:

```
I build custom AI-powered platforms — strategy, architecture, and delivery, end to end. One person who thinks like a CTO, designs like an architect, and ships like a developer.

You have a product idea but no technical co-founder. Agencies over-promise and under-deliver. Freelancers build the wrong thing.

Recent platforms I've built:
• AI persona clone with voice, RAG, and dual knowledge ingestion (Gemini 1.5 Pro + Qdrant)
• Multi-service platform with API gateway, WebSockets, 4 databases, and S3 storage (Kong + Redis + Cassandra + PostgreSQL)
• Digital card system with rendering engine, batch processing, and template designer

Let's talk about your product → [Calendly link]
```

#### 2.1.3 Select Featured Items

Pin exactly 3:
1. Best case study or article (proves you deliver)
2. Best GitHub repo or portfolio project (proves you ship)
3. Website or Calendly link (conversion point)

Remove any Featured item that does not reinforce the one offer.

#### 2.1.4 Update Profile Banner

- Dimensions: 1584 × 396 pixels
- Text overlay: your one offer headline
- Tool: Canva (free LinkedIn banner template)
- Avoid: generic tech patterns, stock photos, default banner
- Keep: consistent with website color palette

#### 2.1.5 Activity Section

Ensure:
- 3 most recent posts are on-topic (no random shares, no personal off-topic posts)
- Recent comments add real insight (not "great post!" — say something substantive)
- Profile visitors see consistent expertise on first scroll

### 2.2 Website Overhaul

#### 2.2.1 Homepage Rewrite

Replace the generic headline and service-box grid with:

```
Headline: I build AI-powered platforms.
Subheadline: One person, end to end. Strategy, architecture, and delivery — so you don't need to hire a CTO, an architect, and a dev team just to ship one product.
Value prop: Fixed price, milestone-gated. 36 years of engineering judgment + modern AI tooling.

What I build:
Custom AI platforms. Data dashboards. Full-stack web apps. Built to scale, deployed to production, handed over cleanly.

Case studies (linked from homepage):
• AI persona clone with voice, RAG, and dual knowledge ingestion
• Multi-service platform with API gateway, WebSockets, 4 databases, S3 storage
• Self-hosted teleprompter with PWA, QR handoff, real-time relay
• Digital card system with rendering engine, batch processing, template designer

Who I work with:
Non-technical founders and CEOs who need their product built.

Let's talk → [Calendly link]
```

#### 2.2.2 Website Audit Checklist (Post-Overhaul)

1. **Headline** — one offer, no service list
2. **Service boxes** — replaced with "What I build" + case study links
3. **Case studies** — actual portfolio items with outcomes
4. **Calendly** — prominent placement (hero, nav, or footer)
5. **Analytics** — installed and verifying with a test visit
6. **SEO schema** — JSON-LD for Person or Organization with name, description, sameAs (LinkedIn, GitHub)
7. **Who section** — explicit statement of who you work with

#### 2.2.3 Remove or Deprecate

- ❌ Generic service pages (SEO, Hosting, ERP, Infrastructure) — remove or 301-redirect
- ❌ Pricing page — every engagement is different. Use Calendly + proposals.
- ❌ "We do everything" language
- ❌ Leading with years of experience — lead with what you can do for the buyer

### 2.3 Brand Consistency

After LinkedIn and website are rewritten, verify:

| Asset | Must Match |
|-------|-----------|
| LinkedIn headline | Website headline (same core offer) |
| LinkedIn banner | Website hero background or color palette |
| About section tone | Website homepage tone |
| Featured items | Case studies on website |
| Calendly link | Same link on both platforms |
| Avatar/logo | Same or visually consistent |
| Color palette | Hex codes identical across platforms |
| YouTube banner text | Same one offer as LinkedIn/website |
| YouTube thumbnails | Same colors, fonts, and avatar as other brand assets |
| YouTube About links | Same website/Calendly as LinkedIn and website |

### 2.4 YouTube Channel Overhaul

Use this only when YouTube is a chosen primary or secondary channel. Reference `standards/20260701-PLATFORM-ALGORITHM-STANDARD.md` § YouTube for distribution rules.

#### 2.4.1 Channel name / handle

- Match the brand name if available; otherwise choose a searchable phrase that signals the niche.
- Keep it under 30 characters if possible. Avoid numbers/special characters unless they're part of the brand.

#### 2.4.2 Channel banner

- Dimensions: 2560 × 1440 pixels (safe area 1546 × 423 px on desktop, 423 px height on mobile).
- Text overlay: one-line offer or promise, not just the brand name.
- Use the same color palette and typography as the website and LinkedIn banner.
- Update the banner at least quarterly to reflect current offers or campaigns.

#### 2.4.3 Channel trailer

- Target length: 60–90 seconds.
- First 15 seconds: state who the channel is for and what they learn.
- Include a verbal CTA to subscribe and a link to the website / Calendly in the description.
- Show a real face or voice — this is a trust channel, not a slide deck.

#### 2.4.4 About section + links

Structure:

```
[One sentence: who this channel helps and the transformation it delivers]

[One sentence: what makes the host credible — specific outcomes or years]

[Links]
• Website / free resource: [URL]
• Book a call: [Calendly link]
• LinkedIn: [profile URL]
```

#### 2.4.5 Playlist organization

- Group videos into 4–6 thematic playlists, each with a clear title and 3+ videos.
- Create a "Start here" playlist for first-time visitors.
- Order playlist videos by value, not chronology.
- Use consistent thumbnail style across every video in a playlist.

#### 2.4.6 Thumbnail style guide

Lock in a repeatable system:

| Element | Rule |
|---------|------|
| **Layout** | One focal point (face or product), large readable text (≤5 words), solid background |
| **Colors** | Same 2–3 brand colors on every thumbnail |
| **Fonts** | One display font, one secondary font — same as website/LinkedIn |
| **Hook text** | Promise a specific outcome or pose a question |
| **Branding** | Small logo or avatar in a consistent corner |
| **Contrast** | Passes mobile readability test at 200 px wide |

#### 2.4.7 Video intro/outro branding

- **Intro:** 5–8 seconds max. Logo + sound mark + one-line promise. Never a long animated logo.
- **Outro:** One clear CTA (subscribe, visit link, watch next playlist). Show the next video or playlist end-screen.
- **Verbal sign-off:** Same closing phrase on every video to build familiarity.
- **Lower thirds / on-screen text:** Use brand fonts and colors; keep consistent placement.

---

## 3. Status Mode — `biz-brand status`

Read-only. Reports the current state of all brand components.

Source the `Last audit` / `Last overhaul` dates and the per-surface state from `.work.biz/reference/BRAND_STATUS.md`. If that file is missing, report every field as `unknown` and recommend `@biz-brand audit` — do not guess dates.

Output template:

```
Brand Status — 2026-06-21

LinkedIn Profile:
  Headline:        [current headline]
  About:           [first 80 chars...]
  Featured items:  [3 items]
  Banner:          [has text? yes/no]
  Last overhaul:   [date or never]

Website:
  URL:             [url]
  Homepage head:   [current headline]
  Calendly:        [visible? yes/no]
  Analytics:       [installed? yes/no]
  Case studies:    [count]

Brand Assets:
  Logo variant:    [filename or none]
  Color palette:   [filename or none]
  Typography:      [font name or none]

Last audit: [date or never]
Last overhaul: [date or never]

Next: nothing - work complete
```

---

## 4. 5-Second Test

After any overhaul, the profile/website passes only if a stranger knows within 5 seconds:

1. **What you do** (not a list of what you know)
2. **Who you help** (specific buyer, not "everyone")
3. **What to do next** (CTA is visible)

How to test:
- Show your profile/website to someone who has never seen it
- Count to 5
- Ask: "What do I do? Who do I help? What's the next step?"
- If they can't answer all three → rewrite

---

## 5. Failure Modes

| Failure | Likely Cause | Fix |
|---------|-------------|-----|
| After overhaul, still getting recruiter messages | Headline not specific enough | Show to a non-technical friend. If they don't understand, rewrite. |
| Profile views from wrong people | Headline attracts wrong audience | Switch headline pattern (A→B→C→D) |
| No inbound from target buyers | About section is generic | Rewrite starting with exact buyer problem |
| Website visitors don't book Calendly | Calendly not prominent or CTA weak | Move Calendly above the fold. Make CTA specific ("Book a 15-min call"). |
| Activity section contradicts profile | Recent posts/comments are off-topic | Remove or archive off-topic posts. Write 3 on-topic posts before overhauling. |
| No change after 2 weeks | Network doesn't know you changed | Send 10 warm messages to drive traffic to new profile |

---

## 6. Time Budget

| Step | Time |
|------|------|
| LinkedIn audit | 15 min |
| Website audit | 15 min |
| Brand asset audit | 10 min |
| Rewrite LinkedIn headline | 15 min |
| Rewrite LinkedIn About section | 30-45 min |
| Select + pin Featured items | 15 min |
| Update LinkedIn banner | 30 min |
| YouTube channel audit (if applicable) | 20 min |
| Rewrite website homepage | 2 hr |
| YouTube channel overhaul (if applicable) | 2–3 hr |
| Replace service pages with case studies | 2 hr |
| Add/verify Calendly + analytics + schema | 30 min |
| Brand consistency pass | 30 min |
| Review & publish | 15 min |
| **Total overhaul** | **~6-8 hours** |

---

## 7. Success Criteria

The overhaul is complete when:

- A stranger knows within 5 seconds: what you do, who you help, and what to do next
- LinkedIn headline contains zero skill-lists
- LinkedIn Featured section shows 3 items that all reinforce the same offer
- LinkedIn banner text matches the offer
- LinkedIn recent 3 posts are on-topic
- Website homepage states one offer (no service grid)
- Website has visible case studies linked from homepage
- Website has Calendly link prominently placed
- Website analytics is installed and tracking
- Brand assets (colors, typography, tone) are consistent across LinkedIn and website
- YouTube channel (if applicable) reinforces the same offer with consistent thumbnails, banner, and About links

---

## 7b. Gate promotion — `brand-ready`

`biz-brand overhaul` is the only skill allowed to promote `brand-ready`. Run this after § 2 and only when § 7 is fully satisfied.

**Refuse to promote** and report which criterion failed if any of these is true:

- Any § 7 success criterion is unmet.
- The § 4 five-second test failed, or was not run on a real person.
- `strategy-ready` is not PASS in `{WORK_BUSINESS_ROOT}/gates.md` (a brand cannot be aligned to an uncertified offer).

**On pass:**

1. Append a row to the **Overhaul log** in `.work.biz/reference/BRAND_STATUS.md` with the date, the surfaces rewritten, and the five-second test result. Refresh **Current surfaces**.
2. Replace the `## brand-ready` section in `{WORK_BUSINESS_ROOT}/gates.md` in place, leaving every other gate untouched:

```markdown
## brand-ready
**Status:** PASS
**Certified:** {date}
**By:** @biz-brand overhaul
**Evidence:** `.work.biz/reference/BRAND_STATUS.md`
**Next gate:** pipeline-ready — run `@biz-pricing set`, fill the pipeline tracker and outreach cadence, then `@biz-review status`
```

3. Report what the gate now unlocks: `@biz-content publish`, `@biz-community engage`.

**On a later overhaul that regresses:** if a re-audit drops below the § 7 bar, demote `brand-ready` to `NOT MET` rather than leaving a stale PASS.

---

## Operator handoff

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).
- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

---

## 8. Files Referenced

- `.work.biz/strategy/one-pager.md` (niche, unified offer, target buyer, price range)
- `.work.biz/strategy/offer-scope.md` (what the offer IS and IS NOT)
- `.work.biz/strategy/channel-plan.md` (primary channel + messaging angles)
- `.work.biz/reference/PROJECTS.md` (project descriptions for proof points; create from `templates/work/reference/PROJECTS.md.template` if missing)
- `.work.biz/reference/VISUAL_GUIDE.md` (banner specs, color palette, typography; create if missing)
- `.work.biz/reference/BRAND_STATUS.md` (audit history, overhaul log, current surfaces; written by this skill, read by `status` mode and the `brand-ready` gate)
- `.work.biz/gates.md` (readiness ledger; read in I0, `brand-ready` promoted in § 7b)
- `skills/biz-content/skill.md` (posts for activity section)

---

## 9. Mode Routing (for agent implementation)

```
On "biz-brand audit":
  → Run section 1 (Audit Mode)
  → Output pass/fail table + summary
  → Append scores to reference/BRAND_STATUS.md Audit history
  → Do not promote any gate

On "biz-brand overhaul":
  → Run section 2 (Overhaul Mode)
  → Modify LinkedIn profile (via collaborator or manual instructions)
  → Modify website files (via collaborator or manual instructions)
  → Verify consistency
  → Run 5-second test
  → Run section 7b (Gate promotion) — promote brand-ready only if section 7 is fully met

On "biz-brand status":
  → Run section 3 (Status Mode), reading reference/BRAND_STATUS.md
  → Output current state report
  → Do not modify anything
```
