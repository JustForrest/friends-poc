Project: Unagi
About This Project
This is a Proof-of-Concept (PoC) for a Retrieval-Augmented Generation (RAG) system built with Python (FastAPI) and a Next.js frontend. The goal is to answer questions based on the scripts from the TV show "Friends." The application is specifically designed to run on an NVIDIA DGX Spark platform.

Key Technologies & Libraries
Target Platform: NVIDIA DGX Spark

LLM: NVIDIA Llama-3.3-Nemotron-Super-49B-v1.5

Backend: Python, FastAPI, LangChain

Vector DB: Qdrant

Frontend: Next.js, React, TypeScript

Authentication: Clerk

Coding Style & Conventions
Python: All code must be fully type-hinted and follow PEP 8 standards. Format and lint code using Ruff. FastAPI endpoints must use Pydantic for request/response models. Prioritize async methods.

TypeScript/React: Use functional components with hooks. Follow standard TypeScript best practices for type safety.

General: All functions and components should have clear, concise docstrings or JSDoc comments.

Important Files for Context
Overall Requirements: UNAGI_PRD.md

Backend Entrypoint: app/main.py

Frontend Entrypoint: pages/index.tsx
