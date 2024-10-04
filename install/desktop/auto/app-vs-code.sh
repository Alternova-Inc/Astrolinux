#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing Visual Studio Code..."

# Add Microsoft GPG key and repository
if ! command -v code >/dev/null 2>&1; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
    rm -f packages.microsoft.gpg
    cd -
fi

# Install Visual Studio Code
sudo apt update -y
sudo apt install -y code

if command -v code >/dev/null 2>&1; then
    gum_styled_text "Visual Studio Code installed successfully."
else
    gum_styled_text "Failed to install Visual Studio Code."
fi
