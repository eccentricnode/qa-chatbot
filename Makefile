setup:
	python3.12 -m venv venv
	. venv/bin/activate && pip install -r embeddings_server_requirements.txt
	. venv/bin/activate && pip install -r pdf_qa_requirements.txt
	mkdir -p models
	python download_models.py