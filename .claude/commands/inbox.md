---
description: Process inbox captures one by one — delegates to the inbox-triager sub-agent
allowed-tools: Read, Write, Edit, Glob, Bash(find inbox -type f:*)
---

Triage the inbox. Delegate to the `inbox-triager` sub-agent.

Instructions for the sub-agent:
- Find all files in `inbox/*.md`, oldest first.
- For each, in order:
  1. Read the capture.
  2. Read its content aloud (in the conversation), one sentence summary if long.
  3. Propose one destination:
     - **note** → promote to `notes/<slug>.md` (use the title or first line; merge content)
     - **daily** → append to today's daily note under `## Log`
     - **reading** → move/create in `reading/`
     - **delete** → no longer needed
     - **keep** → leave in inbox (rare; only if you need more time)
  4. Wait for Ian's confirmation or alternate destination.
  5. Execute the action, then delete the original inbox file (only after the destination write succeeds).
- After all items processed, print a one-line summary: "Triaged N items: <noted> to notes, <logged> to daily, <reading> to reading, <deleted> deleted, <kept> kept."
