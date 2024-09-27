#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh
source ~/.local/share/astrolinux/gum/gum-loader.sh

gum_styled_text "Installing drata agent..."

cd /tmp

ASSET="Drata-Agent-linux.deb"

LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/drata/agent-releases/releases/latest" | jq -r .tag_name)

DOWNLOAD_URL="https://github.com/drata/agent-releases/releases/download/$LATEST_RELEASE/$ASSET"

wget -qO "$ASSET" "$DOWNLOAD_URL"

sudo dpkg -i "./$ASSET"

rm "$ASSET"

cd -

# There is a problem in the manual executable and automatic execution of Drata Agent in Ubuntu version 24.04, for this the following solution is generated:
# issue https://github.com/drata/drata-agent/issues/20
# Make sure that the executable file has execution permissions.
EXECUTABLE_PATH="/opt/Drata Agent/drata-agent"
sudo chmod +x "$EXECUTABLE_PATH"

# Modify the .desktop file in /usr/share/applications to add --no-sandbox
modify_desktop_file() {
  local file_path="$1"
  if [ -f "$file_path" ]; then
    if grep -q -- "--no-sandbox" "$file_path"; then
      gum_styled_text "No need to modify $file_path, --no-sandbox already present."
    else
      sudo sed -i 's|Exec=.*|Exec="'"$EXECUTABLE_PATH"'" --no-sandbox %U|' "$file_path"
      gum_styled_text "Modified $file_path to include --no-sandbox."
    fi
  else
    gum_styled_text "The file $file_path was not found. Aborting modification process."
    exit 1
  fi
}

# Modify the .desktop files
modify_desktop_file "/usr/share/applications/drata-agent.desktop"
gtk-launch drata-agent
gum_loader "Starting Drata Agent..." 5

la linea siguiente esta funcionando pero al reiniciar el sistema del archivo se elimnina el --no-sandbox %U
modify_desktop_file "/home/$USER/.config/autostart/drata-agent.desktop"

# Verify that the executable file is executable and exists
if [ -x "$EXECUTABLE_PATH" ]; then
  gum_styled_text "Drata Agent installed successfully and is executable."
else
  gum_styled_text "Installation completed, but executable not found or lacks permissions."
fi
