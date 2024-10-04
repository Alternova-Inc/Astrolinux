#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh  # Source the styling functions.

# Create a dedicated temporary directory for Warp
warp_temp_dir=$(mktemp -d -t warp-XXXXXX)
gum_styled_text "Using temporary directory: $warp_temp_dir"

cd "$warp_temp_dir" || { gum_styled_text "Error changing directory"; exit 1; }

gum_styled_text "Installing warp terminal..."

# Ensure wget and gpg are installed.
sudo apt-get install -y wget gpg

# Download the GPG key and convert it to a suitable format.
wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg

# Install the GPG key to the appropriate location.
sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt/keyrings/warpdotdev.gpg

# Add the Warp terminal repository to the sources list.
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" | sudo tee /etc/apt/sources.list.d/warpdotdev.list

# Remove the temporary GPG key file.
rm warpdotdev.gpg

# Update the package list and install the Warp terminal.
sudo apt update && sudo apt install -y warp-terminal

# Change back to the original directory and remove the temporary directory.
cd - || exit  # If changing back fails, exit the script.
rm -rf "$warp_temp_dir"  # Remove the temporary directory.

gum_styled_text "Warp Terminal installed successfully."
