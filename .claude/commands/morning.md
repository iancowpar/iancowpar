---
description: Pull today's calendar + unread email and deliver a morning brief inline
allowed-tools: Read, Edit, Bash, mcp__70ed4b5d-7a38-4537-ae24-04073ee0eefe__list_events, mcp__70ed4b5d-7a38-4537-ae24-04073ee0eefe__list_calendars, mcp__9b91dd0d-6852-44ef-88c2-eaaca00cd66d__search_threads, mcp__9b91dd0d-6852-44ef-88c2-eaaca00cd66d__get_thread
---

Build Ian's morning brief and deliver it in the chat. The daily note is persistence; the chat is where Ian reads it.

1. Resolve today's date with `date +%Y-%m-%d`. Daily note path: `daily/YYYY/MM/YYYY-MM-DD.md`.

2. Pull calendar via `list_events` for today 00:00 → tomorrow 09:00. Group by time; note conflicts.

3. Pull email via `search_threads` for `is:unread newer_than:1d in:inbox`. For the top 5 by recency, call `get_thread` for sender + subject + snippet. Flag any that look same-day-reply-worthy.

4. **Render the brief directly in the chat** as your reply. Format:
   ```
   ## Brief — {{HH:MM}}

   ### Calendar
   - 09:00–09:30 · <event title> · <attendees if useful>
   - …
   - Tomorrow AM: <events before 09:00>

   ### Email — needs attention
   - <sender> · <subject> · <one-line why it matters>

   ### Suggested focus
   <one or two sentences naming the highest-leverage thing for today>
   ```

5. **Then** append the same `## Brief` block to today's daily note under `## Plan`. Silently. No "appended to" confirmation.

6. Stage + commit + push silently:
   - `git add daily/` (no-op if gitignored, that's fine)
   - `git commit -m "morning: $(date +%Y-%m-%d)"` (skip if nothing to commit)
   - `git push` (only if a commit was made)
   - Stay quiet on success; only mention git if it fails.

Voice: direct, no filler, no hedging. Don't summarise what you did — the brief IS the output.
