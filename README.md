# Agent Self-Learning Framework

A lightweight, zero-dependency framework to give your AI coding assistants (like Claude Code, Cursor, Windsurf) a shared **Long-Term Memory** and **Autonomous Self-Evolution** capability.

## Why this framework?

Out of the box, AI agents suffer from amnesia. They repeatedly make the same architectural mistakes or get stuck on the same platform-specific bugs across different sessions. If you use multiple tools (e.g., Cursor for UI, Claude Code for heavy refactoring), they often maintain disjointed contexts.

This framework solves these issues by establishing a **Single Source of Truth** using a simple softlink and git hook architecture.

## How it Works

Instead of trying to parse and merge configuration files across different AI clients ("Push" architecture), this framework uses a "Pull" architecture:

1. **The Shared Brain**: `PROJECT_MEMORY.md` lives in your `.agent/` directory and is committed to Git.
2. **The Softlink**: The installation script creates a softlink from Claude Code's memory folder directly to `PROJECT_MEMORY.md`. The AI reads your rules natively without extra fetch overhead.
3. **The Bridge Files**: Thin pointers (`CLAUDE.md`, `.cursorrules`) tell each AI tool where to find the memory and available skills.
4. **The Git Hook**: A `post-commit` hook reminds you to document what you learned after each commit.
5. **The Capture Skill**: The agent executes `.agent/skills/memory_capture/SKILL.md` to add or consolidate durable English-only lessons in the memory file, or park tentative lessons in a temporary section until they are proven. This keeps memory useful without turning it into a changelog.

## Agent Contract (Critical)

This framework expects the agent to execute local skill files directly, not call built-in skill tooling:

- `run .agent/skills/<name>/SKILL.md` means "read the file and execute its steps manually."
- Before the final response, the agent should:
  1. Re-read `.agent/PROJECT_MEMORY.md`.
  2. Decide whether the session had non-trivial work.
  3. If yes, execute `.agent/skills/memory_capture/SKILL.md` and pressure-test whether the insight is truly reusable, merely tentative, or not worth storing.
  4. Use a two-gate test for long-term memory: the lesson should pass at least 2 reusability checks and at least 1 experience-value check.
  5. Reusability checks: applies beyond this patch, likely to recur, forgetting it would waste future effort, or it changes future decisions.
  6. Experience-value checks: more than 20 minutes of work, 5 or more files explored, 8 or more meaningful tool calls, external docs/web research, or 2 or more rounds of user clarification.
  7. Store only the generalized rule in English, never a patch-by-patch activity log.
  8. If reusability passes but experience-value does not, store it in the temporary lessons section instead of long-term memory.
  9. If the result came quickly from routine reasoning over existing context, skip memory capture.
  10. Explicitly report `Memory capture: done`, `Memory capture: temporary`, or `Memory capture: skipped (<reason>)`.

This is a behavioral contract, so making the checklist explicit in `CLAUDE.md` is required.

## Installation

Run the installation script in the root of any project where you want a shared memory context:

```bash
bash scripts/install.sh
```

The installer is idempotent:
- Existing memory file is preserved.
- The bundled `memory_capture` skill is refreshed in `.agent/skills/`.
- Managed bridge content in `CLAUDE.md` and `.cursorrules` is updated in place.
- Hook content is only replaced when template changes.

### What does the script do?
1. Initializes `.agent/PROJECT_MEMORY.md` from the template if it doesn't exist.
2. Installs the bundled `memory_capture` skill into `.agent/skills/`.
3. Auto-detects your Claude Code project directory and establishes a symbolic link.
4. Installs a `post-commit` git hook in `.githooks/` and configures git to use it.
5. Appends a reference to `.agent/PROJECT_MEMORY.md` in `CLAUDE.md` and `.cursorrules`, without overwriting existing content.

## Clone Into User Project With Independent Updates

Recommended: add this framework as a project-local submodule, so each user project pins and upgrades its own framework version independently.

```bash
# In user project root
git submodule add https://github.com/larryisthere/agent-self-learning.git .agent-self-learning
bash .agent-self-learning/scripts/install.sh --target .
```

Upgrade only this project when needed:

```bash
git -C .agent-self-learning fetch --tags
git -C .agent-self-learning checkout <tag-or-commit>
bash .agent-self-learning/scripts/install.sh --target .
git add .agent-self-learning .agent CLAUDE.md .cursorrules .githooks
```

This keeps:
- framework source updateable per project,
- project rules/memory in the project repo,
- and installer reruns safe.

## Installing Just the Skill

To add only the `memory_capture` skill to an existing project (without installing the full framework):

```bash
# Via a skill installer
--repo larryisthere/agent-self-learning --path skills/memory_capture

# Or manually
cp -r skills/memory_capture /your/project/.agent/skills/
```

The skill auto-detects the project's memory file (`.agent/PROJECT_MEMORY.md`, `MEMORY.md`, or `.agents/MEMORY.md`) and adapts accordingly. It is designed to keep memory concise, English-only, and focused on reusable, hard-won lessons instead of patch-by-patch notes, with an explicit temporary holding area for lessons that pass reusability but still lack enough cost or validation for long-term memory.

## Usage & Best Practices

- **Define Your Rules**: Open `.agent/PROJECT_MEMORY.md` and define your project's architecture, state management guidelines, and testing rules.
- **Log Your Lessons**: Whenever you solve a difficult bug or establish a new pattern, execute `.agent/skills/memory_capture/SKILL.md` to capture only durable, expensive-to-earn rules in English, consolidate duplicates when needed, and use the temporary lessons section when a pattern looks promising but is not yet proven.
- **Promote Carefully**: Move a temporary lesson into long-term memory only after it repeats across sessions, shows up in multiple code areas, or gains external validation.
- **Pruning**: When Lessons Learned approaches 20 items, instruct the AI to consolidate older entries to keep the file concise and token-efficient.
