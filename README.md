# PDF API

## Getting Started

### 1. Install Python 3.12
Ensure Python 3.12 is installed on your system. Check the version:
```bash
python3 --version
```
If it's not installed, refer to your operating system's documentation to install Python 3.12.

### 2. Set Up the Project
Run the following command to set up the project and download the required model:
```bash
make setup
```

### 3. Run the Project
Use the `run.sh` script to start all necessary components (Qdrant storage, embeddings server, PDF QA server, and Nginx):
```bash
./run.sh
```

### 4. Test the Servers
- **Health Check for Embeddings Server**:
  ```bash
  curl http://localhost:8080/health
  ```

- **Health Check for PDF QA Server**:
  ```bash
  curl http://localhost:9000/health
  ```

### 5. Upload a PDF
Upload a PDF to the server:
```bash
curl -X POST -F "file=@progit.pdf" http://localhost:9000/upload
```

### 6. Ask Questions About a PDF
Ask a question about an uploaded PDF:
```bash
curl -X POST \
  http://localhost:9000/ask \
  -H "Content-Type: application/json" \
  -d '{
    "question": "What is Git?",
    "pdf_id": "pdf_progit.pdf",
    "chat_history": []
  }'
```

### 7. Get a Specific PDF Chunk
Retrieve a specific chunk of a PDF:
```bash
curl -X GET "http://localhost:9000/pdfs/pdf_progit.pdf/chunks/101"
```
