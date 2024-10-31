#!/bin/bash
set -e

# Function to check if gnome-terminal command is available
is_gnome_terminal_available() {
    command -v gnome-terminal >/dev/null 2>&1
}

# Attempt to resize the current terminal
resize_terminal() {
    printf '\e[8;24;90t'
}

# Check if gnome-terminal is available
if is_gnome_terminal_available; then
    resize_terminal
    eval "$(wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/test/boot.sh)"
   # gnome-terminal --geometry=90x24 -- bash -c "./boot.sh; exec bash"
else
    echo "gnome-terminal is not available. Open this script in Ubuntu 22.04 with gnome-terminal."
    #source ./boot.sh
fi
