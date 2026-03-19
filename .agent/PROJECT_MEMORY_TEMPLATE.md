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
> - First ask whether the note would help in a different file, feature, or future session. If not, do not treat it as long-term memory.
> - Treat long-term memory as scarce space for expensive-to-earn lessons: things that required substantial debugging time, broad codebase investigation, external references, web research, many tool calls, or repeated user clarification.
> - If the conclusion came quickly from routine reasoning over existing context, do not treat it as long-term memory.
> - A lesson should enter long-term memory only if it is both reusable and expensive enough to earn. A practical default is: at least 2 reusability signals plus at least 1 experience-value signal.
> - Reusability signals: applies beyond this exact patch, likely to recur, forgetting it would waste future effort, or it changes future decision-making.
> - Experience-value signals: more than 20 minutes of work, 5 or more files explored, 8 or more meaningful tool calls, external docs/web research, or 2 or more rounds of user clarification.
> - Do NOT log obvious typographical fixes, rename-only changes, or one-off implementation trivia.
> - Do NOT log objective session history such as "implemented X", "renamed Y", or "removed Z" unless rewritten as a reusable rule that changes future decisions.
> - Before appending, check whether the lesson should update an existing canonical entry instead.
> - If the same rule already exists, update it instead of appending a near-duplicate.
> - Keep each memory bullet to at most 2 sentences and about 60 words.
> - Max 20 items.

### [YYYY-MM-DD] Dependency Conflicts
- *Example: Do not update `package_info_plus` beyond version 4.x because it breaks iOS background execution in our current environment.*
### [YYYY-MM-DD] UI Rendering
- *Example: When rendering charts with `fl_chart`, always wrap the parent in a fixed-height `SizedBox` to prevent infinite layout exceptions.*

<!-- MEMORY_CAPTURE_APPEND_TARGET -->

## 5. Temporary Lessons (Needs Repetition)
> Use this section for plausible but not-yet-proven lessons. If an insight feels useful but still too local, uncertain, or product-specific for long-term memory, park it here first. Promote it into "Lessons Learned" only after it repeats or proves broadly reusable.
> **Constraints**:
> - Write every entry in English only.
> - Keep entries tentative and concise.
> - Record why the lesson is still uncertain, local, or awaiting repetition.
> - This section is the right place for quasi-experiences: insights that required some investigation or feel promising, but are not yet expensive enough, repeated enough, or validated enough for long-term memory.
> - Promote an item to long-term memory when it repeats across 2 sessions, 2 different code areas, or later gains external validation.
> - Remove or promote entries instead of letting this section grow without review.

### [YYYY-MM-DD] Placeholder Semantics
- *Example: It may be better to render a neutral placeholder instead of an empty state when hidden content must still reserve its business slot, but keep this temporary until the same tradeoff appears elsewhere.*

<!-- TEMP_MEMORY_CAPTURE_APPEND_TARGET -->
