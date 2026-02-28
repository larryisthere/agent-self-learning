# Agent Self-Learning Framework

A lightweight, zero-dependency framework to give your AI coding assistants (like Claude Code, Cursor, Windsurf) a shared **Long-Term Memory** and **Autonomous Self-Evolution** capability.

## Why this framework?

Out of the box, AI agents suffer from amnesia. They repeatedly make the same architectural mistakes or get stuck on the same platform-specific bugs across different sessions. If you use multiple tools (e.g., Cursor for UI, Claude Code for heavy refactoring), they often maintain disjointed contexts.

This framework solves these issues by establishing a **Single Source of Truth** using a simple Softlink and CLI Hook architecture.

## How it Works

Instead of trying to parse and merge configuration files across different AI clients ("Push" architecture), this framework uses a "Pull" architecture:

1. **The Shared Brain**: `PROJECT_MEMORY.md` lives in your `.agent/` directory and is committed to Git.
2. **The Softlink**: The installation script creates a softlink from Claude Code's obfuscated memory folder directly to `PROJECT_MEMORY.md`. The AI reads your rules natively without consuming extra context window tokens to "fetch" instructions.
3. **The Hook**: A CLI hook detects uncommitted Git changes on exit and gently reminds you/the AI to write down any newly learned lessons.
4. **The Capture Skill**: A dedicated `/memory_capture` skill cleanly appends these lessons to the bottom of the memory file, ensuring the AI gets smarter over time.

## Installation

Run the installation script in the root of any project where you want a shared memory context:

```bash
bash scripts/install.sh
```

### What does the script do?
1. It initializes `.agent/PROJECT_MEMORY.md` if it doesn't exist.
2. It asks for your Claude Code project hash (found in `~/.claude/projects/`) and establishes a symbolic link.
3. It installs a weak CLI reminder hook in `.claude/hooks/post-command`.

## Usage & Best Practices

*   **Define Your Rules**: Open `.agent/PROJECT_MEMORY.md` and define your project's state management guidelines, testing rules, and backend architecture. 
*   **Log Your Lessons**: Whenever you solve a difficult, obscure bug, type `/memory_capture` (or instruct your IDE: "Use the memory capture skill to log that we must not use library X on iOS").
*   **Pruning**: The framework restricts the "Lessons Learned" section to 20 items. As you approach this limit, instruct the AI to consolidate them to keep the file concise and token-efficient.
