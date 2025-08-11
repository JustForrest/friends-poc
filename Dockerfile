# Use a lightweight Python base image for arm64 (Apple Silicon)
FROM --platform=linux/arm64 python:3.11-slim

# Set environment variables (e.g., for Goose provider, API keys – override via env vars or .env file)
ENV GOOSE_DEFAULT_PROVIDER=grok
ENV PYTHONUNBUFFERED=1
ENV PATH="/home/devuser/.local/bin:$PATH"

# Install system dependencies (curl, git, build tools) and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git build-essential && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user for security (avoids running as root in container)
RUN useradd -m devuser
USER devuser
WORKDIR /home/devuser/app

# Copy project files (requirements.txt first for caching)
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Copy the rest of the app code
COPY . .

# Expose any necessary ports (e.g., for FastAPI or Qdrant – adjust as needed)
EXPOSE 8000

# Default command (e.g., start Goose or your app – customize)
CMD ["bash"]