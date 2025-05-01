import os
import yaml
from huggingface_hub import hf_hub_download

# Define paths
config_dir = "./model_configs"
model_dir = "./models"
os.makedirs(model_dir, exist_ok=True)

# Load YAML configuration
config_file = os.path.join(config_dir, "phi-3.5-mini-instruct.yaml")
with open(config_file, "r") as f:
    config = yaml.safe_load(f)

# Download model files
for file in config.get("download_files", []):
    filename = file["filename"]
    repo_id = file["uri"]  # Use the uri field directly as the repo_id
    print(f"Downloading {filename} from {repo_id}...")
    hf_hub_download(repo_id=repo_id, filename=filename, cache_dir=model_dir)
    print(f"Downloaded {filename} to {model_dir}")