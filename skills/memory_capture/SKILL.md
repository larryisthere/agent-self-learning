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
- The insight is already present in the lessons or decisions section
- Nothing non-trivial occurred in this session

## Steps

1. Locate the project memory file in this order:
   - `.agent/PROJECT_MEMORY.md`
   - `MEMORY.md`
   - `.agents/MEMORY.md`
   Use the first one found. If none exists, create `.agent/PROJECT_MEMORY.md`.

2. In that file, find the lessons or decisions section (e.g. "Lessons Learned", "Decision Log").

3. Insert a new entry immediately before `<!-- MEMORY_CAPTURE_APPEND_TARGET -->` if present,
   otherwise append at the end of that section, using this exact format:

   ```markdown
   ### [YYYY-MM-DD] [Topic Title]
   - [Actionable insight. One or two sentences maximum.]
   ```

4. Save the file.

## Done
The skill completes when a new dated entry exists in the lessons or decisions section.
