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

## 3. Core Instructions
- All Python code must be typed and follow PEP 8 standards.
- FastAPI endpoints should use Pydantic models for request and response validation.
- The RAG chain logic should be modular and easy to understand.
- Prioritize asynchronous (`async`) methods in the FastAPI backend for performance.