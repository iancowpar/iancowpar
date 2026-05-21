---
description: Create a new atomic note in the second brain
allowed-tools: Read, Write, Glob, Grep, Bash(date:*)
---

Create a new atomic note titled: $ARGUMENTS

1. Slugify the title into kebab-case → `<slug>`. Target path: `notes/<slug>.md`.
2. If `notes/<slug>.md` already exists, stop and tell Ian. Don't overwrite.
3. Copy `templates/note.md`, substituting `{{DATE}}` (today) and `{{TITLE}}` ($ARGUMENTS).
4. Scan existing notes for likely related ones:
   - `Grep` notes/ for any words from the title (excluding stopwords)
   - List up to 3 candidates by filename
5. After creating the file, print:
   - "Created notes/<slug>.md"
   - "Possibly related: [[note-a]], [[note-b]], [[note-c]]" (omit line if none)
   - "Add to `links:` frontmatter if relevant."

Don't write a body yourself. Ian writes the note.
