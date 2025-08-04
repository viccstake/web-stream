#!/usr/bin/env bash

# Start D-Bus daemon
dbus-daemon --system
# Start Avahi daemon
avahi-daemon --no-chroot --daemonize
# Wait for the daemons to start
sleep 2