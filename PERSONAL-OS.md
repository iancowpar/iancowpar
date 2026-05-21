# Personal OS

A Claude Code-native operating system for daily life and thinking. Markdown for storage, slash commands for rituals, MCPs for the world outside the repo.

## What's here
- **Daily operating system** — morning brief, day log, end-of-day reflection, weekly review
- **Second brain** — atomic notes, reading list, decision logs (add as you grow)
- **Integrations** — Google Calendar + Gmail wired in via MCP

## Quick start
1. Open this repo in Claude Code (web or CLI).
2. The SessionStart hook prints today's brief and creates today's daily note.
3. Type `/morning` to pull calendar + unread email and append the brief.
4. Capture thoughts with `/capture <text>`. Promote them to notes with `/inbox`.
5. End the day with `/eod`. Sunday: `/weekly-review`.

## Layout
```
daily/YYYY/MM/YYYY-MM-DD.md   one file per day
weekly/YYYY-WW.md             one per ISO week
inbox/                         quick captures awaiting triage
notes/                         atomic PKM notes, linked with [[slug]]
reading/                       reading list + per-item notes
templates/                     templates for new entries
.claude/commands/              slash commands
.claude/agents/                sub-agents (coach, inbox-triager)
.claude/hooks/                 SessionStart context loader
CLAUDE.md                      operating instructions for Claude
```

## Privacy
This scaffold is structure-only. Personal content under `daily/`, `weekly/`, `inbox/`, `notes/`, `reading/` is gitignored — see `.gitignore`. If you want to version your data, remove those entries and use a private repo.

## Migrating to a private repo
This scaffold was built in the public `iancowpar/iancowpar` repo as a reference. To use it for real:
```bash
gh repo create iancowpar/personal-os --private --clone
cp -r <scaffold>/{CLAUDE.md,PERSONAL-OS.md,.claude,templates,.gitignore} personal-os/
cd personal-os && git add . && git commit -m "Initial scaffold" && git push
```
