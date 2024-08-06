#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing LibreOffice..."

sudo apt-get update
sudo apt-get install -y libreoffice

if command -v libreoffice >/dev/null 2>&1; then
    gum_styled_text "LibreOffice installed successfully."
fi