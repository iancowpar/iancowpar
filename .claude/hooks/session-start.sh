#!/usr/bin/env bash
# Personal OS SessionStart hook
# stdout becomes context for Claude. Keep output short and factual.
set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}"

TODAY="$(date +%Y-%m-%d)"
YEAR="$(date +%Y)"
MONTH="$(date +%m)"
WEEK="$(date +%G-W%V)"
DAILY_DIR="daily/${YEAR}/${MONTH}"
DAILY_FILE="${DAILY_DIR}/${TODAY}.md"

mkdir -p "${DAILY_DIR}"

if [ ! -f "${DAILY_FILE}" ] && [ -f "templates/daily.md" ]; then
  sed "s/{{DATE}}/${TODAY}/g" templates/daily.md > "${DAILY_FILE}"
fi

INBOX_COUNT=0
if [ -d inbox ]; then
  INBOX_COUNT=$(find inbox -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
fi

LATEST_WEEKLY=""
if [ -d weekly ]; then
  LATEST_WEEKLY=$(ls -1 weekly/*.md 2>/dev/null | sort | tail -n 1 || true)
fi

BRIEF_DONE="no"
EOD_DONE="no"
if [ -f "${DAILY_FILE}" ]; then
  grep -q '^## Brief' "${DAILY_FILE}" && BRIEF_DONE="yes"
  awk '/^## EOD/{flag=1;next} /^## /{flag=0} flag && NF{found=1} END{exit !found}' "${DAILY_FILE}" && EOD_DONE="yes"
fi

DOW=$(date +%u)
SUNDAY_HINT=""
if [ "${DOW}" = "7" ]; then
  SUNDAY_HINT=" — it's Sunday; offer /weekly-review"
fi

echo "=== Personal OS — session context ==="
echo "Date:           ${TODAY} (${WEEK})${SUNDAY_HINT}"
echo "Today's note:   ${DAILY_FILE}"
echo "Brief done:     ${BRIEF_DONE}"
echo "EOD done:       ${EOD_DONE}"
echo "Inbox items:    ${INBOX_COUNT}"
echo "Latest weekly:  ${LATEST_WEEKLY:-none}"
echo ""
echo "Routing (see CLAUDE.md): greet 'good morning' → /morning (if brief not done); 'good night' → /eod (if EOD not done)."
