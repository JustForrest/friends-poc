Updated Product Requirements Document: Unagi
Version: 1.4
Status: Draft
Author: Forrest
Last Updated: 2025-08-11

1. Overview
   1.1. Background
   Unagi is an internal research and development project designed to explore the capabilities of modern AI technologies on a well-defined, closed-domain dataset. The project is specifically targeted to run on the NVIDIA DGX Spark platform, leveraging its Grace Blackwell architecture and 128GB of unified memory to power demanding AI workloads locally.

The project uses the complete script archive of the TV show "Friends" to build a conversational AI system, serving as a foundational step toward developing more complex, agentic AI systems in-house. Development will prioritize the use of Goose, an open-source AI agent created by Block, as the primary agentic AI coding partner. Goose leverages large language models (LLMs) with tool-calling capabilities, extensions via the Model Context Protocol (MCP), and features like recipes (YAML-based automated workflows) and Goosehints (contextual guidance files) to accelerate engineering tasks such as code generation, debugging, and automation. To create an agent-first development environment, Goose will be integrated with the Gemini CLI for task delegation, where Goose handles planning and read operations, and Gemini CLI manages writes and executions. This setup emphasizes agentic workflows through Goose's recipes and sub-recipes, enabling parallel and nested task execution for efficient development.

1.2. Problem Statement
Businesses need a robust, end-to-end Retrieval-Augmented Generation (RAG) system that can be built and deployed locally. This system must handle the entire lifecycle of a RAG application: ingesting and processing raw text data, embedding it into a vector store, serving it via a high-performance API, and interacting with it through a clean, modern web interface. The goal is to create a tangible, working application that demonstrates our ability to build and manage sophisticated AI systems in-house.

1.3. Purpose
The purpose of this document is to define the scope, features, and requirements for Unagi. It will serve as the central source of truth for the development team, ensuring alignment on goals, technical specifications, and success criteria throughout the project lifecycle. This PRD will be managed in conjunction with our project tracking using GitHub's project management offerings, including GitHub Issues, Projects, and Milestones.

2. Goals and Objectives
   2.1. Business & Technical Goals
   Develop In-House Expertise: Build institutional knowledge and hands-on experience in creating, deploying, and managing local RAG systems.
   Create a Reusable Blueprint: Establish a well-documented, containerized architecture that can serve as a template for future RAG projects.
   Evaluate NVIDIA-Optimized LLM Performance: Assess the performance and suitability of the NVIDIA Llama-3.3-Nemotron-Super-49B-v1.5 model, leveraging the hardware-software synergy of running an NVIDIA-optimized model on the DGX Spark platform.
   Validate Development Tooling: Test and confirm the effectiveness of using Goose as the primary agentic AI coding partner for AI application engineering. This includes leveraging Goose's architecture (LLM-driven tool calling and extensions), recipes for automated workflows, sub-recipes for parallel and nested task execution, and Goosehints for contextual guidance to accelerate tasks like code generation, debugging, and integration. Emphasize an agent-first approach by integrating Goose with Gemini CLI to create efficient, delegated workflows.
   2.2. Product Goals
   Functional MVP: Deliver a working web application that allows authenticated users to ask questions about the "Friends" TV show and receive accurate answers.
   High-Quality Responses: Ensure the AI's responses are contextually relevant, factually grounded in the provided scripts, and free of hallucinations.
   Performant User Experience: Provide a responsive user interface with low-latency answers to user queries, maximized by the optimized model-hardware pairing.
   2.3. Success Metrics
   Project Completion: All defined issues in the "Unagi" GitHub Project are completed within the planned milestones.
   Successful Demonstration: The application can be successfully demonstrated to stakeholders, performing all core functions without critical errors.
   API Performance: The p95 (95th percentile) response time for queries to the RAG API endpoint is under 2 seconds.
   Qualitative Feedback: Positive feedback from internal testers regarding the accuracy and relevance of the AI's answers.
3. User Personas and Scenarios
   3.1. Personas
   Alex, the AI Engineer:
   Role: Backend developer, AI/ML enthusiast.
   Goals: Wants to understand the practical steps of building a RAG pipeline, from data ingestion to API deployment. Needs to see how the different components (Vector DB, LLM, API framework) fit together, with assistance from Goose for tasks like code generation and automation.
   Frustrations: Theoretical examples that don't cover end-to-end implementation details like authentication and containerization.

Sam, the Product Manager:
Role: Non-technical stakeholder, evaluates product viability.
Goals: Wants to quickly understand the capabilities and limitations of our in-house AI systems. Needs to interact with a working demo to assess the quality of the user experience and the accuracy of the AI.
Frustrations: Demos that are unstable or difficult to use. AI responses that are irrelevant or nonsensical.

3.2. User Scenarios (Stories)
As Alex, I want to clone the project repository and run the entire application with a single docker-compose up command, so that I can quickly get the system running on my local machine.
As Alex, I want to be able to easily modify the data processing script and re-run the ingestion pipeline, so that I can experiment with different chunking strategies, potentially using Goose recipes for automation.
As Sam, I want to log into the web application using a simple username/password, so that I can easily access the chat interface.
As Sam, I want to ask a specific question like "What was the name of Ross's monkey?" and receive a direct, accurate answer ("Marcel"), so that I can verify the system's factual grounding.
As Sam, I want to ask a more open-ended question like "Summarize the conflict between Ross and Rachel in Season 3" and receive a coherent summary, so that I can assess the system's ability to synthesize information. 4. Features and Requirements
4.1. Data Ingestion Pipeline
Data Source: The system must ingest all text-based scripts from the Emory NLP GitHub repository.
Preprocessing: A Python script must be created to clean the raw text, removing metadata, scene directions, and standardizing character names.
Chunking: The cleaned text must be split into smaller, semantically meaningful chunks suitable for embedding. The chunking strategy must be configurable.
Embedding: The text chunks must be converted into vector embeddings using a local, open-source sentence-transformer model.
Vector Storage: The embeddings and their corresponding text metadata must be stored and indexed in a Qdrant vector database.
4.2. Backend API (FastAPI)
Query Endpoint: The API must provide a /query endpoint (POST method) that accepts a JSON object containing the user's question.
Request Validation: The endpoint must use a Pydantic model to validate that the incoming request contains a non-empty string field named query.
RAG Core Logic: Upon receiving a valid query, the backend will use LangChain's official Qdrant vector store integration to:
Embed the user's query into a vector.
Use the query vector to search Qdrant for the most relevant text chunks.
Pass the retrieved chunks and the original query to the NVIDIA Llama-3.3-Nemotron-Super-49B-v1.5 model via a formatted prompt.
Return the LLM's generated response as a JSON object.
Health Check: A simple /health endpoint (GET method) must be included that returns a 200 OK status to indicate the service is running.
CORS Configuration: The API must implement FastAPI's CORSMiddleware to allow requests from the Next.js frontend's origin during development.
4.3. Frontend Web Application (Next.js)
User Authentication: The application must use Clerk's official @clerk/nextjs library. Clerk's middleware must be configured to protect all application pages and backend API routes, redirecting unauthenticated users to a sign-in page.
Chat Interface: A clean, simple interface will be built, consisting of:
A message history display area.
A text input field for users to type their questions.
A "Send" button.
API Communication: The frontend will make asynchronous API calls to the backend's /query endpoint, sending the user's question and displaying the returned answer in the message history.
State Management: The application will manage the conversation state, including user messages and AI responses.
4.4. Deployment and Operations
Containerization: The FastAPI backend, Next.js frontend, and Qdrant database must each have their own Dockerfile.
Orchestration: A docker-compose.yml file must be created to define and run all application services with a single command (docker-compose up).
Configuration: All sensitive information (API keys, etc.) and environment-specific settings must be managed via .env files.
Linter & Formatter Configuration: A pyproject.toml file must be created and maintained in the project root to configure all rules for the Ruff linter and formatter. 5. Development Methodology
5.1. Agent-First Approach
Development will adopt an agent-first methodology, prioritizing Goose's recipes and sub-recipes to create agentic workflows for specific tasks. Recipes will define sequences of prompts, tools, and sub-tasks, executed in parallel where appropriate (e.g., via sub-recipes for concurrent data processing or testing). Gemini CLI will serve as a complementary worker for write operations, integrated via custom extensions, while Goose handles planning and read-only interactions.

5.2. Environment Setup
Containerized Development: Use a multi-service Docker Compose setup on macOS/Apple Silicon (arm64), with a main container (unagi-dev) based on python:3.11-slim and a separate MCP service for GitHub integrations. Integrate with VS Code Remote-Containers for seamless editing.
Security and Access: Employ fine-grained, read-only Personal Access Tokens (PATs) for GitHub access, stored in .env. Delegate reads to Goose via local MCP server and writes to Gemini CLI.
Tooling Integration: Configure Goose with Grok-4/xAI API as the lead model. Use Gemini CLI for task execution, leveraging its modular architecture for extensions like GitHub writes. 6. Out of Scope
The following features and functionalities are explicitly out of scope for this Proof-of-Concept to ensure focus on the core objectives. They may be considered for future versions.

UI-based Hyperparameter Tuning: The web interface will not include sliders or controls for adjusting RAG parameters (e.g., number of documents retrieved, LLM temperature). These will be configurable only in the backend code or environment variables.
Conversation History: The system will not persist chat history between sessions. Each page refresh will start a new, stateless conversation.
Multi-User Chat: The application will not support real-time collaboration or shared chat sessions between different users.
Advanced Data Analysis: The PoC will not include a dashboard or analytics for evaluating retrieval quality or LLM performance.
Comparative Model Benchmarking: While we are using the Nemotron model for its performance benefits, a direct, quantitative performance comparison against other models (e.g., Llama 3.1 70B) is not a goal for this project.
