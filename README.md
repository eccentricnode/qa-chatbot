# AI Document Q&A System - Learning Project with Business Context
**The Challenge I Explored**: Like many organizations, I've seen teams waste time searching through documents for specific information. Whether it's customer support agents digging through product manuals or employees hunting for policy details, document search is a common productivity drain that seemed like a good problem to tackle while learning AI implementation.

**What I Built**: I created a document Q&A system using RAG architecture and vector databases to let users ask natural language questions about uploaded PDFs. While this was primarily a learning exercise to understand how modern AI tools work in practice, it demonstrates the type of practical business applications that AI can enable - from customer support knowledge bases to internal documentation systems. The project helped me understand both the technical implementation and the real-world considerations of deploying AI solutions in business contexts.


### Here's a video discussing how it works --> [Turn Any PDF Into an Interactive Q&A Bot](https://www.youtube.com/watch?v=Wy0WV8L9Opw)

## Installation Instructions

### 1. Install Python 3.12
Ensure Python 3.12 is installed on your system. Check the version:
```bash
python3 --version
```

### 2. Set Up a Virtual Environment
Create and activate a virtual environment:
```bash
python3.12 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
Install the required Python packages:
```bash
pip install -r embeddings_server_requirements.txt
pip install -r pdf_qa_requirements.txt
```

### 4. Set Up the Cache Directory
Create the cache directory for Hugging Face models:
```bash
mkdir -p /models
```

### 5. Run the Servers
- Start the embeddings server:
  ```bash
  python3 embeddings_server.py
  ```
  This will run the server on `http://localhost:8080`.

- Start the PDF QA server:
  ```bash
  uvicorn pdf_qa_server:app --host 0.0.0.0 --port 9000
  ```

### 6. Test the Servers
- **Health Check for Embeddings Server**:
  ```bash
  curl http://localhost:8080/health
  ```

- **Health Check for PDF QA Server**:
  ```bash
  curl http://localhost:9000/health
  ```

## Upload a PDF

```bash
curl -X POST -F "file=@progit.pdf" http://localhost:9000/upload
```

> **Note:** For better OCR results, please check out my Docling video tutorial.

## Ask Questions About a PDF

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

## Get a Specific PDF Chunk
```bash
curl -X GET "http://localhost:9000/pdfs/pdf_progit.pdf/chunks/101"
```
