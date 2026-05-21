---
description: Sunday ritual — deliver the week's review inline with summary + prompts
allowed-tools: Read, Write, Edit, Glob, Bash
---

Run the weekly review.

1. Determine the ISO week (`date +%G-W%V`, e.g., `2026-W21`). Target file: `weekly/<WEEK>.md`. If it already exists, ask Ian whether to append or overwrite.

2. Glob `daily/YYYY/MM/*.md` for the last 7 days. For each, extract the `## EOD` section. Roll up:
   - 3–5 bullet **Wins** (specific, factual, in Ian's words)
   - 2–3 bullet **Misses**
   - 2–3 bullet **Lessons**

3. List unprocessed inbox items via `find inbox -maxdepth 1 -type f -name '*.md'`.

4. **Render the full review in the chat first**, formatted as:
   ```
   ## Weekly review — <WEEK>

   ### Wins
   - …

   ### Misses
   - …

   ### Lessons
   - …

   ### Inbox to triage (N)
   - …  (omit section if 0)

   ### Next week's one thing
   _(blank — Ian fills this in)_
   ```

5. **Then** write/append the same content to `weekly/<WEEK>.md`, using `templates/weekly.md` as the frame. Silently.

6. Ask: "Anything to add to wins/misses/lessons before we close? And what's your one thing for next week?"

7. After Ian answers, update the file silently with his additions.

8. Stage + commit + push silently (`git add weekly/ daily/` → `git commit -m "weekly: <WEEK>"` → `git push`).

No path-based confirmation. The chat output IS the review.
