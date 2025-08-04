FROM alpine:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    bash \
    dbus \
    avahi \
    avahi-utils \
    gstreamer \
    gstreamer-tools \
    gst-plugins-base \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \
    gst-libav 

# D-Bus needs this directory to exist
RUN mkdir -p /run/dbus

# Copy program
COPY --chown=user:group daemons.sh /usr/local/bin/daemons.sh
COPY --chown=user:group rtp.sh /usr/local/bin/rtp.sh