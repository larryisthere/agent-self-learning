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
5. **The Capture Skill**: A `/memory_capture` skill appends new lessons to the memory file, ensuring the AI gets smarter over time.

## Installation

Run the installation script in the root of any project where you want a shared memory context:

```bash
bash scripts/install.sh
```

### What does the script do?
1. Initializes `.agent/PROJECT_MEMORY.md` from the template if it doesn't exist.
2. Auto-detects your Claude Code project directory and establishes a symbolic link.
3. Installs a `post-commit` git hook in `.githooks/` and configures git to use it.
4. Appends a reference to `.agent/PROJECT_MEMORY.md` in `CLAUDE.md` and `.cursorrules`, without overwriting existing content.

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
- **Log Your Lessons**: Whenever you solve a difficult bug or establish a new pattern, run `/memory_capture` to log the insight.
- **Pruning**: When Lessons Learned approaches 20 items, instruct the AI to consolidate older entries to keep the file concise and token-efficient.
