#!/bin/bash
set -euo pipefail
source .env

if [ $# -eq 0 ]; then
  echo "Error: No video file provided."
  echo "Usage: ./run-container.sh <video-file>"
  exit 1
fi
videofile=$1
if [ ! -f "$videofile" ]; then
  echo "Error: File '$videofile' not found."
  exit 1
fi

videofile_abs_path="$(cd "$(dirname "$videofile")" && pwd)/$(basename "$videofile")"
videoname=$(basename "$videofile_abs_path")
video_path_in_container="/home/streamer/$videoname"

docker run --rm -p 5000:5000/udp \
    -v "${videofile_abs_path}:${video_path_in_container}:ro" \
    --hostname "${IMAGE_NAME}_${videoname}" \
    $IMAGE_NAME \
    $video_path_in_container