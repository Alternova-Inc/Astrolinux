gum_style() {
    gum style --foreground '#7671E5' --border-foreground '#F45BC1' --border rounded --align center --width 60 --margin "1 0" --padding "1 0" "$1"
}

gum_style “Installing applications...”

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Run desktop installers
for installer in ~/.local/share/astrolinux/install/desktop/auto/*.sh; do source $installer; done

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

# Logout to pickup changes
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt