#!/bin/bash
set -e
source ~/.local/share/astrolinux/constants/colors-palette.sh

# ASCII Art
ascii_art='
  █████╗ ███████╗████████╗██████╗  ██████╗ ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
 ██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
 ███████║███████╗   ██║   ██████╔╝██║   ██║██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ 
 ██╔══██║╚════██║   ██║   ██╔══██╗██║   ██║██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ 
 ██║  ██║███████║   ██║   ██║  ██║╚██████╔╝███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
 ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝

AstroLinux is only for fresh installations of Ubuntu 22.04 (Based on Omakub). 
Install it and enjoy ✨!
'

# Defines Alternova color palette in the gradient
colors=(
    "$ANSI_LIGHT_PEACH"
    "$ANSI_PEACH_PINK"
    "$ANSI_PINK_BLUSH"
    "$ANSI_VIBRANT_PINK"
    "$ANSI_PURPLE_PINK"
    "$ANSI_VIOLET"
    "$ANSI_LAVENDER_BLUE"
)

# Get the number of colors in the palette
num_colors=${#colors[@]}

# Function for applying gradient to ASCII artwork
apply_gradient() {
    local art="$1"
    local color_index=0

    # Read the art line by line
    while IFS= read -r line; do
        # Apply the color from the palette to each line
        echo -e "${colors[$color_index]}$line\e[0m"
        color_index=$(((color_index + 1) % num_colors))
    done <<<"$art"
}

welcome_to_astrolinux() {
    apply_gradient "$ascii_art"
}

export -f welcome_to_astrolinux
