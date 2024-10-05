#!/bin/bash
set -e

# Function to check if gnome-terminal command is available
is_gnome_terminal_available() {
    command -v gnome-terminal >/dev/null 2>&1
}

# Attempt to resize the current terminal
resize_terminal() {
    printf '\e[8;24;90t'  # Cambia el tamaño a 24 filas y 90 columnas
}

# Check if gnome-terminal is available
if is_gnome_terminal_available; then
    resize_terminal  # Redimensionar la terminal actual
    eval "$(wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/boot.sh)"
else
    echo "gnome-terminal is not available. Open this script in Ubuntu 24.04 with gnome-terminal."
fi
