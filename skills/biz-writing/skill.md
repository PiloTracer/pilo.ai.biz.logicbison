---
name: biz-writing
description: >-
  Write, plan, or improve any piece of content — articles, blog posts, LinkedIn
  posts, case studies, landing-page copy, email sequences, social threads,
  newsletters, thought-leadership pieces, technical deep dives, or any other written content. Produces publication-ready,
  professional-quality output calibrated to the host project's brand voice,
  audience, tech stack, and channel — not generic filler. Always use this skill
  for content creation tasks, even simple ones, because the project-context
  loading and structure guidance dramatically improve output quality regardless
  of the model used. biz-writing write, biz-writing plan,
  biz-writing repurpose, biz-writing audit, biz-writing status.
---

# biz-writing

**Canonical path:** `.ai.biz/skills/biz-writing/skill.md`

Produce professional, publication-ready content. Generic filler and hollow marketing language are the enemy. Every sentence must earn its place. Output must be technology-grounded, specific, and credible enough that a knowledgeable reader would trust the author on first read.

This skill is **model-agnostic**: it produces high-quality results regardless of the LLM in use because it enforces evidence-first reasoning, project context loading, and a completion gate before anything is delivered.

---

## Parse invocation

| User says | Mode |
|-----------|------|
| `@biz-writing write - <topic>` | Author one finished piece (default). |
| `@biz-writing write - <type> about <topic>` | Author with explicit type (article, post, case study, landing page, email, thread, newsletter). |
| `@biz-writing plan - <horizon>` | Build a content calendar / topic plan (e.g., `30 days`, `Q3`). |
| `@biz-writing repurpose - <source>` | Spin one existing piece into 3–4 format variants. |
| `@biz-writing audit - <draft or path>` | Critique an existing draft against the quality bar; output fixes, not a rewrite. |
| `@biz-writing status` | Read-only: report what brand/audience context was loaded and what's missing. |

**Default:** `write` if no verb matches. If the user gives a free-text request like "write me a post about X" with no verb, treat it as `write - <their words>`.

---

## I0 — Project Context Contract (run before writing anything)

Output is only as good as the context it's grounded in. Load context in **priority order** and stop when you have enough. Do not skip to writing with no context.

### Priority 1 — Host project memory (Business OS, if present)

Read, if they exist, in this order:

| File | What it gives you |
|------|-------------------|
| `.work.biz/strategy/one-pager.md` | Niche, unified offer, target buyer, channel, price range |
| `.work.biz/strategy/target-buyer-profile.md` | Who reads this content, what they fear, what they value |
| `.work.biz/strategy/offer-scope.md` | What the offer IS / IS NOT — keeps content on-position |
| `.work.biz/strategy/channel-plan.md` | Primary channel → matching content format |
| `.work.biz/reference/OPERATOR_PROFILE.md` | Who the author actually is: skills, constraints, career stage. Keeps claims inside what the operator can deliver and prove. A skeleton-full of `<` placeholders counts as missing; say so |
| `.work.biz/reference/PROJECTS.md` | The proof-point bank: real projects with numbers. Draw every concrete result from here; respect its disclosure status |
| `.work.biz/reference/CONTENT_STATUS.md` | What already exists: never re-write a `published` piece for the same platform; prefer advancing a `ready` or `draft` piece over starting fresh |
| `.work.biz/context/HANDOFF.md` | Recent decisions; avoid contradicting them |

### Priority 2 — Voice profile (binding when present)

Read `.work.biz/reference/VOICE_PROFILE.md` — the canonical definition of how *this owner* sounds. If absent, check `.work.biz/ideas/VOICE_STANDARD.md`, `.work.biz/reference/VOICE_STANDARD.md`, and `.work.biz/reference/voice-profile.md` before falling back.

| Layer | Wins on |
|-------|---------|
| Content Standard § Anti-AI-artifact rules | Always binding. Zero em-dashes and en-dashes regardless of any other file |
| Voice profile | Tone, rhythm, structure, vocabulary, point of view |
| Format rules below | Length, section shape, CTA placement |

If the profile lists **reference samples**, read the one matching the requested format and match its rhythm, not just its topic. Treat **texture** rules as deliberate: do not normalize long comma-joined sentences, regional English patterns, or fragments into polished prose. If an **owner pass** is mandatory, label the output a draft and say so.

Without a voice profile, output is correctly de-AI-ified but generically human. Note that in the context summary and point at `templates/work/reference/VOICE_PROFILE.md.template`. The same applies when the profile exists but is still a skeleton (`<` placeholders remain, or no reference sample is filled): treat it as absent and warn plainly in the context summary, because an unfilled profile adds a step without adding value (CONVENTIONS § Voice loop).

### Priority 3 — Project identity file

Read the project root `.cursorrules` (or `AGENTS.md`) — its `REPLACE:` tokens resolve to the real `PROJECT_NAME`, `UNIFIED_OFFER`, `TARGET_BUYER`, `PRICE_RANGE`. These four values anchor voice and positioning.

### Priority 4 — Tech stack & proof (technology tilt)

These skills exist to produce **technology-related** results. Establish the operator's real tech fingerprint so content is concrete:

- `.work.biz/reference/PROJECTS.md` → the curated proof-point bank. Read it before scanning the repo; it is the authoritative source of citable results.
- `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `Cargo.toml`, `docker-compose*.yml` → real stack.
- `README.md` → what the project actually does.
- Any `work/`, `case-studies/`, or `docs/` folder → real projects to cite with numbers.

**Non-tech hosts:** if no stack manifest exists and the project is clearly not technology work, do not force technical details. Tilt the specificity requirement toward domain evidence instead: numbers, processes, and outcomes from `reference/PROJECTS.md` and `reference/OPERATOR_PROFILE.md`.

### Priority 5 — Brand standard

Read `standards/*BRAND-GUIDE*`, `standards/*CONTENT-STANDARD*`, and `standards/*PLATFORM-ALGORITHM-STANDARD*` if present. These are binding; do not violate them. Pay particular attention to platform-specific link rules (LinkedIn, Facebook, Instagram).

### Priority 6 — Fallback example

If none of the above yield a usable brand/audience, load `references/project-context.example.md` (a worked example showing the expected shape and depth) and state explicitly: **"No project context found; using generic professional defaults calibrated to the example profile."** Then proceed with professional-quality defaults and the structure rules below.

### Context summary (emit briefly before drafting)

```
LOADED CONTEXT
  Project:      <name or "unnamed — generic defaults">
  Offer:        <one line or "unspecified">
  Audience:     <buyer or "general tech-aware readers">
  Voice:        <"VOICE_PROFILE.md (locked <date>)" | "legacy: <path>" | "none — generic human defaults">
  Reference sample: <path used for this format, or "none for this format">
  Stack:        <concrete tech or "unspecified — keep examples generic">
  Channel:      <primary channel or "unspecified — match request">
  Gaps:         <what's missing that the user should supply for better output>
```

If critical gaps exist (no audience, no offer, no tech proof), name them and ask **one** consolidated question only if they would materially change the output. Otherwise proceed.

---

## I1 — `write` mode

### Step 1 — Understand the assignment

Resolve these from the conversation; ask only if genuinely unclear:

| Question | Why it matters |
|---|---|
| **Content type** | Article, post, case study, landing page, email, thread, newsletter, YouTube source outline (for `@biz-social write youtube`)? |
| **Primary audience** | Who reads this, what do they already know? |
| **Goal** | Inform, attract leads, build trust, convert, entertain? |
| **Channel** | Blog, LinkedIn, Twitter/X, newsletter, website? |
| **Position** | What stance does this piece take, and which informed peer could disagree with it? A piece with no defensible position has nothing to say (Content Standard § Appeal standard). |
| **Tone** | Match brand voice by default; override if specified |
| **Length** | Match channel norms unless specified |
| **CTA** | What should the reader do after reading? |

If the request already answers most, proceed without interrogating.

### Step 2 — Outline (long-form only)

For pieces over ~600 words, emit a 3–5 bullet outline and confirm direction before writing. For short-form, go straight to the draft.

### Step 3 — Universal quality rules

**Show, don't tell.** Replace adjectives with data, examples, or proof.
- Bad: "We have deep expertise in AI development."
- Good: "The RAG stack I built retrieves from 40,000 private documents in under 400ms."

**Lead with the reader's problem, not your credentials.** First paragraph makes the reader feel seen. Credentials are evidence, not the opener.

**One idea per paragraph.** If a paragraph does two jobs, split it.

**Cut the first sentence of every draft.** It's almost always a warm-up. The real opener is usually sentence two.

**Specificity beats generality every time.** "6–12 weeks to MVP" lands harder than "fast delivery." "4,900-line tax engine" beats "complex backend logic."

**No hollow intensifiers.** Remove: very, really, truly, certainly, absolutely, incredibly, amazing, game-changing, revolutionary, cutting-edge, world-class, robust, scalable (unquantified), seamless.

**Earn the CTA.** Don't ask for action until you've delivered enough value that the reader *wants* the next step.

**Technology tilt (mandatory).** At least one concrete technical detail per major section — a stack choice, a number, a tradeoff, a failure mode. If you cannot produce one, the piece is too vague; revise.

**Human voice (mandatory).** Content must sound like a credible human talking to a peer, not a polished report or chatbot.
- No em-dashes (—) or en-dashes (–). Zero. Use periods, commas, colons, or parentheses.
- Use contractions where natural.
- Vary sentence length. Mix short punches with longer explanations.
- Allow minor roughness. A sentence fragment or informal opener is better than a perfectly balanced but lifeless paragraph.
- Read the draft aloud. If it sounds literary, robotic, or like a pitch deck, rewrite it in plain speech.

### Step 3.5 — Pre-delivery self-criticism (mandatory)

Before delivering any draft, run a self-criticism pass. Do not skip this. Ask:

1. **Hook test:** If the first line appeared alone in a busy LinkedIn feed, would I stop scrolling? Is it a scene, number, or sharp claim, not a generic concept? Do the first two lines satisfy the appeal standard's scene-or-number rule?
2. **Position test:** Could an informed peer disagree with the thesis? If nobody could, the piece is a neutral summary; sharpen the stance or change the angle.
3. **Stakes test:** Can the reader name what broke, for how long, and what it cost? If not, the body is too safe. Does the reader feel anything at the moment of the stakes, or just learn facts?
4. **Credibility test:** Does the reader know why the narrator is qualified to say this? Credentials must appear early, not buried in a comment.
5. **Action test:** Is the actionable framework/checklist in the post body or a carousel? If it only exists in a "first comment" suggestion, the post has no value in the feed.
6. **AI-cadence test:** Read the draft aloud. If it sounds like a repetitive list of short clauses ("The one that…", "It's about…", "This is why…"), rewrite it as natural prose. Also scan for the banned constructions in the Content Standard: "not just X, it's Y", confessional openers, colon-then-bullets in narrative, second rhetorical question, triplet cadence.
7. **Human-voice test:** Does it contain any em-dashes, en-dashes, literary flourishes, or polished-report language? If yes, remove or rewrite.
8. **CTA test:** Is the closing prompt specific and professional, or is it generic engagement bait?
9. **So-what test:** Would a skeptical reader in the target audience share or save this? Could any paragraph appear unchanged in a competitor's post? If either answer is wrong for the piece, sharpen it.

If any test fails, revise the draft before moving to Step 4.

### Step 4 — Format by content type

#### Blog article / thought leadership

```
[Headline]      — specific, benefit-driven or tension-based. Not clever for its own sake.
[Subheadline]   — one sentence expanding on the headline promise.

[Hook paragraph] — 2–4 sentences. Open with the reader's problem or a
  counterintuitive claim. No "In today's fast-paced world."

[Body sections] — H2 every 300–500 words. Each makes one argument or delivers
  one insight. Use examples, numbers, or mini-case-studies.

[Conclusion]    — Restate the core insight in fresh language. Don't summarize
  what they just read. Add a forward-looking implication.

[CTA]           — One clear action. No list of options.
```

#### LinkedIn post

```
[Hook line]   — First line stops the scroll. Must be a specific scene,
  concrete number, or counterintuitive claim, not a generic concept.
  Under 12 words.
  Bad: "The most dangerous spreadsheet..."
  Good: "A 200-person manufacturer almost missed payroll because one Excel
  file lived on a desktop."

[3–6 short paragraphs] — One idea each. White space is your friend.
  Conversational but substantive. Personal angle beats generic advice.
  Paragraph 1 establishes the narrator's credibility (role, context).
  Paragraphs 2-3 show the stakes: what broke, for how long, what it cost.

[Insight]     — The sentence people screenshot. Must be specific enough
  to feel earned, not a platitude. Place it where it can stand alone.

[CTA / question] — Invite engagement with a specific, professional
  prompt tied to the topic. Avoid broad self-help questions like
  "What do you think?" or "What's the one X in your org?"

[Hashtags]    — 0-3, or none. 10+ is a reach penalty.
```

**LinkedIn post anti-patterns:**

- Abstract conceptual hooks ("The most dangerous X is the one nobody owns").
- Repetitive triplet cadence ("The one that… / The one that… / The one that…").
- Short-paragraph overload without a concrete payoff.
- A URL in the body or in a first comment. LinkedIn detects that workaround and suppresses the post. Put a checklist in the body or a carousel. Name a resource in words and point to Featured or the bio.
- Generic engagement questions as the only CTA.

**LinkedIn format selection:** Before writing, decide whether the topic is a framework/checklist. If yes, strongly consider a **carousel** (6–12 slides, PDF upload) — it is currently LinkedIn's highest-reach format for save-worthy frameworks. Use a text post only when the value is a single story, hot take, or lesson.

**LinkedIn links:** No URL in the post body and none in a first comment. A body link is reported at about a 60% reach cut, and the old first-comment workaround at 20–80% (grade C, `docs/sources/verified-sources.md` § LinkedIn distribution). Keep the post self-contained. If a resource must be named, say where it lives (Featured or the bio) in words. Load `skills/biz-social/platforms/linkedin.md` before drafting a LinkedIn post; this skill does not restate that guide.

#### Case study

```
[Project title + one-line result] — Lead with the outcome.

[The Problem]   — Client's situation before. Concrete about the pain.
[The Approach]  — What you built and why. Technical choices justified in
                  business terms. Avoid jargon without explanation.
[The Result]    — Numbers. Before/after. Specific outcomes.
[Stack used]    — List actual technologies with brief rationale.
[What made it hard] — Optional but powerful. Shows genuine depth.
```

#### Landing page copy

```
[Hero headline]    — One promise. Under 10 words. Specific.
[Sub-headline]     — Who it's for + what they get.
[Social proof]     — Number, client, or result.

[Problem section]  — Name the pain precisely.
[Solution section] — How you solve it differently.
[Evidence section] — Case studies, numbers, specifics.
[Objection handling] — The three reasons they'd say no.
[CTA]              — One action. Repeated 2–3x down the page.
```

#### Email (outbound or nurture)

```
Subject line:   Specific, short, no spam triggers. Under 50 chars.
Preview text:   Complements subject, adds intrigue.

[Opening]        — One sentence. Reference something real.
[Value/insight]  — 2–3 sentences of genuine usefulness.
[Bridge to offer] — Natural, not a pivot.
[CTA]            — One link, one action.
[Signature]      — Name, role, one credibility line.
```

#### Technical deep dive (article variant)

Use when the topic is genuinely technical and the reader wants depth:
- State the problem and the constraint set up front.
- Show the architecture decision and the alternatives rejected, with reasons.
- Include a concrete code/config snippet only if it earns its place (real, not illustrative filler).
- Close with the tradeoff: what this choice costs you.

#### YouTube source outline

`biz-writing` produces the **source outline** for a YouTube video. The actual script, title/thumbnail pair, and platform packaging are owned by `@biz-social write youtube` / `@biz-social write youtube shorts`, which apply platform-specific CTR, retention, and formatting rules.

Use this when the starting point is a blog post, case study, or long-form article that will later become a video. Calibrate to `standards/20260701-PLATFORM-ALGORITHM-STANDARD.md` § YouTube.

```
[Working title + angle]
  Specific, searchable, emotionally concrete. One clear promise.

[Hook — 0:00–0:30]
  State the problem or promise. No setup, no biography.

[3–5 takeaways]
  Bullet what the viewer will know or be able to do by the end.

[Body outline]
  One idea per segment. Note where proof, examples, or screen shares go.
  Include at least one concrete example or number per major point.

[CTA]
  One action: subscribe, visit link, watch next video.

[Source material]
  Link to the article/case study this outline is derived from.
```

**Next step:** hand the completed outline to `@biz-social write youtube - <title>` for the full script, title/thumbnail, description, and pinned comment.

### YouTube packaging (reference only)

Final title, thumbnail, description, and pinned comment are owned by `@biz-social write youtube`. Use this table only as a cross-check when producing a source outline:

| Element | Rule |
|---------|------|
| **Title** | Front-load the keyword; promise a transformation or resolve a tension; keep under 60 characters if possible |
| **Thumbnail** | One focal point, ≤5 words, brand colors/fonts, readable at 200 px wide |
| **Description** | Keyword-rich first 2 lines; timestamps; links allowed (unlike LinkedIn body links); include website + Calendly |
| **Pinned comment** | Restate the strongest insight + CTA + one link. Reply to early comments here |
| **Tags** | Use 5–10 specific tags; first 2–3 should match the title keyword |
| **End screen** | Point to next best video or playlist, not just a generic subscribe button |

**Evidence to reference:** Long-form sweet spot is 8–15 minutes for retention. YouTube Shorts were extended to 3 minutes in October 2024.

### Step 5 — SEO (for web content only)

If the content publishes online, incorporate without making it obvious:

- **Primary keyword:** in headline, first paragraph, one H2, and naturally 2–4x in body.
- **Secondary keywords:** weave naturally. Never stuff.
- **Meta description:** 150–160 chars. Lead with keyword. End with benefit.
- **Internal linking opportunities:** flag where the user could link to related pages.
- **Title tag:** under 60 chars, separate from on-page H1.

Derive keywords from the loaded offer/audience, not guessed. If no offer context, ask the user for the single primary keyword before writing web content.

### Step 6 — Deliver

Provide the complete, ready-to-publish content. Then, below a divider, offer:

1. **Alternate headlines** (3 options — different angles)
2. **SEO meta description** (if web content)
3. **One-sentence summary** of what makes this piece work
4. **Optional:** a short-form variant (LinkedIn post / thread starter) if the piece is long-form

- **Document clarity:** every generated document follows the Document clarity contract in `skills/SKILL_DEPENDENCIES.md` (Status/Needs header; separate Decisions / Open questions lists; exactly one `## Next action`; no leftover scaffolding).

Do not pad the response with commentary about what you did. Show the work, not the commentary. Close the delivery per the Operator handoff contract: Form A single line when nothing is needed; otherwise Form B (`**Needs your approval:**` with `path:L<n>` cites and/or `**Needs your answer:**`, then exactly one `**Next step:**`).

### Step 7 — Register the piece (Business OS projects)

If `.work.biz/` exists, record the piece in `.work.biz/reference/CONTENT_STATUS.md` so later sessions know it exists (create the file from `templates/work/reference/CONTENT_STATUS.md.template` if missing):

- Add an **Items** row: piece title, status `ready`, or `draft` when an owner pass is still required, target platform in the Note column.
- **Assign the pillar**: name which strategic pillar (from the tracker's **By pillar** list, traceable to one-pager/offer) this piece advances. If the pillar list is empty, define it from the strategy docs first. A piece registered without a pillar is invisible to the quarterly alignment review.
- If the piece is also saved as a file, use the conventional path `.work.biz/drafts/draft_<topic>.md` and reference it in the Note column. The saved file opens with the Status/Needs header (≤4 lines: what this is; `Status: Draft | In review | Approved | Superseded` + date; one-line Needs) and closes with exactly one `## Next action` (or one line `Next action: none — <reason>`), per the Document clarity contract.
- Refresh the **Summary** counts and the **By pillar** pieces count.

Skip this step only when the user explicitly asked for a throwaway fragment.

---

## I2 — `plan` mode

Build a topic plan / content calendar. Output a Markdown table:

| Week | Date range | Topic | Pillar | Type | Channel | Angle / hook seed | Target keyword | Repurpose into |
|------|------------|-------|--------|------|---------|--------------------|----------------|----------------|

Rules:
- Every topic must trace to a loaded audience pain or the operator's proven work. No orphan topics.
- Every topic names the strategic pillar it advances (the 3–5 messages from one-pager/offer, as listed in `CONTENT_STATUS.md` § By pillar). If a pillar gathers no topics across the horizon, that is a finding: report it, because the plan is not carrying the whole strategy.
- Balance the four topic buckets (below) across the horizon; never repeat the same bucket three weeks in a row.
- For each topic, name a real, specific hook seed (not "TBD").
- If the plan is saved as a file, it opens with the Status/Needs header and closes with exactly one `## Next action`, per the Document clarity contract.

**Topic buckets (technology tilt):**

Use the canonical four buckets from `concepts/content-topic-buckets/prompt.md` (BIZ-09):
Architecture lesson · AI in practice · Experience-based insight · Project behind-the-scenes.

For seasonal anchoring (optional, helpful for solo operators):

| Quarter | Theme |
|---------|-------|
| Q1 | "New year, new platform" — planning, architecture foundations, choosing a stack |
| Q2 | "Building in public" — behind-the-scenes, mid-build lessons |
| Q3 | "Deep dives" — architecture depth, AI integration patterns, scaling lessons |
| Q4 | "Reflections" — yearly lessons, what you'd do differently, next-year planning |

---

## I3 — `repurpose` mode

Take one existing piece and produce 3–4 format variants without losing substance:

| Format | Use |
|--------|-----|
| Original long-form | The canonical asset |
| LinkedIn post | Extract the single strongest insight |
| Thread / short-form | 4–8 punchy units, same spine |
| Lead-magnet PDF / case study | Expanded, gated version |

Rule: each variant must stand alone — no "see the full post for context."

---

## I4 — `audit` mode

Critique a draft. Do **not** rewrite wholesale. Output:

1. **Verdict:** publication-ready / needs revision / needs rewrite.
2. **What works** (2–4 bullets, specific).
3. **What fails** (bullets, each tied to a quality rule violated — quote the offending line).
4. **Concrete fixes** (line-level: "replace X with Y because Z").
5. **Missing proof:** list any section making an unproven claim and what evidence would fix it.

---

## I5 — `status` mode (read-only)

Report:
- What context was loaded (or that none exists and `.work.biz` is unbootstrapped).
- Whether a content/brand standard is present and binding.
- The operator's tech stack fingerprint as detected.
- Gaps that would improve output if supplied.

Close the status report per the Operator handoff contract: gaps needing operator input go under `**Needs your answer:**` with exactly one `**Next step:**`; if nothing is needed, end with `Next: nothing - work complete`.

---

## Quality check before delivering (run internally; do not output the checkboxes)

- [ ] Does the first sentence earn its place, or is it a warm-up?
- [ ] Is the hook a specific scene, number, or sharp claim, not an abstract concept?
- [ ] **Appeal:** does the piece take a position an informed peer could disagree with?
- [ ] **Appeal:** do the first two lines contain a concrete scene, named moment, or number?
- [ ] **Appeal:** specificity quota met (at least one proper noun, number, or named artifact per 150 words)?
- [ ] **Appeal:** is the feeling at the moment of the stakes named, not just the facts?
- [ ] Are the stakes visible: what broke, for how long, and what it cost (time, money, risk)?
- [ ] Is the narrator's credibility established early, not buried in a comment?
- [ ] Is there at least one specific number, example, or proof point per major section?
- [ ] Have I cut all hollow adjectives (amazing, cutting-edge, world-class, robust, seamless, scalable unquantified)?
- [ ] **AI-artifact scan:** Zero em-dashes (—) or en-dashes (–). No hedging fillers ("it's important to note"), no generic transitions ("furthermore", "in today's world"), no passive-voice default, no empty intensifiers, no repetitive triplet cadence ("The one that… / The one that… / The one that…"), no literary flourishes.
- [ ] Does the CTA ask for one clear thing?
- [ ] Is the CTA specific and professional, not generic engagement bait?
- [ ] Is the brand voice consistent throughout?
- [ ] Would the target reader find this genuinely useful, not just promotional?
- [ ] Does it sound like a human talking, not a report or chatbot?
- [ ] Are contractions used where natural?
- [ ] Is sentence length varied, or does it fall into a mechanical rhythm?
- [ ] Is the length appropriate for the channel?
- [ ] Technology tilt: is there at least one concrete technical detail per major section?
- [ ] Are unproven claims either backed by a cited source or marked **Unverified**?
- [ ] **LinkedIn only:** No URL in the body or a first comment. Resource named in words (Featured or bio). On a narrative draft, `bash scripts/prose-rhythm-check.sh <file>` was run and the PASS, FAIL, or SKIP line is in the delivery.
- [ ] **LinkedIn only:** If the post contains a checklist/framework, is it in the body or a carousel rather than hidden in the first comment?
- [ ] **LinkedIn only:** Would this survive 30 seconds of scrutiny by a skeptical operator in the ICP's industry?

If any box is unchecked, fix it before delivering.

---

## Completion gate (cannot be skipped)

You may only claim the task complete when all are true:
1. The deliverable is written (or the plan/audit produced).
2. Project context was loaded per I0; any critical gaps were surfaced.
3. The quality check above passes.
4. Unproven claims are flagged **Unverified** or backed by evidence.
5. In a Business OS project, a written piece was registered in `CONTENT_STATUS.md` per Step 7.
6. A concrete next step is proposed (e.g., "supply these proof points," "publish to channel X," "run `@biz-writing repurpose` on this").

- **Operator handoff:** close every operator-facing report per the Operator handoff contract in `skills/SKILL_DEPENDENCIES.md` (Form A single line when nothing is needed; otherwise `**Needs your approval:**` with `path:L<n>` cites, `**Needs your answer:**`, and exactly one `**Next step:**`; omit empty sections).

---

## Time budget

| Mode | Time |
|------|------|
| `write` (short-form) | 15–25 min |
| `write` (long-form) | 30–60 min |
| `plan` | 20–40 min |
| `repurpose` | 20–30 min |
| `audit` | 10–20 min |
| `status` | < 2 min |

---

## Gates & dependencies

This skill has **no hard prerequisite gate** — it can run any time, like an entry-level generative skill. It improves dramatically when the host project is bootstrapped (`@biz-bootstrap init`) and strategy-certified (`@biz-strategy certify`), because then audience, offer, and channel are loaded from project memory rather than guessed.

When Business OS is present and the user is publishing to attract leads, the companion ops skill `@biz-content` governs the *publishing workflow* (calendar, tracker, engagement cadence). This skill governs the *craft* of writing. They compose: use `biz-writing` to draft, `biz-content` to publish and track.

---

## Related skills

| Skill | When |
|-------|------|
| `@biz-social write` | Platform-adapt the draft for Reddit, Instagram, LinkedIn, Facebook, X, YouTube, Substack, or Threads |
| `@biz-social repurpose` | Spin the long-form piece into platform-native social posts |
| `@biz-content publish` | LinkedIn publishing workflow, engagement, repurpose cadence — ops layer |
| `@biz-brand overhaul` | When brand voice / profile is not yet defined |
| `@biz-community find` | Find communities to post the content in |
| `@biz-ideas` | Ideation that content can later amplify |
| `@biz-products` | Product concepts to write case studies about |