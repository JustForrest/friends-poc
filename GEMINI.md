# Gemini CLI Instructions for Unagi Project

## Project Context

- **Unagi**: Internal RAG system on "Friends" scripts. Agent-first dev: Goose for planning/reads/recipes; Gemini CLI for writes/executions/extensions. Prioritize Goose recipes for repeatable tasks.
- **Tech Stack**: The project heavily employs Python for backend logic, data processing, and scripts, with Ruff as the formatter for all Python code. Frontend is built with Next.js, adhering to recommended project structure for optimal organization and performance.

## Goose High-Level Overview

- **Architecture**: LLM-driven agent (e.g., Grok-4 lead). Tool-calling for dynamic invocation. MCP extensions for tools/data. Recipes: YAML workflows automating sequences (prompts, tools, sub-tasks). Sub-recipes: Nested/parallel execution. Goosehints: Context files for guidance.
- **Recipes**: YAML with steps (prompt, tool_call, sub_recipe). Session recipes for interactive. Run via CLI (goose recipe run). Use for code gen, debugging, pipelines. Parallel sub-recipes for efficiency (e.g., concurrent embeddings).
- **Best Practices**: Delegate repeatable/parallel tasks to recipes. Integrate with Gemini CLI for hybrid flows.

## Recipe Opportunity Detection

- **Scan For**: Repeatable coding tasks (e.g., data ingestion, code patterns, testing, integrations) suitable for agent delegation/parallelism.
- **Notify**: If detected, respond: "Opportunity for Goose recipe: [Task description]. Suggested YAML: [Concise sketch]. Proceed?"
- **Examples**: "Embed chunks" → Recipe with parallel sub-recipes. "Generate API" → Tool-calling recipe.

## GitHub Issues and Projects Overview

- **Issues**: Track work (tasks/bugs/features). Fields: Title, Body, Assignees, Labels, Milestones, State (open/closed). Link to PRs/Projects.
- **Projects**: Organize issues/PRs in views (board/table/roadmap). Custom fields (e.g., Status, Priority). Automate via GitHub Actions (YAML workflows on events; auth with PAT/App).
- **Best Practices**: Use labels/milestones for organization. Automate updates (e.g., issue close → status change). Link to Unagi repo for tracking.

## Gemini CLI Specifics

- **Config**: Hierarchical context files for instructions. Ignore via .gemini-ignore patterns.
- **Behavior**: Concise responses. For repo/code interactions: Suggest Goose recipes first for agentic tasks; execute writes via CLI/extensions. Alert on Goose opportunities.
- **Code Formatting and Best Practices**:
  - **Python Code (Ruff Formatter)**: All Python code must adhere to Ruff's formatting rules for consistency and readability. Ruff is the designated formatter, enforcing PEP 8 standards with some sensible defaults. Key guidelines:
    - **Configuration**: Use `pyproject.toml` for settings (e.g., line-length=88, target-version=py39). Install Ruff via `pip install ruff` and integrate into CI/CD for automatic checks.
    - **Formatting Rules**:
      - Line length: Default 88 characters; avoid exceeding unless necessary (e.g., for URLs or long strings).
      - Quotes: Use double quotes for strings by default; single quotes for nested or docstrings if needed.
      - Indentation: 4 spaces; no tabs.
      - Imports: Sorted alphabetically; separate stdlib, third-party, and local imports. Use `isort` integration if enabled.
      - Whitespace: No trailing whitespace; single blank line between functions/classes; two between top-level elements.
      - Black Compatibility: Ruff aims for Black-like formatting; enable `black` compatibility mode if stricter adherence is needed.
    - **Usage**: Run `ruff format` on all Python files before commits. For linting, use `ruff check --fix`. Prioritize Ruff over other formatters (e.g., Black) for speed and integration.
    - **Best Practices**: Write idiomatic Python; use type hints (PEP 484); avoid unnecessary complexity. For Unagi-specific tasks like data ingestion or RAG pipelines, ensure scripts are modular and testable.
  - **Next.js Code (Project Structure and Best Practices)**: Follow Next.js recommended project structure to maintain scalability, especially for the frontend components of Unagi. This ensures clear separation of concerns and optimal performance.
    - **Recommended Directory Structure**:
      - `app/`: Core of the App Router; contains routes, pages, and layouts (e.g., `app/page.tsx` for root page, `app/api/` for API routes).
      - `components/`: Reusable UI components (e.g., buttons, modals); keep them pure and stateless where possible.
      - `lib/`: Utility functions, data fetching logic, database connections, or shared hooks (e.g., `lib/db.ts` for database utilities).
      - `public/`: Static assets like images, fonts, or favicons; served directly (e.g., `public/images/logo.png`).
      - `scripts/`: One-off or build-time scripts (e.g., data seeding or migrations).
      - Root files: `next.config.js` for configuration, `package.json` for dependencies, `.env` for environment variables, `tsconfig.json` for TypeScript settings.
      - Optional: `styles/` for global CSS, `types/` for custom TypeScript types, `tests/` for unit/integration tests.
    - **Best Practices**:
      - Use the App Router for new features; prefer Server Components for data fetching to reduce client bundle size.
      - Colocate files: Keep related files (e.g., components, hooks) near their usage in `app/` subdirectories.
      - Performance: Leverage Next.js features like dynamic imports, image optimization, and caching. Avoid large client-side bundles.
      - TypeScript: Strongly encouraged; use interfaces for props and state.
      - Styling: Use CSS Modules or Tailwind CSS for scoped styles; avoid global CSS unless necessary.
      - Testing: Integrate Jest or React Testing Library in `tests/`.
      - For Unagi: Structure RAG-related frontend (e.g., query interfaces) in `app/rag/`, with shared components in `components/`. Ensure API routes in `app/api/` handle backend integrations securely.
    - **Formatting**: While Next.js doesn't enforce a formatter, align with ESLint/Prettier for JS/TS code. Run `npm run lint` and `npm run format` in workflows.
- **Integration with Goose**: When generating or modifying code, suggest recipes that enforce these standards (e.g., a recipe to format Python files with Ruff or validate Next.js structure). For writes/executions via Gemini CLI, always apply formatting post-generation.
