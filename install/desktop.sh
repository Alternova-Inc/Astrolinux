#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh
source ~/.local/share/astrolinux/install/desktop/optional/optional-apps-menu.sh

gum_styled_text "Installing applications..."

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Run desktop autoinstallers
for installer in ~/.local/share/astrolinux/install/desktop/auto/*.sh; do source "$installer"; done
boot_optional_apps_menu

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

# Logout to pickup changes
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt