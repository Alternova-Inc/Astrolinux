#!/bin/bash

gum_loader() {
    text=$1
    gum spin --title "$text" -- sleep 1
}

export -f gum_loader
