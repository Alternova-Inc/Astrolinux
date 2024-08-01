#!/bin/bash
set -e

# Function to install gum
install_gum() {
    echo "Installing gum..."
    cd /tmp

    # Check if curl is installed, and install it if it's not
    if ! command -v curl &> /dev/null; then
        echo "Installing curl..."
        sudo apt-get update
        sudo apt-get install -y curl
    fi
    
    # Get the latest version number from GitHub releases
    GUM_VERSION=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | jq -r .tag_name) 
    
    # Remove the 'v' prefix from the version number, if present
    GUM_VERSION=${GUM_VERSION#v}

    wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"
    sudo apt-get install -y ./gum.deb
    rm gum.deb
    cd -
    echo "gum installed successfully."
}

# Check if gum is installed
if ! command -v gum &>/dev/null; then
    install_gum
fi

gum_style() {
    gum style --foreground '#7671E5' --border-foreground '#F45BC1' --border rounded --align center --width 60 --margin "1 0" --padding "1 0" "$1"
}

# Function to install AstroLinux
install_astrolinux() {
    gum_style "Updating packages..."
    sudo apt-get update >/dev/null
    sudo apt-get install -y git >/dev/null
    gum spin --title "Loading AstroLinux..." -- sleep 1
    gum_style "Cloning AstroLinux..."
    rm -rf ~/.local/share/astrolinux
    cp -r /home/$USER/Compartida/astrolinux ~/.local/share/astrolinux
    gum_style "Cloning complete."
    gum_style "Installation starting..."
    source ~/.local/share/astrolinux/install.sh
}

# Function to install Omakub
install_omakub() {
    gum spin --title "Loading Omakub..." -- sleep 1
    wget -qO- https://omakub.org/install | bash
}

# Function to present menu and handle selection
present_menu() {
    CHOICES=(
        "AstroLinux    Install AstroLinux tools for Ubuntu 24.04 by Alternova"
        "Omakub        An Omakase Developer Setup for Ubuntu 24.04 by DHH"
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
            gum confirm "$(gum_style "Are you sure you want to proceed with AstroLinux installation?")" && gum spin --title "Starting installation..." -- sleep 1.5 && install_astrolinux
            ;;
        "omakub")
            # Show confirmation prompt
            gum confirm "$(gum_style "Are you sure you want to proceed with Omakub installation?")" && gum spin --title "Starting installation..." -- sleep 1.5 && install_omakub
            ;;
        esac
    done
}

# Welcome
wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/welcomeToAstroLinux.sh | bash

echo -e "\nBegin installation (or abort with ctrl+c)..."

# Present menu and handle selection
present_menu