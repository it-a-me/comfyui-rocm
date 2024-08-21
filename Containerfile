FROM ghcr.io/it-a-me/pytorch-rocm:latest
RUN apt-get -y update && apt-get -y install git
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
WORKDIR /ComfyUI
RUN --mount=type=cache,target=/root/.cache pip --no-cache-dir install -r /ComfyUI/requirements.txt
RUN sed 's!base_path: path/to/stable-diffusion-webui/!base_path: /models/!' extra_model_paths.yaml.example > extra_model_paths.yaml
RUN chmod +x /ComfyUI/main.py
ENTRYPOINT ["python3", "/ComfyUI/main.py", "--listen"]
