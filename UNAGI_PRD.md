Product Requirements Document: Unagi
Version: 1.0
Status: Draft
Author: [Your Name/Team Name]
Last Updated: July 31, 2024

1. Overview
1.1. Background
Unagi is an internal research and development project designed to explore the capabilities of modern AI technologies on a well-defined, closed-domain dataset. The project leverages the complete script archive of the TV show "Friends" to build a conversational AI system. This PoC serves as a foundational step toward developing more complex, agentic AI systems on local hardware, providing a controlled environment to test and refine our data processing pipelines, LLM interactions, and application architecture.

1.2. Problem Statement
Businesses need a robust, end-to-end Retrieval-Augmented Generation (RAG) system that can be built and deployed locally. This system must handle the entire lifecycle of a RAG application: ingesting and processing raw text data, embedding it into a vector store, serving it via a high-performance API, and interacting with it through a clean, modern web interface. The goal is to create a tangible, working application that demonstrates our ability to build and manage sophisticated AI systems in-house.

1.3. Purpose
The purpose of this document is to define the scope, features, and requirements for Unagi. It will serve as the central source of truth for the development team, ensuring alignment on goals, technical specifications, and success criteria throughout the project lifecycle. This PRD will be managed in conjunction with our project tracking in Linear.

2. Goals and Objectives
2.1. Business & Technical Goals
Develop In-House Expertise: Build institutional knowledge and hands-on experience in creating, deploying, and managing local RAG systems.

Create a Reusable Blueprint: Establish a well-documented, containerized architecture that can serve as a template for future RAG projects.

Evaluate Local LLM Performance: Assess the suitability and performance of the Llama 3.1 70B model for a specific, real-world RAG task.

Validate Development Tooling: Test and confirm the effectiveness of using the Gemini CLI as a development accelerator for AI application engineering.

2.2. Product Goals
Functional MVP: Deliver a working web application that allows authenticated users to ask questions about the "Friends" TV show and receive accurate answers.

High-Quality Responses: Ensure the AI's responses are contextually relevant, factually grounded in the provided scripts, and free of hallucinations.

Performant User Experience: Provide a responsive user interface with low-latency answers to user queries.

2.3. Success Metrics
Project Completion: All defined issues in the "Unagi" Linear project are completed within the planned cycles.

Successful Demonstration: The application can be successfully demonstrated to stakeholders, performing all core functions without critical errors.

API Performance: The p95 (95th percentile) response time for queries to the RAG API endpoint is under 2 seconds.

Qualitative Feedback: Positive feedback from internal testers regarding the accuracy and relevance of the AI's answers.

3. User Personas and Scenarios
3.1. Personas
Alex, the AI Engineer:

Role: Backend developer, AI/ML enthusiast.

Goals: Wants to understand the practical steps of building a RAG pipeline, from data ingestion to API deployment. Needs to see how the different components (Vector DB, LLM, API framework) fit together.

Frustrations: Theoretical examples that don't cover end-to-end implementation details like authentication and containerization.

Sam, the Product Manager:

Role: Non-technical stakeholder, evaluates product viability.

Goals: Wants to quickly understand the capabilities and limitations of our in-house AI systems. Needs to interact with a working demo to assess the quality of the user experience and the accuracy of the AI.

Frustrations: Demos that are unstable or difficult to use. AI responses that are irrelevant or nonsensical.

3.2. User Scenarios (Stories)
As Alex, I want to clone the project repository and run the entire application with a single docker-compose up command, so that I can quickly get the system running on my local machine.

As Alex, I want to be able to easily modify the data processing script and re-run the ingestion pipeline, so that I can experiment with different chunking strategies.

As Sam, I want to log into the web application using a simple username/password, so that I can easily access the chat interface.

As Sam, I want to ask a specific question like "What was the name of Ross's monkey?" and receive a direct, accurate answer ("Marcel"), so that I can verify the system's factual grounding.

As Sam, I want to ask a more open-ended question like "Summarize the conflict between Ross and Rachel in Season 3" and receive a coherent summary, so that I can assess the system's ability to synthesize information.

4. Features and Requirements
4.1. Data Ingestion Pipeline
Data Source: The system must ingest all text-based scripts from the Emory NLP GitHub repository.

Preprocessing: A Python script must be created to clean the raw text, removing metadata, scene directions, and standardizing character names.

Chunking: The cleaned text must be split into smaller, semantically meaningful chunks suitable for embedding. The chunking strategy must be configurable.

Embedding: The text chunks must be converted into vector embeddings using a local, open-source sentence-transformer model.

Vector Storage: The embeddings and their corresponding text metadata must be stored and indexed in a Qdrant vector database.

4.2. Backend API (FastAPI)
Query Endpoint: The API must provide a /query endpoint (POST method) that accepts a JSON object containing the user's question.

Request Validation: The endpoint must use a Pydantic model to validate that the incoming request contains a non-empty string field named query.

RAG Core Logic: Upon receiving a valid query, the backend will:

Embed the user's query into a vector.

Use the query vector to search Qdrant for the most relevant text chunks.

Pass the retrieved chunks and the original query to the Llama 3.1 70B model via a formatted prompt.

Return the LLM's generated response as a JSON object.

Health Check: A simple /health endpoint (GET method) must be included that returns a 200 OK status to indicate the service is running.

4.3. Frontend Web Application (Next.js)
User Authentication: The application must use Clerk for user sign-up, sign-in, and session management. Access to the chat interface must be restricted to authenticated users.

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

5. Out of Scope
The following features and functionalities are explicitly out of scope for this Proof-of-Concept to ensure focus on the core objectives. They may be considered for future versions.

UI-based Hyperparameter Tuning: The web interface will not include sliders or controls for adjusting RAG parameters (e.g., number of documents retrieved, LLM temperature). These will be configurable only in the backend code or environment variables.

Conversation History: The system will not persist chat history between sessions. Each page refresh will start a new, stateless conversation.

Multi-User Chat: The application will not support real-time collaboration or shared chat sessions between different users.

Advanced Data Analysis: The PoC will not include a dashboard or analytics for evaluating retrieval quality or LLM performance.

Support for Multiple LLMs: The system will be built specifically for the Llama 3.1 70B model and will not include a mechanism for swapping to other models.