#!/usr/bin/env bash
# bootstrap.sh — Business OS scaffold for any project
#
# Usage:
#   bash .ai.biz/templates/bootstrap.sh
#   REPO_ROOT=/path/to/app bash .ai.biz/templates/bootstrap.sh
#
set -euo pipefail

# The target is chosen by REPO_ROOT, never by a positional argument. Accepting one
# silently would be worse than useless: the fallback below resolves to the Business
# OS repo itself when it is a git repo, so `bootstrap.sh /path/to/project` would
# scaffold into the framework instead of the project and report success.
if [[ $# -gt 0 ]]; then
  echo "bootstrap.sh: unexpected argument '$1'" >&2
  echo "" >&2
  echo "The target is set with REPO_ROOT, not a positional argument:" >&2
  echo "  REPO_ROOT=/path/to/project bash .ai.biz/templates/bootstrap.sh" >&2
  echo "" >&2
  echo "Run with no arguments to scaffold the enclosing project." >&2
  exit 2
fi

if [[ -n "${BIZ_SOURCE:-}" ]]; then
  BIZ_ROOT="$(cd "$BIZ_SOURCE" && pwd)"
else
  BIZ_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
TPL="${BIZ_ROOT}/templates/work"

if [[ -n "${REPO_ROOT:-}" ]]; then
  REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"
elif [[ -d "${BIZ_ROOT}/.git" ]]; then
  REPO_ROOT="${BIZ_ROOT}"
elif [[ -d "${BIZ_ROOT}/../.git" ]] && [[ -d "${BIZ_ROOT}/templates" ]]; then
  REPO_ROOT="$(cd "${BIZ_ROOT}/.." && pwd)"
else
  REPO_ROOT="${BIZ_ROOT}"
fi

WORK="${REPO_ROOT}/.work.biz"

copy_if_missing() {
  local src="$1" dest="$2"
  if [[ -e "${dest}" ]]; then
    echo "skip (exists): ${dest}"
  else
    mkdir -p "$(dirname "${dest}")"
    cp "${src}" "${dest}"
    echo "created: ${dest}"
  fi
}

echo "Business OS bootstrap"
echo "  BIZ_ROOT=${BIZ_ROOT}"
echo "  REPO_ROOT=${REPO_ROOT}"
echo ""

mkdir -p "${WORK}"

copy_if_missing "${TPL}/README.md.template" "${WORK}/README.md"
copy_if_missing "${TPL}/gates.md.template" "${WORK}/gates.md"
copy_if_missing "${TPL}/context/HANDOFF.md.template" "${WORK}/context/HANDOFF.md"
copy_if_missing "${TPL}/plans/NEXT.md.template" "${WORK}/plans/NEXT.md"
copy_if_missing "${TPL}/plans/UNKNOWNS.md.template" "${WORK}/plans/UNKNOWNS.md"
copy_if_missing "${TPL}/pipeline/pipeline_tracker.md.template" "${WORK}/pipeline/pipeline_tracker.md"
copy_if_missing "${TPL}/pipeline/outreach-cadence.md.template" "${WORK}/pipeline/outreach-cadence.md"
copy_if_missing "${TPL}/research/research_index.md.template" "${WORK}/research/research_index.md"
copy_if_missing "${TPL}/strategy/README.md.template" "${WORK}/strategy/README.md"
copy_if_missing "${TPL}/decisions/DECISIONS.md.template" "${WORK}/decisions/DECISIONS.md"
copy_if_missing "${TPL}/reference/CONTENT_STATUS.md.template" "${WORK}/reference/CONTENT_STATUS.md"
copy_if_missing "${TPL}/reference/BRAND_STATUS.md.template" "${WORK}/reference/BRAND_STATUS.md"
copy_if_missing "${TPL}/reference/VOICE_PROFILE.md.template" "${WORK}/reference/VOICE_PROFILE.md"
copy_if_missing "${TPL}/reference/VOICE_RETRO.md.template" "${WORK}/reference/VOICE_RETRO.md"
copy_if_missing "${TPL}/reference/OPERATOR_PROFILE.md.template" "${WORK}/reference/OPERATOR_PROFILE.md"
copy_if_missing "${TPL}/reference/PROJECTS.md.template" "${WORK}/reference/PROJECTS.md"

for dir in context plans pipeline research drafts strategy reference ideas ideas.archive decisions; do
  mkdir -p "${WORK}/${dir}"
done

echo ""
echo "--- .cursorrules ---"
if [[ -n "${BOOTSTRAP_SKIP_CURSERRULES:-}" ]]; then
  echo "skip (.cursorrules owned by caller): ${REPO_ROOT}/.cursorrules"
elif [[ -f "${REPO_ROOT}/.cursorrules" ]]; then
  echo "skip (exists): ${REPO_ROOT}/.cursorrules"
else
  copy_if_missing "${BIZ_ROOT}/templates/cursorrules.template" "${REPO_ROOT}/.cursorrules"
fi

echo ""
echo "Next: @biz-strategy greenfield · fill REPLACE: tokens in .cursorrules"
