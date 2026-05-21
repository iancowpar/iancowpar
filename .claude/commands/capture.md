---
description: Drop a thought into the inbox with zero ceremony
allowed-tools: Write, Bash
---

Capture: $ARGUMENTS

1. Get timestamp: `date +%Y-%m-%d-%H%M`.
2. Slugify the first ~6 words of the capture into kebab-case (lowercase, alphanumeric + hyphens, drop stopwords like "the/a/of").
3. Write to `inbox/<timestamp>-<slug>.md`:
   ```
   ---
   captured: <ISO timestamp>
   source: capture
   ---

   $ARGUMENTS
   ```
4. Stage + commit + push silently (`git add inbox/` → `git commit -m "capture: <slug>"` → `git push`).
5. Reply with one line: "Captured." Nothing else. No path. No file mention.
