# Content Standard

Binding rules for all content produced by `biz-writing`, `biz-social`, `biz-content`, and `biz-youtube`.

## Universal content rules

1. **No pitching in content.** Teach, demonstrate, or tell a story. The offer belongs in the CTA, not the body.
2. **One topic per piece.** A reader or viewer should be able to state the single takeaway in one sentence.
3. **Specificity beats abstraction.** Use real numbers, real situations, and concrete examples. "Many founders" is weak; "seed-stage B2B SaaS founders" is strong.
4. **Hook first.** The first 15 seconds of video or first line of text must answer: *Why should I keep consuming this?*
5. **Every piece has one CTA.** Not two, not five. One next step appropriate to the platform and funnel stage.
6. **Repurpose deliberately.** One long-form asset should spawn platform-native derivatives, not identical cross-posts.
7. **Respond to comments within 24 hours** during the first 72 hours after posting.

## Appeal standard (binding)

Correctness and clean prose are the entry fee, not the differentiator. Content that is merely competent gets scrolled past. Every piece must also clear these six bars:

1. **Position requirement.** Every piece takes a stance an informed peer could disagree with. No neutral summaries, no "it depends" as the thesis. If nobody could disagree, the piece has nothing to say; sharpen it until someone could.
2. **Scene or number in the opening.** The first two lines contain a concrete scene, a named moment, or a number. Not a concept, not a question about the industry. The reader must land somewhere specific immediately.
3. **Stakes requirement.** The reader must learn what breaks, for whom, and what it costs. A piece with no consequences is a piece with no reason to keep reading.
4. **Specificity quota.** At least one proper noun, number, or named artifact per 150 words. Specificity is the biggest single lever for credibility and appeal; abstraction is where generic content hides.
5. **So-what bar.** If a paragraph's claim could appear unchanged in any competitor's post, delete it or rewrite it until it could only be yours.
6. **Emotional concreteness.** Name the feeling at the moment of the stakes: dread, relief, embarrassment, the 2am stare at a failing dashboard. Facts tell the reader what happened; the feeling tells them why it matters.

The appeal standard never overrides truth: a sharper claim is never worth an invented detail. When the operator's real proof points are thin, the fix is `reference/PROJECTS.md`, not embellishment.

## Format-specific rules

### Long-form writing (article, newsletter, case study)

- Title: promise a specific outcome or insight, not a topic.
- Lead paragraph: state the problem, the stake, and the promise.
- Body: one idea per section; use subheadings every 200–300 words.
- CTA: one link to a resource, booking page, or next article.

### LinkedIn

Aligned with `skills/biz-social/platforms/linkedin.md` and `docs/sources/verified-sources.md` § LinkedIn distribution (2026). The multipliers there are grade C and directional.

- No external URL in the post body, and none in a first comment. The first-comment workaround is detected and suppressed (reported 20–80% reach loss). Name the resource in words and point to the profile Featured section or the bio. A native article or document post is on-platform.
- Text posts: about 150–300 words, 4–8 short paragraphs, one strong opening line. Write for dwell and saves.
- Hashtags: 0–3, or none. Ten or more is a visibility penalty. Semantic matching does the topic work.
- Carousels: 6–12 slides, one idea per slide, strong cover.
- The first hour is a launchpad, not the verdict. Posts circulate for two to three weeks. Do not judge a post at hour two, and do not delete and repost on that basis.

### YouTube long-form

- Length: 8–15 minutes for educational content; longer only when depth justifies it.
- Structure: hook (0:00–0:30), promise (0:30–1:00), segmented body with retention points every 3–4 minutes, CTA (last 30 seconds).
- Title + thumbnail function as a pair; optimize for click-through rate.
- Description: one-paragraph summary, timestamps/chapters, one funnel link, social links.
- Pinned comment: secondary CTA or resource link.

### YouTube Shorts

- Length: 15–60 seconds; up to 3 minutes only when the story demands it.
- Hook: first 1–3 seconds; no title cards.
- One takeaway per Short.
- CTA: subscribe or watch the related long-form video.

## Content approval checklist

Before any piece is marked done:

- [ ] One clear takeaway
- [ ] Hook passes the 5-second test
- [ ] One CTA only
- [ ] Platform-native formatting applied
- [ ] External links placed according to platform rules
- [ ] Proofread; no placeholder text
- [ ] AI-artifact scan passed (em-dashes, contrastive negation, hedging words, generic transitions, passive voice, empty intensifiers). Narrative drafts: `prose-rhythm-check.sh` result reported, not assumed
- [ ] Scheduled or published with tracking note in `.work.biz/plans/NEXT.md` or content tracker

## Anti-AI-artifact rules

Readers and viewers increasingly associate certain stylistic tics with low-effort AI-generated content. Avoid them.

**Relationship to the project voice profile.** The **Mechanical tics**, **Vocabulary red flags**, and **Structural red flags** below are a floor. They bind on every platform and no project file may override them. The **Human voice rules** below are *defaults* for projects with no voice definition of their own; `.work.biz/reference/VOICE_PROFILE.md` may override any of them when it states the override and the reason. That is deliberate: a real human voice sometimes breaks generic style advice, for example long comma-joined sentences or non-native English patterns that are genuinely part of how the owner writes. Rules the voice profile marks as **texture** must not be "corrected" away.

### Mechanical tics

- **Em-dashes (—) and en-dashes (–).** Do not use them. Zero. Rewrite every sentence that wants a dash. Use a period, comma, colon, semicolon, or parentheses instead.
  - Bad: "The real problem — the one nobody talks about — is ownership."
  - Good: "The real problem is ownership. Nobody talks about it."
- **Bullet-point overload.** Lists are scannable, but a post that is 80% bullets reads like a prompt output. Use narrative paragraphs between lists.
- **Colon-then-bullets inside narrative posts.** A sentence ending in a colon that unleashes a bullet list is the single most recognizable LLM shape in a feed. When the surrounding text is narrative, keep the items in prose or rewrite the lead-in.
- **Numbered frameworks that don't need numbers.** "3 ways to…" only when the structure genuinely helps the reader. Don't force a count.
- **Excessive subheadings.** In long-form, one subheading every 200–300 words is enough. More frequent subheadings feel like an outline, not an article.
- **Overly tidy paragraph symmetry.** Human writing has ragged edges. Not every paragraph needs to be the same length or follow the same shape.
- **Contrastive negation.** "It's not just a tool, it's a mindset." "It's not X. It's Y." "X, not Y." "Don't sell X, sell Y." The drumroll adds no information, and it is the shape models reach for when told to sound sharp. State the Y. If the rejected alternative matters, give it its own sentence and a reason.
- **Confessional openers.** "Here's the thing:", "Let's be honest", "Real talk:". They simulate candor without delivering it. Say the candid thing without the announcement.
- **Rhetorical questions as a crutch.** At most one rhetorical question per piece, and never as the opener. Humans assert; chatbots ask and then answer themselves.
- **Triplet cadence.** Three parallel clauses stacked for rhythm ("The one that… The one that… The one that…") or anaphora repeated down a page reads as generated within two lines. Break the pattern before it starts.

### Vocabulary red flags

Replace these with plain, specific language:

| Avoid | Use instead |
|-------|-------------|
| delve, explore (as in "let's delve into") | dig into, look at, break down |
| leverage | use, exploit, build on |
| utilize | use |
| robust, resilient, scalable (alone) | say what specifically makes it so |
| foster, cultivate | build, create, grow |
| tapestry, landscape, paradigm, ecosystem | plain description of the actual situation |
| it's important to note / it's worth noting | just say the thing |
| in today's world / in an era of / in today's fast-paced world | delete or be specific about time/place |
| furthermore, moreover, additionally, consequently | use line breaks, so, also, or delete |
| ultimately, in conclusion, in summary | end with the point, not a signpost |
| underscores, serves as a testament, sheds light on | show the evidence directly |
| embark on a journey | start, begin |
| unlock / unlock potential | enable, make possible, or say what actually happens |
| supercharge / turbocharge | accelerate, speed up, or give the real number |
| game-changing, revolutionary, cutting-edge, world-class, best-in-class | delete or quantify |
| holistic, seamless, frictionless, end-to-end | say what you actually mean |
| actionable insights | useful findings, what we learned |
| strategic imperative | something we have to do |
| digital transformation | be specific: what changed, what system, what result |
| navigate the complexities | say what you actually did |
| empower / empower teams | say what they can now do |
| mission-critical | say what breaks without it |
| at scale (unquantified) | name the scale: how many users, requests, dollars |
| journey (as career metaphor) | path, move, transition |

### Structural red flags

- **Hedging everything.** "This might be…", "One could argue…", "It seems that…" — state the claim and own it. Hedge only when uncertainty is real and material.
- **Passive voice by default.** "The decision was made" → "I decided." "The tool was used" → "I used the tool."
- **Abstract nominalizations.** "The optimization of the process" → "I optimized the process."
- **Generic openings.** "In the fast-paced world of…", "As we all know…", "In recent years…" — start with the reader's problem or a specific scene.
- **Recycled transitions.** Every paragraph starting with "This means…", "That's why…", "This is because…" — vary sentence rhythm.
- **Signpost overload.** "First… second… third… finally" and "Let's start with…" in short posts feel robotic.
- **AI endings.** "In conclusion…", "To sum up…", "At the end of the day…" — just end with the point.
- **Over-apologizing.** "I might be wrong, but…", "This is just my opinion, but…" — state the claim and own it.
- **Fake specificity.** "Many companies", "most teams", "a lot of founders" — name a number or a type.
- **Empty intensifiers.** "Very", "really", "incredibly", "extremely" — cut or replace with a concrete detail.

### Human voice rules

The goal is not polished prose. The goal is a credible human talking to a peer.

- **Read the draft aloud.** This is a gauntlet, not a suggestion. If it sounds like a report, a pitch deck, or a chatbot, rewrite it. If you stumble saying a sentence, the reader stumbles reading it.
- **Measure the rhythm on narrative drafts.** For a post, article, script, or case study, run `bash scripts/prose-rhythm-check.sh <file>` and report PASS, FAIL, or SKIP in the delivery. The script exists because a draft that already obeyed the banned-word list was still rejected: sentences of the same length, chopped into verbless fragments, read as generated. SKIP means the file is under 120 words of narrative prose (a checklist, a short note). FAIL means rewrite before delivery. Do not claim the scan passed without the script's line.
- **Use contractions where natural.** "It's", "don't", "can't", "you're" are fine unless the brand voice forbids them.
- **Vary sentence length.** Mix short punches with longer explanations. Avoid chains of same-length sentences. Two short-clause sentences back to back is a cadence tell: combine one of them or change its shape.
- **Allow minor roughness.** A slightly informal opener or a sentence fragment is better than a perfectly balanced but lifeless paragraph.
- **Write to one person, not an audience.** Use "you" and "I". Avoid "one", "organizations", and "professionals" when you mean the reader.
- **Prefer plain verbs.** "Use" beats "utilize". "Start" beats "commence". "Fix" beats "remediate".
- **Kill the literary flourish.** No "tapestry", "symphony", "journey", "dance", "rich tapestry", "ever-evolving landscape".
- **No perfect parallelism for its own sake.** "Fast, reliable, and scalable" is a tagline, not a sentence.

### Platform-specific tics

- **LinkedIn:** Avoid the "Most people… But the top 1%…" template. Avoid "Agree?", "Thoughts?", or "What do you think?" as the only CTA. Avoid em-dashes entirely in post copy.
- **X/Twitter:** Avoid thread starters like "Most people don't know…" unless you genuinely have a non-obvious insight. Avoid ending every tweet with a takeaway sentence.
- **YouTube:** Avoid "In this video, we will…" intros. Avoid over-smooth transitions ("With that said…", "That being said…") every 30 seconds.
- **Reddit:** Avoid numbered lists when a paragraph answer is more natural. Avoid signposting ("TL;DR at the bottom" can be fine, but don't over-format).
- **Instagram:** Avoid the emoji-per-line caption template and walls of hashtags posing as a caption. Avoid opening with "Swipe to see…" or "Save this post for later!" as the hook. Avoid the "Here's what nobody tells you about X 👇" formula. Don't caption a carousel with a summary of the slides; the caption should add something the slides don't.
- **Facebook:** Avoid corporate Page voice inside a Group ("We are excited to announce…"). Avoid opening with "Hey everyone!" or "Quick question for the group:" followed by a pitch. Avoid engagement bait ("Tag someone who…", "Drop a 🙌 if…"). Group posts should read like one member talking to peers, not an announcement.
- **Substack and newsletters:** Avoid "Welcome back to another edition of…" and numbered-issue preambles before the actual content. Avoid a subject line that describes the format instead of the idea ("Thoughts on AI, part 3"). Avoid the subscribe-CTA-in-the-middle interruption unless the piece is genuinely long. Avoid a sign-off block inside the prose; bylines belong on the platform, not in the text.
- **Threads:** Avoid porting LinkedIn thought-leadership cadence over. Threads punishes formality and rewards conversational replies. Avoid numbered listicles and avoid the X-style "🧵" thread marker.

### Lead-facing artifacts (binding beyond the content skills)

The floor above binds the four content skills. It also binds **every artifact a lead, recruiter, or buyer reads**, including the ones produced by skills that are not content skills and were therefore never in scope of the scan:

| Artifact | Produced by |
|----------|-------------|
| Resume / CV, cover note, LinkedIn profile copy | `@biz-career resume`, `@biz-brand overhaul` |
| Proposal, scope document, three-option table | `@biz-proposal write` |
| Outreach sequence and follow-up notes | `.work.biz/pipeline/outreach-cadence.md`, `@biz-discovery` |
| Discovery-call recap and next-step email | `@biz-discovery run` |
| An objection answer sent in writing | `@biz-objections handle` |

Rules, all binding:

1. **Mechanical tics, Vocabulary red flags and Structural red flags apply unchanged** to every artifact above. They are a floor; no project file overrides them, exactly as in § Relationship to the project voice profile.
2. **No detector claim, ever.** No artifact, skill, report, or operator-facing message may state or imply that its output is "undetectable", "AI-proof", "humaniser-safe", "passes Turnitin/GPTZero", or otherwise verified by an AI-text detector. The measured evidence runs in both directions at once: detectors classified **61.22% of 91 TOEFL essays** as AI-generated, with 97% flagged by at least one of seven detectors (Liang et al., *Patterns* 4(7):100779, 2023, grade B), and in a 160-document ground-truth set Turnitin and GPTZero detected **0% of the fully-AI papers** (Van Vlasselaer, *Int J Educ Technol High Educ*, 2026, grade B). A detector verdict is not evidence about authorship in either direction. Rows and grades: `docs/sources/verified-sources.md` § AI-text detectors.
3. **The justification is reader trust, not evasion.** A buyer or recruiter who notices generated prose discounts the claim being made, not the grammar. The scan exists because artifacts read as careless, and because a proposal that reads as careless is priced as careless.
4. **Second-language English is a voice, not a defect.** Rules `reference/VOICE_PROFILE.md` marks as **texture** must not be corrected away. Detectors score perplexity, which correlates with lexical and syntactic complexity, so "reducing detection risk" and "writing away from a legitimate non-native register" are the same action. That is the operative risk for any operator writing in a second language, and it is a reason to protect the voice profile, not to flatten it.
5. **Scan before it leaves the building, and report the result.** The AI-artifact scan in the delivery checklist is mandatory for lead-facing artifacts too. Report that the scan ran and what it found; never assert a clean result without running it.

## Graded claims (mandatory on commentary content)

Commentary inherits other people's facts. Without grading, their errors silently become yours, and a single unverifiable inherited claim can cost more credibility than the piece earns.

Any content that comments on external events (a launch, an outage, an industry bet, a trend, someone else's post or study) must visibly separate three kinds of statement **in the text**, not in a footnote:

| Label | Meaning |
|-------|---------|
| **Verified** | Fact with a source, linked or named |
| **Inference** | Your judgment from experience. Say that it is |
| **Would check / would prove me wrong** | What to verify before betting money on it, or what evidence would flip the take |

This grading is a credibility feature, not a hedge. It is the visible content-side counterpart of the assumption ledger the agent rules already require for planning work: the same discipline, applied where readers can see it.

**Recommended commentary structure:** the event (sourced) → what actually happened, in one paragraph → what you would watch, from experience → what would prove the take wrong.

**Anti-patterns:**

- Restating a vendor's or a study's numbers as your own finding
- "Studies show" or "it's well known that" with nothing named
- Hedging the whole piece instead of grading individual claims. Grade the claims and own the judgment
- Grading in a disclaimer block at the bottom that the reader reaches after already believing the piece

**Experience-to-commentary ratio.** Commentary keeps a publication current; experience is what differentiates it. A useful default is roughly **70/30 experience to commentary** across a rolling month. When commentary becomes the majority, expect reach without buyers: you get read by peers and other commentators rather than by the people who hire you. If a project has performance data showing that pattern, cite it in the project's own standard rather than relying on this default.

## Voice convergence (measure whether drafting rules work)

A voice profile is a hypothesis about how the owner sounds. The only evidence that it is correct is that the owner stops having to fix the same things.

Projects that use an owner-pass workflow should keep a retro at `.work.biz/reference/VOICE_RETRO.md` (template: `templates/work/reference/VOICE_RETRO.md.template`). One short entry per published asset, recording what the draft said and what the owner changed.

**The signal to watch:** owner edits per piece should *fall* over time. If they do not fall after five or six pieces, the drafting rules are wrong and the voice profile needs amending. The failure mode this prevents is real and expensive: an owner quietly making the same correction forever while everyone treats the drafts as fine.

**Rule:** when the same class of edit appears three times, amend `VOICE_PROFILE.md`. Do not expect the owner to keep making a correction the rules could carry.

## Anti-patterns

- Generic headlines ("The Future of X").
- Multiple CTAs competing for attention.
- Cross-posting the same text to LinkedIn, X, and Facebook unchanged.
- Educational videos that spend the first 60 seconds on intro music and biography.
- Shorts with no clear point.
