#!/bin/bash
set -e

# Function to check if gnome-terminal command is available
is_gnome_terminal_available() {
    command -v gnome-terminal >/dev/null 2>&1
}

# Check if gnome-terminal is available
if is_gnome_terminal_available; then
    gnome-terminal --geometry=90x24 -- bash -c wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/boot.sh | bash
else
    echo "gnome-terminal is not available. open this script in ubutnu 24.04 with gnome-terminal"
fi

clear