#!/bin/bash
set -e
 
source ~/.local/share/astrolinux/gum/gum-styles.sh
 
gum_styled_text "Installing Postman..."
 
install_postman() {
  local url="https://dl.pstmn.io/download/latest/linux64"
  local temp_file="/tmp/postman.tar.gz"
  local install_dir="/opt/Postman"
 
  wget -qO "$temp_file" "$url"
 
# Create the installation directory if it does not exist
  sudo mkdir -p "$install_dir"
 
# Extract the downloaded file to the installation directory
  sudo tar -xzf "$temp_file" -C "$install_dir" --strip-components=1
 
# Create a symbolic link to run Postman from the terminal
  sudo ln -s "$install_dir/Postman" /usr/bin/postman
 
  rm "$temp_file"
}
 
# Create a Linux launcher icon
create_desktop_entry() {
  local desktop_file="/usr/share/applications/Postman.desktop"
  local icon_path="/opt/Postman/app/resources/app/assets/icon.png"
 
  echo "[Desktop Entry]
Name=Postman
Exec=/usr/bin/postman
Icon=$icon_path
Type=Application
Categories=Development;" | sudo tee "$desktop_file" > /dev/null
 
# Make the file executable
  sudo chmod +x "$desktop_file"
}
 
install_postman
create_desktop_entry
 
if command -v postman >/dev/null 2>&1; then
  gum_styled_text "Postman installed successfully."
else
  gum_styled_text "Failed to install Postman."
fi