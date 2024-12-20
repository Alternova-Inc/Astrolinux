#!/bin/bash
set -e

stiled_text() {
    local text="$1"
    local color_code='\e[38;2;118;113;229m'
    echo -e "${color_code}${text}\e[0m"
}

update_packages() {
    stiled_text "Updating packages..."
    sudo apt-get update >/dev/null
    stiled_text "Packages updated successfully."
}

install_git() {
    if ! command -v git &>/dev/null; then
        stiled_text "Installing git..."
        sudo apt-get install -y git >/dev/null
        stiled_text "git installed successfully."
    fi
}

install_curl() {
    if ! command -v curl &>/dev/null; then
        stiled_text "Installing curl..."
        sudo apt-get install -y curl
        stiled_text "curl installed successfully."
    fi
}

install_jq() {
    if ! command -v jq &>/dev/null; then
        stiled_text "Installing jq..."
        sudo apt-get install -y jq >/dev/null
        stiled_text "jq installed successfully."
    fi
}

# Function to install gum
install_gum() {
    if ! command -v gum &>/dev/null; then
        stiled_text "Installing gum..."
        cd /tmp
        ASSET="gum.deb"

        LATEST_RELEASE=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | jq -r .tag_name)

        # Remove the 'v' prefix from the latest release, if present
        LATEST_RELEASE=${LATEST_RELEASE#v}

        wget -qO $ASSET "https://github.com/charmbracelet/gum/releases/download/v${LATEST_RELEASE}/gum_${LATEST_RELEASE}_amd64.deb"
        sudo apt-get install -y ./$ASSET
        rm $ASSET
        cd -
        stiled_text "gum installed successfully."
    fi
}

prepare_environment() {
    stiled_text "Preparing enviroment to run AstroLinux installation..."
    update_packages
    install_git
    install_curl
    install_jq     
    install_gum
}

get_astrolinux_repo() {
    stiled_text "Cloning AstroLinux..."
    
    # Define the target directory
    local target_dir="$HOME/.local/share/astrolinux"
    
    # Remove the existing directory if it exists
    [ -d "$target_dir" ] && rm -rf "$target_dir"

    # Clone the repository from GitHub
    if git clone https://github.com/Alternova-Inc/Astrolinux.git "$target_dir"; then
        stiled_text "Cloning complete."
    else
        stiled_text "Error: Failed to clone the repository."
    fi
}


run_astrolinux_installation() {
    # load gum styles and functions to use in AstroLinux
    source ~/.local/share/astrolinux/gum/gum-styles.sh
    source ~/.local/share/astrolinux/gum/gum-loader.sh
    source ~/.local/share/astrolinux/welcome-to-astro-linux.sh
    source ~/.local/share/astrolinux/boot-options-menu.sh
    gum_styled_text "Enviroment ready to install AstroLinux"
    gum_loader "Loading AstroLinux..."
    welcome_to_astrolinux
    gum_styled_text "Begin installation (or abort with ctrl+c)"
    boot_options_menu
}

prepare_environment
get_astrolinux_repo
run_astrolinux_installation
