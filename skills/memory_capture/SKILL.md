---
name: memory_capture
description: Use when finishing a session or solving a non-trivial problem to append a reusable insight to the project's long-term memory.
---

# Memory Capture

This skill has two valid outcomes:
- Capture a durable lesson into the long-term memory section.
- If the lesson feels plausible but not yet proven, park it in the temporary lessons section instead of polluting long-term memory.

## When to Use
- You resolved a non-obvious bug with a systemic root cause
- You established a new architectural pattern worth preserving
- You discovered a library incompatibility or platform-specific constraint
- The post-commit hook prompted you to capture memory

## When NOT to Use
- The fix was a simple typo or syntax error
- The note would only describe a one-off patch instead of a reusable rule
- The detail is limited to local variable names, widget parameters, or commit-style implementation trivia
- The note is mostly a factual record of what changed in this session
- Nothing non-trivial occurred in this session

## Quality Bar
- Capture only lessons that are non-obvious, likely to recur, and likely to change future implementation decisions.
- Capture the generalized rule, not the patch description.
- Prefer durable project concepts over temporary local names unless the name is a canonical project API.
- Write every memory entry in English only, even if the work or discussion happened in another language.
- Treat "I changed X to Y" as a smell. Rewrite it as "In situations like Z, prefer A over B because C", or skip capture.
- Ask explicitly: "Will this still help on a different file, feature, or future session?" If not, do not put it into long-term memory.

## Steps

1. Locate the project memory file in this order:
   - `.agent/PROJECT_MEMORY.md`
   - `MEMORY.md`
   - `.agents/MEMORY.md`
   Use the first one found. If none exists, create `.agent/PROJECT_MEMORY.md`.

2. In that file, find:
   - the long-term lessons or decisions section (e.g. "Lessons Learned", "Decision Log")
   - the temporary lessons section if it exists
   Then read the existing entries before writing anything new.

3. Before writing, pressure-test the lesson:
   - What was the root cause?
   - What future decision should change because of it?
   - Would this still be useful outside the exact patch I just made?
   - Am I recording a rule, or just narrating what I changed?
   If you cannot answer the first three clearly, skip long-term capture.

4. Choose the destination:
   - Long-term memory: use this only for lessons that are clearly reusable, durable, and decision-shaping.
   - Temporary lessons: use this when the lesson seems promising but you are not yet confident it is broadly reusable or stable.
   - Skip capture: use this when the note is mostly changelog material, product-specific wording, or one-off implementation detail.

5. Check whether an existing entry already captures the same lesson in the chosen destination:
   - If yes, update or consolidate the existing canonical entry instead of appending a near-duplicate, then save the file.
   - If no, continue with the append flow below.

6. When writing or updating an entry:
   - Use English only.
   - Keep it actionable and concise.
   - State the durable rule first, then the failure mode or reason if needed.
   - Avoid changelog phrasing such as "removed X from Y" when a broader rule can be stated.
   - Do not store purely objective session history as memory. Memory should change future decisions, not merely describe past actions.

7. Only when step 5 determined that no canonical entry exists, insert a new entry immediately before the relevant append target if present:
   - Long-term memory target: `<!-- MEMORY_CAPTURE_APPEND_TARGET -->`
   - Temporary lessons target: `<!-- TEMP_MEMORY_CAPTURE_APPEND_TARGET -->`
   Otherwise append at the end of the relevant section, using one of these formats:

   ```markdown
   ### [YYYY-MM-DD] [Topic Title]
   - [Durable, actionable rule in English. Add one short reason sentence only if it improves future decisions.]
   ```

   ```markdown
   ### [YYYY-MM-DD] [Topic Title]
   - [Tentative lesson in English. Explain briefly why it is still uncertain or what future repetition would validate it.]
   ```

8. If the memory file does not yet contain a temporary lessons section and step 4 selected the temporary destination, create this section near the main lessons area:

   ```markdown
   ## Temporary Lessons (Needs Repetition)
   > Use this section for plausible but not-yet-proven lessons. Promote an item into long-term memory only after it repeats or proves broadly reusable.

   <!-- TEMP_MEMORY_CAPTURE_APPEND_TARGET -->
   ```

9. Save the file.

## Done
The skill completes when one of these is true:
- A long-term lessons or decisions section contains a new or consolidated English entry that passes the quality bar.
- A temporary lessons section contains a new or consolidated tentative entry because the insight was not yet strong enough for long-term memory.
- The agent explicitly decides to skip capture because no reusable lesson emerged.
