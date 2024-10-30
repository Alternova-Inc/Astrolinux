#!/bin/bash
set -e
 
source ~/.local/share/astrolinux/gum/gum-styles.sh
 
gum_styled_text "Installing OBS Studio..."

sudo add-apt-repository -y ppa:obsproject/obs-studio

sudo apt update

sudo apt install -y obs-studio

if command -v obs >/dev/null 2>&1; then
    gum_styled_text  "OBS Studio installed successfully."
else
    gum_styled_text  "Failed to install OBS Studio."
fi