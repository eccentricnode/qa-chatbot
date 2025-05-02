#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Add functionality to stop and restart services
if [ "$1" == "stop" ]; then
    echo "Stopping all services..."
    pkill -f embeddings_server.py
    pkill -f uvicorn
    docker compose down
    echo "All services stopped."
    exit 0
fi

if [ "$1" == "restart" ]; then
    echo "Restarting all services..."
    $0 stop
    $0 start
    exit 0
fi

# Default action: start services
if [ "$1" != "start" ]; then
    echo "Usage: $0 {start|stop|restart}"
    exit 1
fi

# Step 1: Start Qdrant and LocalAI services using Docker Compose
echo "Starting Qdrant and LocalAI services..."
docker compose up --build -d qdrant localai

# Step 2: Start the embeddings server
echo "Starting the embeddings server..."
python3 embeddings_server.py &

# Step 3: Start the PDF QA server
echo "Starting the PDF QA server..."
uvicorn pdf_qa_server:app --host 0.0.0.0 --port 9000 &

# Step 4: Start the Nginx service
echo "Starting the Nginx service..."
sudo service nginx start

# Final message
echo "Workspace is up and running!"
echo "- Embeddings server: http://localhost:8080"
echo "- PDF QA server: http://localhost:9000"
echo "- Nginx service is running!"