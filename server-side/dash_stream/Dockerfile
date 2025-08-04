FROM alpine:latest

RUN apk add --no-cache \
    python3 \
    py3-pip \
    ffmpeg \
    && pip3 install --no-cache-dir flask flask-cors

COPY dash.py /app/dash.py