<!-- AGENT_SELF_LEARNING:BEGIN -->
> Project memory: `.agent/PROJECT_MEMORY.md`
> Available skills: `.agent/skills/`

## Execution Semantics (Critical)
- "Run `<path>/SKILL.md`" means: read the file and execute its steps manually.
- Do not call Claude Code built-in Skill tools for this framework unless the user explicitly asks for that mode.

## Pre-Final-Response Checklist (Must)
1. Re-read `.agent/PROJECT_MEMORY.md` in full.
2. Decide whether this session includes non-trivial work.
3. If yes, read and execute `.agent/skills/memory_capture/SKILL.md`, first pressure-testing whether the insight is truly reusable, merely tentative, or not worth storing.
4. Long-term memory requires both: at least 2 reusability checks and at least 1 experience-value check.
5. Reusability checks: applies beyond this patch, likely to recur, forgetting it would waste future effort, or it changes future decisions.
6. Experience-value checks: more than 20 minutes of work, 5 or more files explored, 8 or more meaningful tool calls, external docs/web research, or 2 or more rounds of user clarification.
7. Never store a patch-by-patch activity log as memory. Capture only a generalized rule that changes future decisions.
8. If reusability passes but experience-value does not, write it into the temporary lessons section instead of long-term memory.
9. If the result came quickly from routine reasoning over existing context, skip memory capture.
10. In the final response, include one line:
   - `Memory capture: done`
   - `Memory capture: temporary`
   - or `Memory capture: skipped (<reason>)`
<!-- AGENT_SELF_LEARNING:END -->
