#!/usr/bin/env bash

fatal() {
  echo "Error: $1" >&2
  exit 1
}

v=false
src=""
while getopts "vs:" opt; do
  case $opt in
    v) v=true;;
    s)
        case $OPTARG in
          "videofile")
            src=$OPTARG
            videofile="/users/$(whoami)/video.mp4"  # Default video file path
            [ -f $videofile ] || fatal "File not found ${OPTARG}"
            videofile=$OPTARG
            ;;
          *)
            echo "Invalid source of stream: $OPTARG."
            fatal "Usage: $0 [-v]"
            ;;
        esac
        fatal "File not found: $OPTARG";;
    \?)
      fatal "Usage: $0 [-v]"
      ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$src" ]; then
  fatal "No source specified. Use -s videofile to specify a video file."
fi

if [ $v = true ]; then
  echo "Starting RTP server on $src"
fi

gst-launch-1.0 -v \
  rtpbin name=rtpbin \
  filesrc location="$videofile" ! decodebin ! videoconvert ! x264enc ! rtph264pay config-interval=1 pt=96 ! rtpbin.send_rtp_sink_0 \
  rtpbin.send_rtp_src_0 ! udpsink host=

