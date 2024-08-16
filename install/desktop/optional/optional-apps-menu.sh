#!/bin/bash
set -e
source ~/.local/share/astrolinux/gum/gum-loader.sh
source ~/.local/share/astrolinux/gum/gum-styles.sh

#variable to stop loop
is_installing_optional_apps=true

install_optional_apps() {
	local selected_apps=$1

	if [[ -n "$selected_apps" ]]; then
		for app in $selected_apps; do
			source ~/.local/share/astrolinux/install/desktop/optional/app-"${app,,}".sh
			is_installing_optional_apps=false
		done
	fi
}

# Function to present menu and handle selection
boot_optional_apps_menu() {
	OPTIONAL_CHOICES=(
		"Github desktop    Desktop application for managing GitHub repositories."
		"Spotify    Music and podcast streaming platform."
		"Warp terminal    Next-generation terminal with modern features for developers."
	)

	while $is_installing_optional_apps; do
		# Display the menu
		CHOICES=$(gum choose "${OPTIONAL_CHOICES[@]}" --no-limit --cursor="👉 " --unselected-prefix="✨  " --selected-prefix="📌  " --height 15 --header "$(text_with_border "Select optional apps")")

		# Check if options were selected
		if [ -z "$CHOICES" ]; then
			gum confirm "$(text_with_border "You have not selected an option, do you want to close the optional applications installer?")" && gum_loader "Closing the optional applications installer..." && is_installing_optional_apps=false
			continue
		fi

		# Extract the base name of the choice
		OPTION_NAMES=$(echo "$CHOICES" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

		# Show confirmation prompt
		gum confirm "$(text_with_border "Are you sure you want to proceed with optional apps installation?")" && gum_loader "Starting installation..." && install_optional_apps "$OPTION_NAMES"
	done
}

export -f boot_optional_apps_menu
