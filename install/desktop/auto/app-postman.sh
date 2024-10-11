#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing Postman..."

install_from_url() {
  local url="$1"
  local temp_deb="/tmp/postman.deb"
  
  wget -qO "$temp_deb" "$url"
  sudo dpkg -i "$temp_deb" 
  sudo apt-get install -f -y
  rm "$temp_deb"
}

install_from_url "https://dl.pstmn.io/download/latest/linux64/postman-linux-x64.deb"

if command -v postman >/dev/null 2>&1; then
    gum_styled_text "Postman installed successfully."
else
    gum_styled_text "Failed to install Postman."
fi