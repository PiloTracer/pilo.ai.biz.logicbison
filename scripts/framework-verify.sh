#!/usr/bin/env bash
# framework-verify.sh — Self-verification for Business OS framework
set -euo pipefail

SELF_TEST="${1:-}"
if [ "$SELF_TEST" = "--self-test" ]; then
  echo "framework-verify self-test: PASS"
  exit 0
fi

AI_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$AI_ROOT"

errors=0
note() { echo ""; echo "==> $1"; }
ok() { echo "    OK: $1"; }
die() { echo "    FAIL: $1"; errors=$((errors + 1)); }

echo "=== Business OS Framework Verify ==="

note "Required tools"
for cmd in git rsync bash grep find perl; do
  if command -v "$cmd" &>/dev/null; then ok "$cmd"; else die "missing $cmd"; fi
done

note "Git repo"
git rev-parse --is-inside-work-tree &>/dev/null && ok "inside git work tree" || die "not a git repository"

note "Core files"
for f in README.md START_HERE.md LICENSE templates/bootstrap.sh \
  scripts/biz-deploy-basic.sh scripts/biz-deploy-files.sh \
  scripts/biz-cursorrules-verify.sh; do
  [[ -f "$AI_ROOT/$f" ]] && ok "$f" || die "missing $f"
done

note "Skills registered"
skill_count=0
while IFS= read -r d; do
  id="$(basename "$d")"
  skill_count=$((skill_count + 1))
  [[ -f "$d/skill.md" ]] || die "skills/${id}/skill.md missing"
  grep -qE "^\| ${id} " "$AI_ROOT/skills/README.md" || die "skills/${id} not in skills/README.md"
  # Frontmatter name must match folder name.
  fm_name="$(grep -m1 '^name:' "$d/skill.md" | sed 's/^name:[[:space:]]*//' | tr -d '[:space:]')"
  [[ "$fm_name" == "$id" ]] || die "skills/${id}/skill.md frontmatter name '${fm_name}' does not match folder"
done < <(find "$AI_ROOT/skills" -mindepth 1 -maxdepth 1 -type d ! -name '.*' | sort)
ok "${skill_count} skills registered"

# README skill count must match folder count.
readme_count="$(grep -oE '[0-9]+ skills in total' "$AI_ROOT/README.md" | grep -oE '[0-9]+' | head -1 || true)"
if [[ -n "$readme_count" ]] && [[ "$readme_count" -eq "$skill_count" ]]; then
  ok "README.md skill count (${readme_count}) matches folder count"
else
  die "README.md skill count (${readme_count:-missing}) does not match folder count (${skill_count})"
fi

# .cursorrules skills table must include every skill listed in skills/README.md.
while IFS= read -r skill_id; do
  [[ -z "$skill_id" ]] && continue
  grep -qE "^\\| ${skill_id} " "$AI_ROOT/.cursorrules" || die "skills/README.md lists '${skill_id}' but it is missing from .cursorrules skills table"
done < <(awk '/^## Registered skills$/{flag=1; next} flag && /^## /{flag=0} flag && /^[|]/{print $2}' "$AI_ROOT/skills/README.md" | grep -E '^[a-z0-9_-]+$' | sort -u)
ok ".cursorrules skills table covers skills/README.md entries"

# Every skill.md must be tracked by git (catches new-but-unstaged skills).
while IFS= read -r skill_md; do
  git ls-files --error-unmatch "$skill_md" >/dev/null 2>&1 || die "${skill_md} is not tracked by git — stage before commit"
done < <(find "$AI_ROOT/skills" -mindepth 2 -maxdepth 2 -type f -name 'skill.md' | sort)
ok "all skill.md files are tracked by git"

note "Operator handoff contract adoption"
# Every skill must reference the Operator handoff contract so operator-facing
# reports close with Form A/Form B. A skill that drops the reference quietly
# reverts to ambiguous "what do you need from me?" endings.
grep -q '^## Operator handoff contract' "$AI_ROOT/skills/SKILL_DEPENDENCIES.md" \
  || die "skills/SKILL_DEPENDENCIES.md is missing '## Operator handoff contract'"
while IFS= read -r skill_md; do
  grep -q "Operator handoff contract" "$skill_md" \
    || die "${skill_md} does not reference the Operator handoff contract"
done < <(find "$AI_ROOT/skills" -mindepth 2 -maxdepth 2 -type f -name 'skill.md' | sort)
ok "SKILL_DEPENDENCIES.md defines the contract and every skill.md references it"

note "Document clarity contract adoption"
# Doc-generating skills produce reader-facing deliverables (plans, strategy
# docs, proposals, drafts, reports, validation logs). Each must reference the
# Document clarity contract so generated documents carry a Status/Needs
# header, separate Decisions/Open questions lists, and exactly one
# `## Next action`.
grep -q '^## Document clarity contract' "$AI_ROOT/skills/SKILL_DEPENDENCIES.md" \
  || die "skills/SKILL_DEPENDENCIES.md is missing '## Document clarity contract'"
DOC_GENERATING="biz-strategy biz-brand biz-pricing biz-proposal biz-review biz-writing biz-ideas biz-products biz-content biz-social biz-youtube biz-market-validate biz-pipeline-diagnosis biz-advisory biz-sources"
for skill in $DOC_GENERATING; do
  grep -q "Document clarity contract" "$AI_ROOT/skills/${skill}/skill.md" \
    || die "skills/${skill}/skill.md is doc-generating but does not reference the Document clarity contract"
done
ok "SKILL_DEPENDENCIES.md defines the contract and all $(wc -w <<<"$DOC_GENERATING") doc-generating skills reference it"

note "Standards non-empty"
std_count=0
while IFS= read -r f; do
  std_count=$((std_count + 1))
  lines="$(wc -l < "$f")"
  [[ "$lines" -gt 5 ]] || die "standard $(basename "$f") is empty or a stub (${lines} lines)"
done < <(find "$AI_ROOT/standards" -maxdepth 1 -type f -name '*.md' | sort)
ok "${std_count} standards non-empty"

note "Content Status Protocol wiring"
# Publish tracking only works if every content-producing skill reads and writes
# the canonical tracker. A skill that quietly stops referencing CONTENT_STATUS.md
# starves the tracker in every target project — exactly the failure mode this
# check exists to catch.
for skill in biz-writing biz-social biz-content biz-youtube; do
  grep -q "CONTENT_STATUS.md" "$AI_ROOT/skills/${skill}/skill.md" \
    || die "skills/${skill}/skill.md does not reference CONTENT_STATUS.md (Content Status Protocol)"
done
grep -q "Content Status Protocol" "$AI_ROOT/CONVENTIONS.md" \
  || die "CONVENTIONS.md is missing the Content Status Protocol section"
grep -q '^| `log` |' "$AI_ROOT/skills/README.md" \
  || die "skills/README.md verb table is missing the log verb (biz-social)"
ok "all four content skills reference CONTENT_STATUS.md; protocol + log verb documented"

note "Archive wiring (ideas → ideas.archive)"
# The archive feature only works if every surface agrees: the skill exists, the
# binding rules are documented, the verb is routable, and the directory map
# canonizes both directories. A missing surface silently reverts target
# projects to ad-hoc manual moves.
grep -q "ideas.archive" "$AI_ROOT/skills/biz-archive/skill.md" \
  || die "skills/biz-archive/skill.md does not reference ideas.archive"
grep -q "Archive rule" "$AI_ROOT/CONVENTIONS.md" \
  || die "CONVENTIONS.md is missing the Archive rule (Content Status Protocol)"
grep -q "ideas.archive" "$AI_ROOT/standards/20260621-DIRECTORY_MAP.md" \
  || die "standards/20260621-DIRECTORY_MAP.md does not canonize ideas.archive/"
grep -q '^| `archive` |' "$AI_ROOT/skills/README.md" \
  || die "skills/README.md verb table is missing the archive verb (biz-archive)"
grep -q "ideas.archive" "$AI_ROOT/templates/work/reference/CONTENT_STATUS.md.template" \
  || die "CONTENT_STATUS.md.template is missing the archive convention"
grep -q "ideas.archive" "$AI_ROOT/templates/work/README.md.template" \
  || die "work/README.md.template is missing the ideas.archive/ row"
grep -q "status.md" "$AI_ROOT/skills/biz-archive/skill.md" \
  || die "skills/biz-archive/skill.md does not write the per-piece status.md publish record"
grep -q "status.md" "$AI_ROOT/templates/work/reference/CONTENT_STATUS.md.template" \
  || die "CONTENT_STATUS.md.template does not document the per-piece status.md / active-inventory rule"
grep -q "Context budget" "$AI_ROOT/CONVENTIONS.md" \
  || die "CONVENTIONS.md is missing the Context budget section"
grep -q "HANDOFF.archive.md" "$AI_ROOT/skills/biz-session/skill.md" \
  || die "biz-session close does not implement the HANDOFF slim-down (Context budget)"
ok "biz-archive skill + Archive rule + verb + directory map + templates all wired"

note "Frameworks registry wiring (cross-framework discovery)"
# The sister-framework registry only works if every surface agrees: the shared
# discovery lib exists, the source .cursorrules and the deployed template carry
# the registry, and both the deploy script and the verifier use the lib. A
# missing surface silently breaks cross-framework routing in thin targets.
[[ -f "$AI_ROOT/scripts/sister-discovery.sh" ]] \
  || die "scripts/sister-discovery.sh missing (cross-framework discovery)"
grep -q 'FRAMEWORK_SLOTS=' "$AI_ROOT/scripts/sister-discovery.sh" \
  || die "scripts/sister-discovery.sh does not export FRAMEWORK_SLOTS"
grep -q 'Frameworks registry' "$AI_ROOT/.cursorrules" \
  || die ".cursorrules is missing the Frameworks registry"
grep -q 'Path resolution' "$AI_ROOT/.cursorrules" \
  || die ".cursorrules Frameworks registry lacks the path-resolution contract"
for fwrow in '| `\.ai\.biz`' '| `\.ai`' '| `\.ai\.cto`' '| `\.ai\.flutter`' '| `\.ai\.mlt`' '| `\.ai\.soc`' '| `\.ai\.ui`'; do
  grep -qE "$fwrow" "$AI_ROOT/.cursorrules" \
    || die ".cursorrules Frameworks registry missing row: $fwrow"
done
for tok in AI_PATH AI_UI_PATH AI_SOC_PATH AI_CTO_PATH AI_FLUTTER_PATH AI_MLT_PATH; do
  grep -q "REPLACE:${tok} " "$AI_ROOT/templates/cursorrules.template" \
    || die "templates/cursorrules.template missing REPLACE:${tok} cell"
done
grep -q 'sister-discovery.sh' "$AI_ROOT/scripts/biz-deploy-basic.sh" \
  || die "biz-deploy-basic.sh does not source sister-discovery.sh"
grep -q 'FRAMEWORK_SLOTS' "$AI_ROOT/scripts/biz-deploy-basic.sh" \
  || die "biz-deploy-basic.sh does not fill the REPLACE:AI_*_PATH cells"
grep -q 'sister-discovery.sh' "$AI_ROOT/scripts/biz-cursorrules-verify.sh" \
  || die "biz-cursorrules-verify.sh does not source sister-discovery.sh"
ok "sister-discovery lib + registry (7 rows) + template tokens + deploy/verifier wiring all present"
# Reachability of the source registry's filled path cells is host state, not
# wiring — a host without a sister installed must still verify green (runtime
# routes that framework degraded, per the path-resolution contract).
while IFS='|' read -r _ _ _ cell _; do
  [[ "$cell" == *"*this directory*"* ]] && continue
  p="$(printf '%s' "$cell" | tr -d '`' | sed 's/ (default[^)]*)//' | xargs)"
  [[ -z "$p" || "$p" == REPLACE:* ]] && continue
  if [[ -d "$AI_ROOT/$p" && -f "$AI_ROOT/$p/skills/README.md" ]]; then
    ok "registry cell ${p} resolves"
  else
    echo "    info: registry cell ${p} not installed on this host (runtime routes degraded)"
  fi
done < <(sed -n '/^| `\.ai\.biz`/,/^$/p' "$AI_ROOT/.cursorrules")

note "Bootstrap ↔ WORK_DIRS dir sync"
# The dir loop in bootstrap.sh and WORK_DIRS in biz-deploy-basic.sh must list
# the same .work.biz/ scaffold directories. WORK_FILES has a machine check;
# dirs drifted unchecked until this one existed.
bootstrap_dirs="$(sed -n 's/^for dir in \(.*\); do$/\1/p' "$AI_ROOT/templates/bootstrap.sh" | tr ' ' '\n' | sort -u)"
work_dirs="$(sed -n '/^WORK_DIRS=(/,/^)/p' "$AI_ROOT/scripts/biz-deploy-basic.sh" \
  | grep -oE '"[^"]+"' | tr -d '"' | sort -u)"
dir_rc=0
while IFS= read -r d; do
  [[ -z "$d" ]] && continue
  if ! grep -qxF "$d" <<< "$work_dirs"; then
    die "bootstrap.sh creates dir .work.biz/$d but WORK_DIRS omits it"
    dir_rc=1
  fi
done <<< "$bootstrap_dirs"
while IFS= read -r d; do
  [[ -z "$d" ]] && continue
  if ! grep -qxF "$d" <<< "$bootstrap_dirs"; then
    die "WORK_DIRS lists $d but bootstrap.sh never creates it"
    dir_rc=1
  fi
done <<< "$work_dirs"
[[ "$dir_rc" -eq 0 ]] && ok "bootstrap.sh dir loop and WORK_DIRS list the same scaffold dirs"

note "Bootstrap ↔ WORK_FILES manifest sync"
# bootstrap.sh and biz-deploy-basic.sh WORK_FILES must list the same
# .work.biz/ scaffold set. WORK_FILES is the one that fails quietly:
# --update only offers files listed there, so an artifact missing from it is
# silently never updated on existing installs. This check is the machine
# answer to that silent divergence.
bootstrap_files="$(grep -oE '"\$\{WORK\}/[^"]+"' "$AI_ROOT/templates/bootstrap.sh" \
  | sed 's|"${WORK}/||; s|"$||' | grep -v '\$' | sort -u)"
work_files="$(sed -n '/^WORK_FILES=(/,/^)/p' "$AI_ROOT/scripts/biz-deploy-basic.sh" \
  | grep -oE '"[^"]+"' | tr -d '"' | sort -u)"
manifest_rc=0
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  if ! grep -qxF "$f" <<< "$work_files"; then
    die "bootstrap.sh creates .work.biz/$f but WORK_FILES omits it — biz-deploy-basic --update will never offer it"
    manifest_rc=1
  fi
done <<< "$bootstrap_files"
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  if ! grep -qxF "$f" <<< "$bootstrap_files"; then
    die "WORK_FILES lists $f but bootstrap.sh never creates it"
    manifest_rc=1
  fi
done <<< "$work_files"
[[ "$manifest_rc" -eq 0 ]] && ok "bootstrap.sh and WORK_FILES list the same scaffold set"

note "biz-deploy-files in-place scaffold"
DF_SMOKE="$(mktemp -d)"
pushd "$DF_SMOKE" >/dev/null
bash "$AI_ROOT/scripts/biz-deploy-files.sh" . >/dev/null
[[ -f .cursorrules ]] || die "biz-deploy-files in-place missing .cursorrules"
[[ -f .work.biz/context/HANDOFF.md ]] || die "biz-deploy-files in-place missing .work.biz/context/HANDOFF.md"
[[ -d .ai.biz/skills ]] || die "biz-deploy-files in-place missing .ai.biz/skills"
popd >/dev/null
ok "biz-deploy-files in-place creates .ai.biz/ + .work.biz/ + .cursorrules"
rm -rf "$DF_SMOKE"

note "biz-deploy-basic thin-client scaffold"
DB_SMOKE="$(mktemp -d)"
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" "$DB_SMOKE" >/dev/null
if [[ -f "${DB_SMOKE}/.cursorrules" ]] && grep -q 'AI_BIZ_SOURCE=' "${DB_SMOKE}/.cursorrules"; then
  ok "biz-deploy-basic creates thin-client .cursorrules + .work.biz/"
else
  die "biz-deploy-basic thin-client scaffold failed"
fi

note "Deploy argument normalization (bare verb ≡ --flag)"
# The same deploy into two fresh targets via both spellings must produce
# byte-identical .cursorrules, and '-' separators must be ignored.
EQ_A="$(mktemp -d)"; EQ_B="$(mktemp -d)"
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" "$EQ_A" update >/dev/null
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" - "$EQ_B" --update >/dev/null
if cmp -s "${EQ_A}/.cursorrules" "${EQ_B}/.cursorrules"; then
  ok "biz-deploy-basic: '<path> update' ≡ '- <path> --update'"
else
  die "biz-deploy-basic: bare 'update' and '--update' produced different .cursorrules"
fi
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" status "$EQ_A" >/dev/null \
  && ok "biz-deploy-basic: bare 'status' accepted (path in any position)" \
  || die "biz-deploy-basic: bare 'status' form failed on a healthy target"
bash "$AI_ROOT/scripts/biz-deploy-files.sh" "$EQ_A" --status >/dev/null \
  && ok "biz-deploy-files: status mode present" \
  || die "biz-deploy-files: status mode failed"
rm -rf "$EQ_A" "$EQ_B"

note "biz-cursorrules-verify repair cycle"
# A deliberately broken thin-client target must FAIL read-only verification,
# then PASS after --fix re-syncs the pointer and re-bakes script paths.
CV_SMOKE="$(mktemp -d)"
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" "$CV_SMOKE" >/dev/null
mv "${CV_SMOKE}/.cursorrules" "${CV_SMOKE}/.cursorrules.bak"
sed "s#AI_BIZ_SOURCE=${AI_ROOT}#AI_BIZ_SOURCE=/nonexistent/stale/.ai.biz#" "${CV_SMOKE}/.cursorrules.bak" > "${CV_SMOKE}/.cursorrules"
rm -f "${CV_SMOKE}/.cursorrules.bak"
if bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$CV_SMOKE" >/dev/null 2>&1; then
  die "biz-cursorrules-verify passed a deliberately broken target"
else
  ok "biz-cursorrules-verify flags stale AI_BIZ_SOURCE"
fi
bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$CV_SMOKE" --fix >/dev/null
if bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$CV_SMOKE" >/dev/null 2>&1 \
   && grep -q "AI_BIZ_SOURCE=${AI_ROOT}\$" "${CV_SMOKE}/.cursorrules"; then
  ok "biz-cursorrules-verify --fix repairs stale pointer"
else
  die "biz-cursorrules-verify --fix did not repair the stale pointer"
fi
rm -rf "$CV_SMOKE" "$DB_SMOKE"

note "Legacy AGENT_OS_SOURCE pointer migration"
# A target still on the old pointer name (value = a valid Business OS root)
# must be migrated to AI_BIZ_SOURCE by --fix — renamed in place, not duplicated.
LG_SMOKE="$(mktemp -d)"
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" "$LG_SMOKE" >/dev/null
sed -i "s#^AI_BIZ_SOURCE=${AI_ROOT}\$#AGENT_OS_SOURCE=${AI_ROOT}#" "${LG_SMOKE}/.cursorrules"
bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$LG_SMOKE" --fix >/dev/null
if grep -q "AI_BIZ_SOURCE=${AI_ROOT}\$" "${LG_SMOKE}/.cursorrules" \
   && ! grep -q '^AGENT_OS_SOURCE=' "${LG_SMOKE}/.cursorrules" \
   && bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$LG_SMOKE" >/dev/null 2>&1; then
  ok "--fix migrates legacy AGENT_OS_SOURCE → AI_BIZ_SOURCE"
else
  die "--fix did not migrate the legacy AGENT_OS_SOURCE pointer"
fi
rm -rf "$LG_SMOKE"

note "Foreign AGENT_OS_SOURCE guard (mixed Agent OS + Business OS repo)"
# AGENT_OS_SOURCE pointing at a valid root of a DIFFERENT framework must be
# left untouched by --fix — never read as the biz pointer, never rewritten.
FG_SMOKE="$(mktemp -d)"; FG_FOREIGN="$(mktemp -d)"
mkdir -p "$FG_FOREIGN/skills" && echo "# foreign framework" > "$FG_FOREIGN/skills/README.md"
bash "$AI_ROOT/scripts/biz-deploy-basic.sh" "$FG_SMOKE" >/dev/null
sed -i "s#^AI_BIZ_SOURCE=${AI_ROOT}\$#AGENT_OS_SOURCE=${FG_FOREIGN}#" "${FG_SMOKE}/.cursorrules"
bash "$AI_ROOT/scripts/biz-cursorrules-verify.sh" "$FG_SMOKE" --fix >/dev/null 2>&1 || true
if grep -q "AGENT_OS_SOURCE=${FG_FOREIGN}\$" "${FG_SMOKE}/.cursorrules" \
   && ! grep -q "AI_BIZ_SOURCE=${FG_FOREIGN}" "${FG_SMOKE}/.cursorrules"; then
  ok "--fix leaves a foreign AGENT_OS_SOURCE pointer untouched"
else
  die "--fix rewrote a foreign framework's AGENT_OS_SOURCE pointer"
fi
rm -rf "$FG_SMOKE" "$FG_FOREIGN"

echo ""
if [[ "$errors" -eq 0 ]]; then
  echo "framework-verify: all checks passed"
else
  echo "framework-verify: $errors error(s)"
fi
exit "$errors"
