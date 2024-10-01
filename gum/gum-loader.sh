#!/bin/bash

gum_loader() {
    local text=$1
    local delay=${2:-1}
    gum spin --title "$text" -- sleep "$delay"
}

export -f gum_loader
