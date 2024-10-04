#!/bin/bash
set -e

IMAGE_PATH="$HOME/.local/share/astrolinux/alternova-background.png"

if [ ! -f "$IMAGE_PATH" ]; then
    echo "The image is not in the specified path: $IMAGE_PATH"
    exit 1
fi

gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_PATH"
gsettings set org.gnome.desktop.background picture-options 'zoom'
echo "Background screen set in GNOME."