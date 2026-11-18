# Plan — stop the framework from teaching the voice it forbids

**Date:** 2026-11-17
**Status:** Applied 2026-11-17. `framework-verify` exit 0. Not a release. Version stays v0.8.0.

## What this repo is

Business OS is the playbook a coding agent runs for a services business: skills, binding standards, and `.work.biz/` memory. Quality here means the next post, proposal, or piece of advice is specific, scoreable, and written in the operator's voice. Another unused mechanism is not quality. v0.8.0 already said that, and it is still true.

## Confirmed (read in this session)

1. `skills/biz-social/platforms/linkedin.md` and `linkedin-video.md` already forbid link-in-first-comment, the "first 60 minutes decide reach" verdict, and 3–5 hashtags. Evidence is grade C in `docs/sources/verified-sources.md` § LinkedIn distribution (2026).
2. The files an agent loads when asked to write still teach the old tactics:
   - `standards/20260621-CONTENT-STANDARD.md` § LinkedIn: "First comment: links to resources."
   - `skills/biz-writing/skill.md`: a block marked CRITICAL that tells the operator to post the link as the first comment, plus "Hashtags: 3-5 max."
   - `skills/biz-social/skill.md` delivery checklist: "placed as a first-comment suggestion" and "reminded to post the link as the first comment."
   - `skills/biz-content/skill.md` posting ritual: "First comment within 60 seconds" and "First 60 minutes."
3. The "Good" examples inside `linkedin.md` contain em dashes (`Here's why — and what I almost got wrong`, `isn't optional — it's survival`). Agents copy examples.
4. `scripts/prose-rhythm-check.sh` exists because the operator rejected a draft whose sentence rhythm "totally signal[ed] AI-generated." The rule was already in the Content Standard. The script's `--self-test` is already executed by `framework-verify` (it runs every script that advertises `--self-test`). The writing skills never tell the agent to run it or report the result.
5. `@biz-advisory` requires the reframe **"don't sell X — sell Y"**. That is the contrastive shape the Content Standard already bans ("not just X, it's Y"), plus an em dash, and it is the sentence the operator is told to reuse with buyers.
6. Byte budgets, measured this session: `biz-writing` 30,843 / 31,000; `biz-social` 61,942 / 61,942 grandfathered. Growth fails `framework-verify`. Replacements have to shrink or stay flat.
7. `.work.biz/reference/VOICE_PROFILE.md` is an unfilled skeleton. Inventing a voice here would violate the profile's own rule: voice is defined by samples, not description.

## Inference

An agent invoked as `@biz-writing` or `@biz-social write` follows the skill in front of it. The corrected platform guide is not loaded unless that skill says to load it. So the live drafting path still produces the penalized post.

## Unknown (left open on purpose)

Whether the corrected instructions change a real draft. That is settled by one post run through `prose-rhythm-check.sh` and an owner pass, not by another rule. UNKNOWNS #25 stays open until that happens.

## What this session changes

1. Content Standard LinkedIn section aligned with the 2026 correction.
2. `biz-writing`, `biz-social`, and `biz-content` stop instructing the three penalized tactics. `biz-writing` must run `prose-rhythm-check.sh` on narrative drafts and report PASS, FAIL, or SKIP.
3. Quoted "good" examples in `linkedin.md` lose the em dash. The stale posting-ritual row in the same file is corrected.
4. Contrastive negation ("It's not X. It's Y.", "don't sell X, sell Y") is named as a structural red flag, extending the existing "not just X, it's Y" ban.
5. Advisory reframes are affirmative sentences a buyer can hear. The pattern library stops requesting the banned shape.
6. `framework-verify` fails if the old first-comment instruction strings return.

## What this session does not change

- No version bump, no tag. A CHANGELOG release heading without a tag fails `framework-verify`.
- No invented `VOICE_PROFILE`. The operator fills it from real samples.
- No career-search artifact and no invented market numbers. NEXT's recommended action (one live `@biz-career search`) is still the higher-leverage unused step.
- Facebook, Instagram, and YouTube "first comment" rules stay. They are different mechanisms, and the Facebook link workaround is already marked unverified.
