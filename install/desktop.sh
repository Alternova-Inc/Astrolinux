#!/bin/bash
set -e

source ~/.local/share/astrolinux/gum/gum-styles.sh
source ~/.local/share/astrolinux/install/desktop/optional/optional-apps-menu.sh

gum_styled_text "Starting setup. Select optional applications to install, then automatic installation will begin..."

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# optional app
boot_optional_apps_menu

# Run desktop autoinstallers
for installer in ~/.local/share/astrolinux/install/desktop/auto/*.sh; do source "$installer"; done

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

# Logout to pickup changes
gum style --foreground 212 --bold "The system will restart in 10 seconds..." && sleep 10 && systemctl reboot