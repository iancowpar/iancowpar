---
description: Sunday ritual — create the week's review file with summary + prompts
allowed-tools: Read, Write, Glob, Bash(date:*), Bash(find inbox -type f:*)
---

Run the weekly review.

1. Determine the ISO week: `date +%G-W%V` → e.g., `2026-W21`. Target file: `weekly/2026-W21.md`. If it already exists, ask Ian whether to append or overwrite.

2. Copy `templates/weekly.md`, substituting `{{DATE}}` (today) and `{{WEEK}}` (e.g., `2026-W21`).

3. Summarize the week. Glob `daily/YYYY/MM/*.md` for the last 7 days. For each, extract the `## EOD` section. Roll those up into:
   - 3–5 bullet **Wins** (specific, factual)
   - 2–3 bullet **Misses**
   - 2–3 bullet **Lessons**
   Append them to the appropriate sections in the weekly file.

4. List unprocessed inbox items (`find inbox -maxdepth 1 -type f -name '*.md'`). If any, add a `## Inbox to triage` section listing them and recommend `/inbox`.

5. Leave `## Next week's one thing` blank — that's Ian's to write.

6. Ask Ian: "Anything to add to wins/misses/lessons before we close?"

7. Final line: "Weekly review at weekly/<file>".
