# 🧠 Project Core Memory (Single Source of Truth)

> **[CRITICAL INSTRUCTION TO AI]**
> You MUST read this file in its entirety before taking any action. This file contains the foundational architectural decisions, core workflows, and hard-earned lessons for this specific project. Disregarding this file will lead to incorrect implementations.

## 1. Project Context
- **Name**: Agent Self-Learning Framework
- **Description**: A project-local framework that gives coding agents a shared long-term memory, a stable execution contract, and a repeatable way to capture reusable lessons after non-trivial work.
- **Primary Tech Stack**: Markdown, Bash, Git hooks, project-local bridge files, project-local agent skills

## 2. Core Architecture & Guidelines
- **Memory Model**: `.agent/PROJECT_MEMORY.md` is the single source of truth. Templates seed new projects, but live decisions and reusable lessons belong here.
- **Instruction Surfaces**: `CLAUDE.md`, `GEMINI.md`, `ANTIGRAVITY.md`, and `.cursorrules` mirror the minimum operating contract. When framework policy changes, update the installer template, checked-in bridge files, and live `.agent` copies in the same pass.
- **Skill Design**: Prefer skills that define triggers, success criteria, constraints, verification needs, and stop boundaries. For cross-cutting skills, write a decision framework plus verified operational facts rather than a brittle script.
- **Verification**: Before claiming work is complete, run the most relevant checks available and report evidence, or state clearly why verification could not be completed.
- **Planning**: For non-trivial work, define scope, definition of done, out-of-scope items, key risks or trade-offs, and the mitigation or rollback path for the highest-risk item before implementing.
- **Security**: Never store secrets, tokens, credentials, or environment-specific private values in project memory.

## 3. Custom Agent Behaviors
- Default to direct, plain phrasing. Avoid performative tone and rhetorical contrast that implies the user's priorities for them.
- Re-read `.agent/PROJECT_MEMORY.md` before final response, then report `Memory capture: done` or `Memory capture: skipped (<reason>)`.
- Use `.agent/skills/memory_capture/SKILL.md` only for non-trivial, reusable lessons. Keep entries English-only, generalized, and consolidated.
- Stay within the stated scope for non-trivial work unless the user explicitly expands it.

---

## 4. Lessons Learned (Evolution Area)
> **[INSTRUCTION FOR AI WRAP-UP]**
> This section is actively updated by the AI via the `memory_capture` skill. When debugging a tricky issue, discovering a platform-specific bug, or establishing a new pattern, the insight MUST be appended here concisely.
> **Constraints**:
> - Write every entry in English only.
> - Capture durable rules, not patch descriptions.
> - Keep items actionable and reusable.
> - Do NOT log obvious typographical fixes, rename-only changes, or one-off implementation trivia.
> - Before appending, check whether the lesson should update an existing canonical entry instead.
> - Max 20 items.

### [YYYY-MM-DD] Dependency Conflicts
- *Example: Do not update `package_info_plus` beyond version 4.x because it breaks iOS background execution in our current environment.*
### [YYYY-MM-DD] UI Rendering
- *Example: When rendering charts with `fl_chart`, always wrap the parent in a fixed-height `SizedBox` to prevent infinite layout exceptions.*

### [2026-03-04] Skill Execution Semantics
- In this framework, "run <path>/SKILL.md" means read the file and execute steps manually; enforce a pre-final checklist and report `Memory capture: done/skipped` to make compliance auditable.

### [2026-03-07] Multi-Agent Bridge Files
- Generate the same self-learning bridge content into `CLAUDE.md`, `GEMINI.md`, and `ANTIGRAVITY.md` during install so agent-specific entrypoint discovery does not depend on Claude-only filenames.

### [2026-03-14] Memory Capture Quality Bar
- Capture generalized, reusable rules in English rather than patch-by-patch notes; consolidate an existing canonical lesson when the new insight overlaps instead of appending near-duplicates.

### [2026-03-14] Framework Policy Changes Must Update Every Live Copy
- When changing framework behavior or agent instructions, update every shipped execution surface in the same pass: source templates, checked-in `.agent` runtime copies, and all bridge files such as `CLAUDE.md`, `GEMINI.md`, `ANTIGRAVITY.md`, and `.cursorrules`. Do not stop after updating the canonical source if the repository also contains live mirrored copies.

### [2026-03-23] Skill Design For Cross-Cutting Work
- When a skill covers broad, recurring workflow decisions, write it as a decision framework plus verified operational facts: define success criteria, key heuristics, stop boundaries, and a small set of concrete primitives. This preserves agent autonomy better than step-by-step scripts and keeps the skill reusable.

### [2026-03-23] Default Conversation Tone
- In this project, default to direct, plain phrasing and avoid rhetorical contrast patterns that imply the user's priorities for them. Use emphasis only when the user asks for a stronger style, because tone that sounds performative reduces trust.

### [2026-03-23] Benchmark-Driven Framework Upgrades
- When improving the framework from external skill research, separate research from implementation and persist the benchmark artifacts in-repo first: sample URLs, per-sample scores, criteria tallies, and baseline notes. This keeps the scoring rubric stable across iterations and prevents the project from "improving" against a moving verbal target.

### [2026-03-23] Protect Core Attention Budget
- Do not bundle optional skills or scenarios into the framework's default path unless they directly serve the project's core purpose. Extra scenes dilute agent attention and weaken the main memory-plus-contract workflow.

<!-- MEMORY_CAPTURE_APPEND_TARGET -->
