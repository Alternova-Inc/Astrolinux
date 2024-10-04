#!/bin/bash
set -e

# Function to check if gnome-terminal command is available
is_gnome_terminal_available() {
    command -v gnome-terminal >/dev/null 2>&1
}

# Check if gnome-terminal is available
if is_gnome_terminal_available; then
    wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/boot.sh | bash; exec bash
else
    echo "gnome-terminal is not available. Open this script in Ubuntu 24.04 with gnome-terminal."
fi
