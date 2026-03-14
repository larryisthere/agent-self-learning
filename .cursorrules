<!-- AGENT_SELF_LEARNING:BEGIN -->
> Project memory: `.agent/PROJECT_MEMORY.md`
> Available skills: `.agent/skills/`

## Execution Semantics (Critical)
- "Run `<path>/SKILL.md`" means: read the file and execute its steps manually.
- Do not call Claude Code built-in Skill tools for this framework unless the user explicitly asks for that mode.

## Pre-Final-Response Checklist (Must)
1. Re-read `.agent/PROJECT_MEMORY.md` in full.
2. Decide whether this session includes non-trivial work.
3. If yes, read and execute `.agent/skills/memory_capture/SKILL.md`, writing or consolidating an English-only memory entry that captures the generalized rule rather than the patch description.
4. In the final response, include one line:
   - `Memory capture: done`
   - or `Memory capture: skipped (<reason>)`
<!-- AGENT_SELF_LEARNING:END -->
