#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing Google Chrome..."

install_from_url() {
  local url="$1"
  local temp_deb="/tmp/temp_package.deb"
  
  wget -qO "$temp_deb" "$url"
  sudo dpkg -i "$temp_deb"
  sudo apt-get install -f -y
  rm "$temp_deb"
}

install_from_url "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

if command -v google-chrome >/dev/null 2>&1; then
    gum_styled_text "Google Chrome installed successfully."
else
    gum_styled_text "Failed to install Google Chrome."
fi
