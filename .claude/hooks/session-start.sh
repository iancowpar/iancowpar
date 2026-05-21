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
echo "Date:    ${TODAY} (${WEEK})${SUNDAY_HINT}"
echo "State:   brief=${BRIEF_DONE} · eod=${EOD_DONE} · inbox=${INBOX_COUNT}"

if [ "${INBOX_COUNT}" -gt 0 ]; then
  echo ""
  echo "Inbox (untriaged):"
  find inbox -maxdepth 1 -type f -name '*.md' 2>/dev/null | sort | while read -r f; do
    echo "  · $(basename "$f" .md)"
  done
fi

if [ -f "${DAILY_FILE}" ]; then
  PLAN_LINES=$(awk '/^## Plan/{flag=1;next} /^## /{flag=0} flag && NF' "${DAILY_FILE}")
  if [ -n "${PLAN_LINES}" ]; then
    echo ""
    echo "Today's plan:"
    echo "${PLAN_LINES}" | sed 's/^/  /'
  fi
fi

echo ""
echo "INSTRUCTIONS FOR CLAUDE:"
if [ "${BRIEF_DONE}" = "no" ]; then
  echo "- If Ian's first message is a greeting (morning/hi/hey/gm/hello), DO NOT ASK — immediately read .claude/commands/morning.md and execute it. Render the brief in chat."
fi
if [ "${EOD_DONE}" = "no" ]; then
  echo "- If Ian's first message is an end-of-day greeting (night/wrap/eod/done), DO NOT ASK — immediately read .claude/commands/eod.md and execute it. Render the reflection in chat."
fi
if [ "${DOW}" = "7" ]; then
  echo "- It's Sunday: after the morning ritual, ask if Ian wants to run /weekly-review."
fi
echo "- Always deliver results in the chat. Never tell Ian to open a file."
echo "- Stage + commit + push silently at the end of every ritual. Git stays invisible unless it errors."
