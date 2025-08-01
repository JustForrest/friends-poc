# Project: Unagi

## 1. Project Goal

This project is a Proof-of-Concept (PoC) to build a Retrieval-Augmented Generation (RAG) system using scripts from the "Friends" TV show. The primary goal is a functional web application that allows a user to ask questions and get answers based on the show's dialogue.

**The full Product Requirements Document (PRD) can be found in `UNAGI_PRD.md`. Refer to it for detailed features and requirements.**

**GitHub Repository:** https://github.com/JustForrest/friends-poc

## 2. Tech Stack

- **Backend:** Python with FastAPI
- **Vector DB:** Qdrant (running via Docker)
- **Frontend:** Next.js
- **Authentication:** Clerk
- **LLM:** Llama 3.1 70B
- **Orchestration:** LangChain

## 3. Development Environment & Tooling

To ensure consistency, the project uses specific VS Code extensions to enforce code style and quality. When generating or modifying code, adhere to the standards enforced by these tools:

- **`charliermarsh.ruff`**: All Python code must be formatted and linted with Ruff.
- **`dbaeumer.vscode-eslint`**: All JavaScript/TypeScript code must adhere to ESLint rules.
- **`ms-azuretools.vscode-docker`**: The project uses Docker for services like Qdrant. Be prepared to create and modify `Dockerfile` and `docker-compose.yml` files.

## 4. The Linear Method & AI Agent Prep

To ensure our project is well-organized and prepared for automation, all work must adhere to Linear's conceptual model.

- **Work is an Issue:** Everything we do is captured as an **issue**, which represents a single piece of work.
- **Issues Have a Lifecycle:** An issue moves through a clear lifecycle: `Triage` -> `Backlog` -> `Todo` -> `In Progress` -> `Done`.
- **Cycles for Momentum:** We organize our work into **Cycles** (sprints) to maintain momentum and focus on a small batch of issues at a time.
- **Projects for Goals:** Our "Unagi" **Project** is the high-level goal that all our issues and cycles contribute to.

**Issue Creation Format for AI:**
To make issues easy for Linear's AI Agents to process, all suggested or drafted issues should follow this format:

- **Clear, Action-Oriented Title:** The title should be a command (e.g., "Build the data ingestion script," not "Data script").
- **Structured Description:** The description should include sections for `Background`, `Acceptance Criteria`, and `Technical Approach`. This structure provides rich context for AI autofill and triage features.

## 5. Core Instructions

- All Python code must be typed and follow PEP 8 standards, and be formatted with Ruff.
- FastAPI endpoints should use Pydantic models for request and response validation.
- The RAG chain logic should be modular and easy to understand.
- Prioritize asynchronous (`async`) methods in the FastAPI backend for performance.
- **Always structure new issues according to "The Linear Method & AI Agent Prep" section above.**
- Proactively identify potential tasks, bugs, or feature enhancements during our conversation. When you spot one, suggest that we create a new Linear issue for it by saying, "This seems like a good candidate for a new Linear issue. Should I draft one following our format?"

## 6. Audience

- Assume the user has a basic understanding of web development at approximately a junior leve of an undergraduate student in a computer science bachelor's program
- Find teachable moments to highlight gaps in knowledge and inform the user but try not to get too wordy. Keep teaching moments concise and relevant to the task at hand.
- Try to teach algorithmic thinking where possible and appropriate.
