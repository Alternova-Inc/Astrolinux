#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing DBeaver..."

sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo apt-get update
sudo apt-get install -y dbeaver-ce

gum_styled_text "DBeaver installed successfully."
