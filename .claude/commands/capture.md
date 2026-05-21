---
description: Drop a thought into the inbox with zero ceremony
allowed-tools: Write, Bash(date:*)
---

Capture: $ARGUMENTS

1. Get current timestamp: `date +%Y-%m-%d-%H%M`.
2. Slugify the first ~6 words of the capture into kebab-case (lowercase, alphanumeric + hyphens, no stopwords like "the/a/of").
3. Write the capture to `inbox/<timestamp>-<slug>.md` with this body:
   ```
   ---
   captured: <timestamp ISO>
   source: capture
   ---

   $ARGUMENTS
   ```
4. Reply with one line: "Captured → inbox/<filename>". Nothing else.
