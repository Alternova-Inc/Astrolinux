#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

TEMP_DIR="$HOME/temp_downloads"
TAR_URL="https://download.gnome.org/sources/gitg/44/gitg-44.tar.xz"
TAR_FILE="$TEMP_DIR/gitg-44.tar.xz"
DIR_NAME="gitg-44"

mkdir -p "$TEMP_DIR"

gum_styled_text "Installing required packages..."
sudo apt-get update
sudo apt-get -y install meson ninja-build
sudo apt update

gum_styled_text "Downloading gitg-44.tar.xz to $TEMP_DIR..."
curl -L $TAR_URL -o "$TAR_FILE"

gum_styled_text "Extracting gitg-44.tar.xz..."
tar -Jxf "$TAR_FILE" -C "$TEMP_DIR"

cd "$TEMP_DIR/$DIR_NAME"

gum_styled_text "Configuring the build with meson..."
meson setup build

gum_styled_text "Building with ninja..."
ninja -C build

gum_styled_text "Installing gitg..."
sudo ninja -C build install

gum_styled_text "Cleaning up temporary files..."
rm -rf "${TEMP_DIR:?}/${DIR_NAME:?}" "${TAR_FILE:?}"

gum_styled_text "Gitg installed successfully."
