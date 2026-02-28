---
name: Memory Capture
description: A specialized skill to capture technical insights, architecture patterns, and tricky bugs from the current coding session and append them to the project's Core Memory.
---

# Memory Capture Skill

This skill is designed as an autonomous, single-responsibility tool to update `.agent/PROJECT_MEMORY.md`. 
Unlike general wrap-ups, this skill focuses purely on **Self-Evolution** and **Preserving Intelligence** across AI sessions.

## Procedures

### 1. Reflect on the Session
Take a moment to review the work completed in this context. Did you:
*   Encounter an unexpected library incompatibility? (e.g., "Version X breaks when used with Y")
*   Solve a deeply hidden platform-specific bug? (e.g., "iOS requires permission Z in Info.plist for this to work")
*   Establish a new architectural pattern for a feature? (e.g., "All future services should inherit from AbstractBaseService")
*   Discover a significant edge case not initially documented?

### 2. Formulate the Insight
If the answer is YES to any of the above, formulate a concise, actionable entry.
*   **Format Requirement**: The entry MUST be a short bullet point, starting with an actionable rule or a clear factual statement. Max 2 sentences.
*   **Relevance Check**: Do NOT log obvious typographical fixes or simple syntax errors. Only log systemic facts that would save future iterations significant time.

### 3. Write to Core Memory
Use terminal tools to append the insight directly to the `Lessons Learned` section of `.agent/PROJECT_MEMORY.md`.

Use the following exact format when appending:
```markdown
### [YYYY-MM-DD] [Topic Title]
- [Your concise, actionable insight]
```

**Constraint**: You MUST search for the `<!-- MEMORY_CAPTURE_APPEND_TARGET -->` anchor in `PROJECT_MEMORY.md` and insert the new content immediately BEFORE this anchor. This ensures the file format remains intact.

### 4. Pruning Check
Check the total number of items under the `Lessons Learned` section. If it exceeds 20 distinct items, proactively consolidate older, similar items into a single bullet point, or group them logically to reduce token bloat.

## When to Use
Use this skill when you have solved a difficult problem, made an architectural choice, or upon seeing a CLI weak reminder prompting you to capture memory before closing a context.
