#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Start the Qdrant storage container
echo "Starting the Qdrant storage container..."
docker compose up -d qdrant

# Step 2: Start the embeddings server
echo "Starting the embeddings server..."
nohup python3 embeddings_server.py > embeddings_server.log 2>&1 &

# Step 3: Start the PDF QA server
echo "Starting the PDF QA server..."
nohup uvicorn pdf_qa_server:app --host 0.0.0.0 --port 9000 > pdf_qa_server.log 2>&1 &

# Final message
echo "Workspace is up and running!"
echo "- Embeddings server: http://localhost:8080"
echo "- PDF QA server: http://localhost:9000"