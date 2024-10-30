#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing Bruno..."

# Create directory for keys if it does not exist
sudo mkdir -p /etc/apt/keyrings

# Add Bruno's GPG key
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266

# Add Bruno's repository to the apt source list
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list

sudo apt update
sudo apt install -y bruno

if command -v bruno >/dev/null 2>&1; then
    gum_styled_text "Bruno installed successfully."
else
    gum_styled_text "Failed to install Bruno."
fi