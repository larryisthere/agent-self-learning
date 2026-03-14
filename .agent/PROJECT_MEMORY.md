# 🧠 Project Core Memory (Single Source of Truth)

> **[CRITICAL INSTRUCTION TO AI]**
> You MUST read this file in its entirety before taking any action. This file contains the foundational architectural decisions, core workflows, and hard-earned lessons for this specific project. Disregarding this file will lead to incorrect implementations.

## 1. Project Context
- **Name**: [Insert Project Name]
- **Description**: [Briefly describe what this project does and its core domain]
- **Primary Tech Stack**: [e.g., Flutter, Dart, Riverpod / React, TypeScript, Next.js / Ruby on Rails]

## 2. Core Architecture & Guidelines
- **State Management**: [Describe the chosen pattern, e.g., "Use Riverpod for global state. Do not use SetState for complex logic."]
- **UI & Styling**: [Describe component library, design system, or CSS strategy]
- **Backend / API**: [Describe database choices, API protocols, ORM constraints]
- **Testing**: [Describe expected test coverage, unit vs widget/integration logic]

## 3. Custom Agent Behaviors
[Insert any specific rules for this project here. e.g.:]
- Always write explicit types for return values.
- Never mock the Database class directly in tests; use the abstract Repository.

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

<!-- MEMORY_CAPTURE_APPEND_TARGET -->
