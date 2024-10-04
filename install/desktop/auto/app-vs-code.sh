#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing Visual Studio Code..."

# Add Microsoft GPG key and repository
if ! command -v code >/dev/null 2>&1; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
fi

# Install Visual Studio Code
install_from_url() {
    local url="$1"
    local temp_deb="/tmp/temp_package.deb"
  
    wget -qO "$temp_deb" "$url"
    sudo dpkg -i "$temp_deb" || { sudo apt-get install -f -y; }
    rm "$temp_deb"
}

install_from_url "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

if command -v code >/dev/null 2>&1; then
    gum_styled_text "Visual Studio Code installed successfully."
else
    gum_styled_text "Failed to install Visual Studio Code."
fi
