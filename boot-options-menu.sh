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
        "AstroLinux    Install AstroLinux tools for Ubuntu 22.04 by Alternova"
    )

    while true; do
        # Display the menu
        CHOICE=$(gum choose "${CHOICES[@]}" --cursor="👉 " --unselected-prefix="✨  " --selected-prefix="📌  " --height 15 --header "$(text_with_border "Select installation option:")")
        
        # Extract the base name of the choice
        OPTION_NAME=$(echo "$CHOICE" | awk '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
        
        echo "$OPTION_NAME"

        # Check the selected option
        case "$OPTION_NAME" in
        "astrolinux")
            # Show confirmation prompt
            gum confirm "$(text_with_border "Are you sure you want to proceed with AstroLinux installation?")" && gum_loader "Starting installation..." && install_astrolinux
            ;;
        *)
            echo "Invalid option."
            ;;
        esac
    done
}

export -f boot_options_menu
