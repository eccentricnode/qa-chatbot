# PDF API

### 1. Install Python 3.12
Ensure Python 3.12 is installed on your system. Check the version:
```bash
python3 --version
```
If it's not installed, you can install it using:
```bash
sudo apt update
sudo apt install python3.12 python3.12-venv python3.12-distutils
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

If you prefer to use a local directory, update the `TRANSFORMERS_CACHE` environment variable in `embeddings_server.py`:
```python
os.environ["TRANSFORMERS_CACHE"] = "./models"
```

### 5. Run the Servers
- Start the embeddings server:
  ```bash
  python embeddings_server.py
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
