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

## Long-Term Qualification Test
Store a lesson in long-term memory only if it passes both gates below.

Gate A: Reusability
- The lesson must satisfy at least 2 of these 4 checks:
  - It applies beyond the exact file or patch from this session.
  - It is likely to recur within future work on this project.
  - Forgetting it would likely cause a repeated bug, wasted effort, or wrong implementation choice.
  - It changes how the agent should make future decisions, not just how this one task was completed.

Gate B: Experience Value
- The lesson must satisfy at least 1 of these 5 checks:
  - It took more than 20 minutes of debugging, investigation, or verification to reach confidence.
  - It required reading 5 or more files, or exploring multiple codebase areas.
  - It required 8 or more meaningful tool calls.
  - It required web research, external docs, or other outside references to verify.
  - It required 2 or more rounds of user clarification before the right rule became clear.

If Gate A passes but Gate B does not, prefer the temporary lessons section.
If Gate A fails, skip capture.

## Experience Value Filter
- Long-term memory is for expensive-to-earn lessons. Favor lessons that required substantial time, repeated investigation, many tool calls, broad codebase reading, web research, external documentation, or multiple rounds of user clarification before the correct rule became clear.
- Temporary lessons are for mid-confidence, medium-cost insights. Use this when the pattern seems useful but was not yet expensive enough, repeated enough, or validated enough to deserve long-term memory.
- Skip capture when the result came quickly from the model's existing context and ordinary reasoning, without meaningful search, investigation cost, or new external information. Fast, straightforward success is competence, not memory.
- Ask explicitly: "Was this lesson hard-won enough that forgetting it would likely waste significant future effort?" If no, do not store it as long-term memory.

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
   - Did I earn this through meaningful cost: long debugging, broad codebase exploration, web research, external references, many tool calls, or repeated user clarification?
   - Or did I solve it quickly from existing context and routine reasoning?
   - Which Gate A checks passed?
   - Which Gate B checks passed?
   If you cannot answer the first three clearly, skip long-term capture.

4. Choose the destination:
   - Long-term memory: use this only when both Gate A and Gate B pass.
   - Temporary lessons: use this when Gate A passes but Gate B does not, or when the lesson feels promising but still needs repetition or validation.
   - Skip capture: use this when Gate A fails, or when the note is mostly changelog material, product-specific wording, one-off implementation detail, or a fast conclusion reached from routine reasoning.

5. Check whether an existing entry already captures the same lesson in the chosen destination:
   - If yes, update or consolidate the existing canonical entry instead of appending a near-duplicate, then save the file.
   - If the existing entry states the same rule and you only gained another example, more confidence, or stronger evidence, update the existing entry instead of creating a new one.
   - Only create a new entry when the future decision rule is genuinely different.
   - If no, continue with the append flow below.

6. When writing or updating an entry:
   - Use English only.
   - Keep it actionable and concise.
   - Use at most 2 sentences and about 60 words.
   - State the durable rule first, then the failure mode, confidence source, or reason if needed.
   - Avoid changelog phrasing such as "removed X from Y" when a broader rule can be stated.
   - Do not store purely objective session history as memory. Memory should change future decisions, not merely describe past actions.
   - If useful, mention the source of confidence briefly: repeated occurrence, costly investigation, or external validation.
   - Prefer this shape:

   ```markdown
   - [Rule]. [Optional reason, failure mode, or confidence source.]
   ```

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

10. Promotion and cleanup rules for temporary lessons:
   - Promote a temporary lesson into long-term memory when any 1 of these becomes true:
     - The same rule is validated in 2 or more separate sessions.
     - The same rule is needed in 2 or more different files, modules, or features.
     - The rule is later confirmed by external documentation, official guidance, or repeated costly investigation.
   - Remove a temporary lesson when it is disproven, superseded, or sits unused long enough that it no longer looks relevant.

## Done
The skill completes when one of these is true:
- A long-term lessons or decisions section contains a new or consolidated English entry that passes the quality bar.
- A temporary lessons section contains a new or consolidated tentative entry because the insight was not yet strong enough for long-term memory.
- The agent explicitly decides to skip capture because no reusable lesson emerged.
