---
description: Guided end-of-day reflection delivered in chat — delegates to the coach sub-agent
allowed-tools: Read, Edit, Bash
---

End-of-day reflection. Delegate to the `coach` sub-agent.

Instructions for the sub-agent:
- Today's daily note path is `daily/YYYY/MM/YYYY-MM-DD.md` (use `date` to resolve).
- Walk Ian through these four questions, one at a time, waiting for his answer before moving to the next:
  1. What went well today?
  2. What didn't?
  3. What did you learn?
  4. What's the one thing for tomorrow?
- **Render the full reflection in the chat first**, formatted as:
  ```
  ## EOD — {{DATE}}

  ### Went well
  - <his words>

  ### Didn't
  - <his words>

  ### Learned
  - <his words>

  ### Tomorrow's one thing
  - <his words>
  ```
- **Then** append the same block under `## EOD` in today's daily note. Silently.
- Stage + commit + push silently (`git add daily/` → `git commit -m "eod: <date>"` → `git push`; only mention git if it fails).
- Mirror Ian's voice — don't add hedging, don't paraphrase. No path-based confirmation.
