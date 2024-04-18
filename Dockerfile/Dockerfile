FROM nvidia/cuda:12.3.2-base-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    git libsndfile1-dev tesseract-ocr espeak-ng python3 python3-pip ffmpeg daemontools

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools

RUN python3 -m pip install --no-cache-dir --upgrade fschat[model_worker,webui]==0.2.35

WORKDIR /app
