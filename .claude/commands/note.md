---
description: Create a new atomic note conversationally — Claude drafts in chat, then writes
allowed-tools: Read, Write, Glob, Grep, Bash
---

Create a new atomic note titled: $ARGUMENTS

1. Slugify the title into kebab-case → `<slug>`. Target path: `notes/<slug>.md`. If it already exists, stop and tell Ian.

2. Scan for related notes: `Grep` `notes/` for words from the title (excluding stopwords). Pick up to 3 candidates.

3. **Ask Ian in chat**: "What do you want this note to say? I'll write it. Sketch the idea — one paragraph, a few bullets, or a stream of thought." Don't draft anything yet.

4. When Ian responds, draft the note in chat first — full body, formatted, in his voice (direct, no hedging). Then ask: "Land this as `notes/<slug>.md`? Edits welcome before I save."

5. On confirmation (or edits), write the file from `templates/note.md`, substituting `{{DATE}}` (today) and `{{TITLE}}` (his title), with the drafted body. If you found related notes, populate `links: [[<slug-a>]], [[<slug-b>]]` in frontmatter.

6. Stage + commit + push silently (`git add notes/` → `git commit -m "note: <slug>"` → `git push`).

7. Confirm with one line: "Saved." Then list any related notes you linked, inline: "Linked: [[slug-a]], [[slug-b]]" (omit if none).

Never ask Ian to open the file. The chat draft IS the editing surface.
