# Directory Map

Canonical layout of the Business OS framework and project memory.

## Framework files (`.ai.biz/`)

Stored in the source Business OS. In thin-client mode they are read from `AI_BIZ_SOURCE` (legacy pointer name: `AGENT_OS_SOURCE`); in fat-client mode they are vendored inside the project.

```text
.ai.biz/
├── skills/              # Reusable agent skills (one folder per skill, each with skill.md)
├── standards/           # Binding business standards
├── concepts/            # Prompt-backed concept frameworks (e.g., BIZ-07, BIZ-08)
├── docs/                # Human-readable guides and adoption docs
├── templates/           # Bootstrap templates
│   ├── cursorrules.template
│   ├── bootstrap.sh
│   └── work/            # .work.biz/ skeleton templates
├── scripts/             # Change-safety and verification scripts
├── hooks/               # Git hooks (optional)
├── .github/             # CI workflows
├── README.md            # Framework overview
├── START_HERE.md        # Decision tree for operators
├── PROCESS_ROUTER.md    # Skill routing table
├── CONVENTIONS.md       # Framework conventions
└── CHANGELOG.md         # Framework changelog
```

## Project memory (`.work.biz/`)

Stored in the consumer project. Never copied from source; owned by the user and `biz-*` skills.

```text
.work.biz/
├── README.md                  # Project memory index
├── gates.md                   # Readiness ledger — the authoritative gate state
├── context/
│   └── HANDOFF.md             # Session handoff
├── plans/
│   ├── NEXT.md                # Tactical next actions
│   ├── UNKNOWNS.md            # Open questions
│   └── youtube-calendar.md    # YouTube publishing calendar (created on demand by `@biz-youtube plan`)
├── strategy/                  # Strategy artifacts (canonical location per CONVENTIONS)
│   ├── certification.md       # Evidence for the strategy-ready gate
│   ├── changelog.md           # Mid-cycle strategy amendments
│   ├── one-pager.md
│   ├── offer-scope.md
│   ├── target-buyer-profile.md
│   ├── channel-plan.md
│   ├── assumption-ledger.md
│   ├── linkedin-icp.md
│   └── pricing.md             # Distilled price range
├── pipeline/
│   ├── pipeline_tracker.md    # Deal flow tracker
│   ├── outreach-cadence.md    # Outreach sequence and follow-up rules
│   ├── youtube-tracker.md     # YouTube publishing + analytics tracker (when YouTube is active)
│   └── <platform>-tracker.md  # Per-platform performance tracker (substack-, threads-, ...)
│                              # from templates/work/pipeline/platform-tracker.md.template
│                              # Created on first publish to that platform, not at bootstrap
├── research/
│   └── research_index.md      # Research index
├── reference/                 # Project reference files
│   ├── CONTENT_STATUS.md      # Publish/status tracker for all content
│   ├── BRAND_STATUS.md        # Brand audit history + overhaul log (brand-ready evidence)
│   ├── VOICE_PROFILE.md       # How this owner sounds (binding for every content skill)
│   ├── VOICE_RETRO.md         # Draft vs owner edits; measures whether VOICE_PROFILE works
│   ├── OPERATOR_PROFILE.md    # Operator skills, proof points, constraints; @biz-strategy career
│   ├── PROJECTS.md            # Case studies and proof points
│   └── VISUAL_GUIDE.md        # Banner specs, palette, typography
├── drafts/                    # In-progress drafts
├── ideas/                     # Generated content pieces: one subdir per content type
│                              # (posts/, articles/, substack/, x/, videos-linkedin/, ...),
│                              # one directory per piece
├── ideas.archive/             # Published pieces, moved from ideas/ by @biz-archive
│                              # with the subdirectory structure mirrored; each archived
│                              # piece dir carries its own status.md publish record
├── context/HANDOFF.archive.md # Older HANDOFF session blocks (Context budget, CONVENTIONS)
├── plans/NEXT.archive.md      # Resolved NEXT narration (Context budget)
├── plans/UNKNOWNS.archive.md  # Resolved UNKNOWNS rows (Context budget)
└── touch-scope                # Declared change scope for current work (session-local)
```

**Path rule:** `biz-strategy` writes strategy artifacts to `.work.biz/strategy/`. All other skills read from `.work.biz/strategy/`. Do not scatter strategy files under `.work.biz/plans/`.

**Tracker rule:** `reference/CONTENT_STATUS.md` is the cross-platform index of what content exists and whether it is published. `pipeline/<platform>-tracker.md` holds per-platform performance. Keep them separate: a single shared metrics schema forces every platform to be measured by impressions, which is the metric least connected to revenue. Every tracker carries a conversations table, because a platform with reach and no conversations is producing authority rather than pipeline and should be reported that way. Who reads and writes `CONTENT_STATUS.md`, the lifecycle states, and the self-heal rule are defined in `CONVENTIONS.md` § Content Status Protocol.

**Archive rule:** when the operator asks to archive published content, `@biz-archive` moves each `published` piece from `ideas/<subdir>/<piece>` to `ideas.archive/<subdir>/<piece>`, mirroring the subdirectory structure, and writes a per-piece `status.md` into the archived directory carrying the tracker row's publish record (status, date, platform/URL, pillar, notes). Once that record exists, the piece's row leaves `CONTENT_STATUS.md`, which tracks the active inventory only. Only piece directories move: loose files, category `README.md`s, research notes, backup dirs, and the legacy `ideas/VOICE_STANDARD.md` voice fallback stay in place. Moves use `git mv` for tracked files (staged, never committed by the skill) and plain `mv` for untracked ones.

**Voice rule:** `.work.biz/reference/VOICE_PROFILE.md` is the canonical location for the owner's voice definition. Content skills read it there first, then fall back to the legacy paths `ideas/VOICE_STANDARD.md`, `reference/VOICE_STANDARD.md`, and `reference/voice-profile.md`. Do not scatter voice rules across scoped documents: a voice file scoped to one directory only applies when work happens in that directory, which is how LinkedIn-only voice discipline happens by accident.

**Gate rule:** `.work.biz/gates.md` is the only authoritative record of readiness state. Each gate has exactly one promoting skill (see `skills/SKILL_DEPENDENCIES.md` § Gate Descriptions). Gated skills read it in their I0 pre-check; `scripts/gate-verify.sh` fails when a gate claims PASS without its evidence on disk.

## Protected project files

The agent must not modify these without explicit user approval:

- `package.json`
- `docker-compose*.yml`
- `Dockerfile.*`
- `.env*` (except `.env.example`)

## Resolution rule

When the source resolution section in `.cursorrules` says `AI_BIZ_SOURCE` is set, read framework assets from that path. Otherwise read them locally from the project's own `.ai.biz/`. (Legacy installs name the pointer `AGENT_OS_SOURCE`; it counts only when it resolves to a valid Business OS root, and `@biz-deploy-basic update` migrates it to `AI_BIZ_SOURCE`.)
