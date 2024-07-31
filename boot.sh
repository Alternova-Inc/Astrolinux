#!/bin/bash
set -e

# Function to install gum
install_gum() {
    echo "Installing gum..."
    # Download the latest release of gum from GitHub
    GUM_VERSION=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | jq -r .tag_name)
    curl -LO "https://github.com/charmbracelet/gum/releases/download/${GUM_VERSION}/gum_${GUM_VERSION}_linux_amd64.tar.gz"
    tar -xzf "gum_${GUM_VERSION}_linux_amd64.tar.gz"
    chmod +x gum
    sudo mv gum /usr/local/bin/
    rm "gum_${GUM_VERSION}_linux_amd64.tar.gz"
    echo "gum installed successfully."
}

# Check if gum is installed
if ! command -v gum &>/dev/null; then
    install_gum
fi

gum_style() {
    gum style --foreground '#7671E5' --border-foreground '#F45BC1' --border double --align center --width 60 --margin "1 0" --padding "1 0" "$1"
}

# Function to install Astrolinux
install_astrolinux() {
    sudo apt-get update >/dev/null
    sudo apt-get install -y git >/dev/null
    gum spin --title "Loading AstroLinux..." -- sleep 1
    gum_style "Cloning Astrolinux..."
    rm -rf ~/.local/share/astrolinux
    cp -r /home/edfer/Compartidos/astrolinux ~/.local/share/astrolinux
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
        "Astrolinux    Install Astrolinux tools for Ubuntu 24.04 by Alternova"
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
            gum confirm "$(gum_style "Are you sure you want to proceed with Astrolinux installation?")" && gum spin --title "Starting installation..." -- sleep 1.5 && install_astrolinux
            ;;
        "omakub")
            # Show confirmation prompt
            gum confirm "$(gum_style "Are you sure you want to proceed with Omakub installation?")" && gum spin --title "Starting installation..." -- sleep 1.5 && install_omakub
            ;;
        esac
    done
}

# Welcome
source ./welcomeToAstroLinux.sh
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Present menu and handle selection
present_menu
