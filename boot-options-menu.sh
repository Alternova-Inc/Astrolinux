#!/bin/bash
set -e
source ~/.local/share/astrolinux/gum/gum-loader.sh
# Function to install AstroLinux
install_astrolinux() {
    gum_loader "Loading start menu"
    source ~/.local/share/astrolinux/install.sh
}

# Function to present menu and handle selection
boot_options_menu() {
    CHOICES=(
        "AstroLinux    Install AstroLinux tools for Ubuntu 24.04 by Alternova"
    )

    while true; do
        # Display the menu
        CHOICE=$(gum choose "${CHOICES[@]}" --height 5 --header "Select installation option:")

        # Extract the base name of the choice
        OPTION_NAME=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

        # Check the selected option
        case "$OPTION_NAME" in
        "astrolinux")
            # Show confirmation prompt
            gum confirm "$(text_with_border "Are you sure you want to proceed with AstroLinux installation?")" && gum_loader "Starting installation..." && install_astrolinux
            ;;
        esac
    done
}

export -f boot_options_menu
