1. Project Overview
   Project Name: Unagi – A Retrieval-Augmented Generation (RAG) system for querying and generating content based on Friends TV show scripts.
   Goals: Build in-house expertise in RAG systems, evaluate NVIDIA-optimized LLMs, and create a secure, agentic development workflow. Features include data ingestion (scripts chunking/embedding into Qdrant vector DB), a FastAPI Python backend for API endpoints, and a Next.js frontend with Clerk authentication.
   Out-of-Scope: Advanced UI styling, chat history persistence, or non-core integrations.
   Tech Stack:
   Backend: Python 3.11+ with FastAPI, Qdrant for vector storage.
   Frontend: Next.js (App Router, TypeScript, Server Components, CSS Modules/Tailwind).
   Database: Qdrant (vector DB for embeddings).
   AI/Agents: Goose (primary AI coding agent for planning/recipes), Gemini CLI (for code writes/executions), integrated with LLMs like Grok via xAI/OpenRouter.
   Version Control: GitHub with Issues, Projects (board/table/roadmap views), Milestones, and Actions for automation.
   Development Philosophy: Agent-first workflow – Use Goose for high-level planning, reads, and repeatable tasks via recipes/sub-recipes. Delegate writes and executions to Gemini CLI. Everything is sandboxed in Docker for security and isolation.
2. Development Environment and Containerization
   Setup: The entire project runs in a Docker containerized environment on macOS (Apple Silicon/arm64). Use VS Code Remote - Containers for editing inside the container to ensure consistency.
   Key Files:
   Dockerfile: Based on python:3.11-slim (arm64), installs Goose, Gemini CLI, gh CLI, and MCP extensions.
   docker-compose.yml: Defines services like unagi-dev (main dev container with volume mounts for project files, env vars like API keys/GITHUB_TOKEN) and mcp-github (isolated MCP server for GitHub integrations).
   .devcontainer/devcontainer.json: Configures VS Code Remote with extensions (Python, Ruff, ESLint, Prettier, Docker, GitHub Actions, Gemini Code Assist, Copilot). Includes post-create commands for dependency installation, Goose config, and tool verification.
   Best Practices:
   Always run commands (e.g., goose, gemini) inside the container via docker-compose exec unagi-dev bash.
   Use volume mounts for persistence (e.g., /workspace for project files). Avoid root users – containers run as UID/GID 1000:1000.
   For performance: Optimize for arm64; test with docker-compose up --build and verify healthchecks (e.g., MCP at http://mcp-github:3000/health).
   When suggesting code, ensure it's Docker-compatible (e.g., use absolute paths, handle env vars like $GEMINI_API_KEY or $GITHUB_TOKEN).
3. Coding Standards and Best Practices
   General:
   Follow agent-first: Suggest using Goose recipes (YAML files for workflows) for repeatable tasks like code generation or debugging before writing code.
   Use GitHub Issues for tasks (with titles, bodies, assignees, labels, milestones) and Projects for organization. Automate via GitHub Actions.
   Python (Backend):
   Use Ruff for formatting and linting (configured in pyproject.toml: line-length=88, double quotes, 4-space indent, sorted imports, no trailing whitespace).
   Commands: Run ruff format . and ruff check --fix on save.
   Structure: Modular code with clear separation (e.g., app/api/endpoints/, app/models/, app/services/ for RAG logic like embedding/chunking).
   Best Practices: Type hints, async where possible (e.g., FastAPI routes), error handling, and logging.
   Next.js (Frontend):
   Structure: Use App Router (app/ for routes/pages), components/, lib/ (utils/hooks), public/ (static assets), scripts/ (build scripts).
   Use TypeScript, Server Components, CSS Modules or Tailwind for styling.
   Linting/Formatting: ESLint and Prettier (configured in .eslintrc.json and .prettierrc). Enable format-on-save in VS Code.
   Best Practices: Optimize for performance (e.g., dynamic imports), handle auth with Clerk, integrate backend APIs via fetch.
   Copilot Suggestions: When generating code, adhere strictly to these standards. For example, suggest Ruff-formatted Python snippets or TypeScript components with proper imports.
4. Tool Integrations: Goose and Gemini CLI
   Goose AI Coding Agent:
   Role: Primary agent for planning, reads, and orchestration. Use it via goose command in the container.
   Key Features: Recipes (YAML for workflows, sub-recipes for parallel/nested tasks) – e.g., for data ingestion or code gen. Extensions like github-mcp for GitHub reads (connected to local MCP server at http://mcp-github:3000).
   Workflow: Delegate high-level tasks to Goose (e.g., "Plan a RAG pipeline recipe"). Config in config.toml: Set lead LLM to Grok via xAI/OpenRouter, enable extensions.
   When to Suggest: For any repeatable or complex task, propose creating a Goose recipe first.
   Gemini CLI:
   Role: Handles code writes, executions, and low-level tasks. Run via gemini in the container.
   Config: Hierarchical JSON (e.g., .gemini/settings.json for sandboxing, tool limits). Auth with $GEMINI_API_KEY.
   Workflow: Use for direct code suggestions or edits, but notify if a task could be a Goose recipe (e.g., sketch YAML). Custom extensions for GitHub writes (e.g., via Python wrappers or Actions).
   Best Practices: Keep responses concise; enforce coding standards; avoid shell access outside defined tools.
   Integration Tip: In Copilot suggestions, prefer Goose for agentic flows (e.g., "Use a Goose recipe for this") and Gemini for precise code blocks.
5. Additional Guidelines
   Security: All operations are read-only where possible (e.g., GitHub PATs with minimal scopes). Use env vars for secrets; never hardcode them.
   Testing and Debugging: Suggest unit tests (Pytest for Python, Jest for Next.js). Use Docker logs for debugging.
   Copilot Behavior: Be concise in suggestions. If unsure, reference project files like UNAGI_PRD.md or Gemini.md. Prioritize maintainability and scalability.
