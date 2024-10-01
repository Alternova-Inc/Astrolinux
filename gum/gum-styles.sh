#!/bin/bash
source ~/.local/share/astrolinux/constants/colors-palette.sh

text_with_border() {
    text=$1
    gum style --foreground "$HEX_LAVENDER_BLUE" --border-foreground "$HEX_VIBRANT_PINK" --border rounded --align center --width 60 --margin "1 0" --padding "1 0" "$text"
}

gum_styled_text() {
    text=$1
    gum style --foreground "$HEX_LAVENDER_BLUE" --width 60 --margin "0 0 2 0" "$text"
}

export -f text_with_border
export -f gum_styled_text
