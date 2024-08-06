#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing drata agent..."

cd /tmp

ASSET="Drata-Agent-linux.deb"

LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/drata/agent-releases/releases/latest" | jq -r .tag_name)

DOWNLOAD_URL="https://github.com/drata/agent-releases/releases/download/$LATEST_RELEASE/$ASSET"

wget -qO $ASSET "$DOWNLOAD_URL"

sudo dpkg -i ./$ASSET
sudo apt-get install -f

rm $ASSET

cd -
