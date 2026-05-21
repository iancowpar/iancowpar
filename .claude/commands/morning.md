---
description: Pull today's calendar + unread email and append a brief to today's daily note
allowed-tools: Read, Edit, Bash(date:*), mcp__70ed4b5d-7a38-4537-ae24-04073ee0eefe__list_events, mcp__70ed4b5d-7a38-4537-ae24-04073ee0eefe__list_calendars, mcp__9b91dd0d-6852-44ef-88c2-eaaca00cd66d__search_threads, mcp__9b91dd0d-6852-44ef-88c2-eaaca00cd66d__get_thread
---

Build Ian's morning brief and append it to today's daily note. Steps:

1. Determine today's date with `date +%Y-%m-%d` and the path `daily/YYYY/MM/YYYY-MM-DD.md`. Read it (the SessionStart hook should have created it from `templates/daily.md`).

2. Pull calendar:
   - Call `list_events` for today 00:00 → tomorrow 09:00 (covers today + early-tomorrow conflicts to plan for).
   - Group by time. Note any back-to-back blocks and any conflicts.

3. Pull email:
   - Call `search_threads` with query `is:unread newer_than:1d in:inbox`.
   - For the top 5 most recent, call `get_thread` to get subject + snippet + sender.
   - Flag anything that looks like it needs a same-day reply.

4. Append a `## Brief` section directly under the `## Plan` heading in today's daily note. Format:
   ```
   ## Brief
   _Generated {{HH:MM}}_

   ### Calendar
   - 09:00–09:30 · <event title> · <attendees if useful>
   - ...
   - Tomorrow AM: <events before 09:00>

   ### Email — needs attention
   - <sender> · <subject> · <one-line why it matters>

   ### Suggested focus
   <one or two sentences naming the highest-leverage thing for today, given the calendar gaps>
   ```

5. Print a one-line confirmation: "Brief appended to daily/YYYY/MM/YYYY-MM-DD.md".

Voice: direct, no filler. Don't summarize what you did — just do it and confirm.
