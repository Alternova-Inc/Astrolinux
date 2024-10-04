#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh

gum_styled_text "Installing required packages..."

# Update the system
gum_styled_text "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install required packages
gum_styled_text "Installing Meson, Ninja, Git, Vala compiler, and dependencies..."
sudo apt install -y meson ninja-build git valac \
    libhandy-1-dev libgtk-4-dev libgirepository1.0-dev \
    libglib2.0-dev libjson-glib-dev libgee-0.8-dev \
    gsettings-desktop-schemas gsettings-desktop-schemas-dev \
    libgspell-1-dev libgtksourceview-4-dev \
    libgit2-glib-1.0-dev libpeas-dev libsecret-1-dev \
    libdazzle-1.0-dev libgpgme-dev gettext

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
gum_styled_text "Using temporary directory: $TEMP_DIR"

# Clone the repository into the temporary directory
gum_styled_text "Cloning the gitg repository..."
git clone https://gitlab.gnome.org/GNOME/gitg.git "$TEMP_DIR/gitg"

# Change to the repository directory
cd "$TEMP_DIR/gitg" || { gum_styled_text "Error changing directory"; exit 1; }

# Create the build directory with meson
gum_styled_text "Configuring the build with Meson..."
meson setup --prefix=/usr build

# Compile the project with Ninja
gum_styled_text "Building the project with Ninja..."
ninja -C build

# Install the project
gum_styled_text "Installing gitg..."
sudo ninja -C build install

# Clean up the temporary directory
gum_styled_text "Cleaning up..."
rm -rf "$TEMP_DIR"

gum_styled_text "Installation completed."



