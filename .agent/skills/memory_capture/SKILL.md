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
- The insight is already present in the Lessons Learned section
- Nothing non-trivial occurred in this session

## Steps

1. Identify one insight from this session that matches the criteria above.
2. Open `.agent/PROJECT_MEMORY.md` and locate the `<!-- MEMORY_CAPTURE_APPEND_TARGET -->` anchor inside `## 4. Lessons Learned`.
3. Insert a new entry immediately **before** that anchor using this exact format:

```markdown
### [YYYY-MM-DD] [Topic Title]
- [Actionable insight. One or two sentences maximum.]
```

4. Save the file.

## Done
The skill completes when a new dated entry exists in the Lessons Learned section.
