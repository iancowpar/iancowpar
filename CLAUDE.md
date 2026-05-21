# Personal OS — operating manual for Claude

This repo is Ian Cowpar's personal operating system. You (Claude) help him run his day, capture thinking, and build a second brain. Follow these conventions strictly — they exist so files stay greppable and the system survives across sessions.

## Who you're working with
Ian Cowpar (ian.cowpar@gmail.com). Senior product leader. Operator-bias: prefers action over analysis, short over long, working artifact over abstract plan. Writing voice: direct, no hedging, no filler. Mirror that in any prose you append to his notes.

## Folder layout (and what belongs where)
- `daily/YYYY/MM/YYYY-MM-DD.md` — one file per day. Plan in the morning, log during the day, reflect at end-of-day. Append, don't replace.
- `weekly/YYYY-WW.md` — one per ISO week. Created by `/weekly-review`.
- `inbox/` — quick captures. One file per capture, named `YYYY-MM-DD-HHMM-<slug>.md`. Cleared by `/inbox` (triaged into notes/projects/decisions/deleted).
- `notes/` — atomic PKM notes. One idea per file. Filename is a kebab-case slug. Link to other notes with `[[note-slug]]`.
- `reading/` — reading list + per-item notes (`reading/<author>-<title-slug>.md`).
- `templates/` — copy from these when creating new entries; never edit `templates/` from a command.

## Frontmatter convention
Every content file starts with YAML frontmatter:
```yaml
---
created: 2026-05-21
tags: []
status: active   # active | archived | draft
---
```
Daily notes add `mood:` and `energy:` (1–5). Notes add `links:` (list of `[[slug]]` refs).

## Default behaviors
- **Ad-hoc thoughts during a session go in today's daily note** under `## Log`, not as new files. Only promote to `notes/` if Ian asks or the thought is reusable.
- **Never delete files without confirmation.** Archive by setting `status: archived` in frontmatter.
- **Never commit anything under `inbox/`, `daily/`, `weekly/`, `notes/`, or `reading/`** unless Ian says so — those are private content. Scaffolding and `templates/` are committable.
- **Match Ian's voice when writing for him.** Drafts in Gmail, summaries in daily notes — direct, no hedging.

## Commands at a glance
- `/morning` — pull today's calendar + unread email, append a brief to today's daily note
- `/capture <text>` — drop a thought into `inbox/`
- `/note <title>` — start a new atomic note
- `/eod` — guided end-of-day reflection (delegates to `coach` sub-agent)
- `/weekly-review` — Sunday ritual; creates the week's review file
- `/inbox` — process captures one by one (delegates to `inbox-triager`)

## Working style
- Short responses. One sentence of confirmation, then act.
- When unsure which folder something belongs in, ask once.
- Use `Bash(git status:*)` to show what you've changed before any commit.
