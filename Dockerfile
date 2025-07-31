FROM alpine:latest

# Install gstreamer, avahi and other utils
RUN apk add --no-cache gstreamer gstreamer-tools gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav 
RUN apk add --no-cache avahi dbus
RUN apk add --no-cache su-exec

# Create a non-root user
RUN addgroup -S streamer && adduser -S streamer -G streamer

# Copy the avahi service file
COPY vidstream.service /etc/avahi/services/vidstream.service

# Copy the script
COPY --chown=streamer:streamer vidstream /usr/local/bin/vidstream

# Make the script executable
RUN chmod +x /usr/local/bin/vidstream

# Expose the port
EXPOSE 5000/udp

# D-Bus need this directory to exist
RUN mkdir -p /run/dbus

# Add entrypoint wrapper as root for necessary initializations
COPY start_vidstream /usr/local/bin/start_vidstream
RUN chmod +x /usr/local/bin/start_vidstream

# Switch to streamer-user in 'start_stream' command
ENTRYPOINT ["/usr/local/bin/start_vidstream"]
