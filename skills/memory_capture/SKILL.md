---
name: memory_capture
description: Use when finishing a session or solving a non-trivial problem to append a reusable insight to the project's long-term memory.
---

# Memory Capture

## When to Use
- You resolved a non-obvious bug with a systemic root cause
- You established a new architectural pattern worth preserving
- You discovered a library incompatibility or platform-specific constraint
- The post-commit hook prompted you to capture memory

## When NOT to Use
- The fix was a simple typo or syntax error
- The note would only describe a one-off patch instead of a reusable rule
- The detail is limited to local variable names, widget parameters, or commit-style implementation trivia
- Nothing non-trivial occurred in this session

## Quality Bar
- Capture only lessons that are non-obvious, likely to recur, and likely to change future implementation decisions.
- Capture the generalized rule, not the patch description.
- Prefer durable project concepts over temporary local names unless the name is a canonical project API.
- Write every memory entry in English only, even if the work or discussion happened in another language.

## Steps

1. Locate the project memory file in this order:
   - `.agent/PROJECT_MEMORY.md`
   - `MEMORY.md`
   - `.agents/MEMORY.md`
   Use the first one found. If none exists, create `.agent/PROJECT_MEMORY.md`.

2. In that file, find the lessons or decisions section (e.g. "Lessons Learned", "Decision Log"), then read the existing entries before writing anything new.

3. Before writing, pressure-test the lesson:
   - What was the root cause?
   - What future decision should change because of it?
   If you cannot answer both clearly, skip capture.

4. Check whether an existing entry already captures the same lesson:
   - If yes, update or consolidate the existing canonical entry instead of appending a near-duplicate, then save the file.
   - If no, continue with the append flow below.

5. When writing or updating an entry:
   - Use English only.
   - Keep it actionable and concise.
   - State the durable rule first, then the failure mode or reason if needed.
   - Avoid changelog phrasing such as "removed X from Y" when a broader rule can be stated.

6. Only when step 4 determined that no canonical entry exists, insert a new entry immediately before `<!-- MEMORY_CAPTURE_APPEND_TARGET -->` if present,
   otherwise append at the end of that section, using this format:

   ```markdown
   ### [YYYY-MM-DD] [Topic Title]
   - [Durable, actionable rule in English. Add one short reason sentence only if it improves future decisions.]
   ```

7. Save the file.

## Done
The skill completes when the lessons or decisions section contains a new or consolidated English entry that passes the quality bar.
