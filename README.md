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
5. **The Capture Skill**: The agent executes `.agent/skills/memory_capture/SKILL.md` to append new lessons to the memory file, ensuring the AI gets smarter over time.

## Agent Contract (Critical)

This framework expects the agent to execute local skill files directly, not call built-in skill tooling:

- `run .agent/skills/<name>/SKILL.md` means "read the file and execute its steps manually."
- Before the final response, the agent should:
  1. Re-read `.agent/PROJECT_MEMORY.md`.
  2. Decide whether the session had non-trivial work.
  3. If yes, execute `.agent/skills/memory_capture/SKILL.md`.
  4. Explicitly report `Memory capture: done` or `Memory capture: skipped (<reason>)`.

This is a behavioral contract, so making the checklist explicit in `CLAUDE.md` is required.

## Installation

Run the installation script in the root of any project where you want a shared memory context:

```bash
bash scripts/install.sh
```

The installer is idempotent:
- Existing memory file is preserved.
- Managed bridge content in `CLAUDE.md` and `.cursorrules` is updated in place.
- Hook content is only replaced when template changes.

### What does the script do?
1. Initializes `.agent/PROJECT_MEMORY.md` from the template if it doesn't exist.
2. Auto-detects your Claude Code project directory and establishes a symbolic link.
3. Installs a `post-commit` git hook in `.githooks/` and configures git to use it.
4. Appends a reference to `.agent/PROJECT_MEMORY.md` in `CLAUDE.md` and `.cursorrules`, without overwriting existing content.

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

The skill auto-detects the project's memory file (`.agent/PROJECT_MEMORY.md`, `MEMORY.md`, or `.agents/MEMORY.md`) and adapts accordingly — no manual configuration needed.

## Usage & Best Practices

- **Define Your Rules**: Open `.agent/PROJECT_MEMORY.md` and define your project's architecture, state management guidelines, and testing rules.
- **Log Your Lessons**: Whenever you solve a difficult bug or establish a new pattern, execute `.agent/skills/memory_capture/SKILL.md` to log the insight.
- **Pruning**: When Lessons Learned approaches 20 items, instruct the AI to consolidate older entries to keep the file concise and token-efficient.
