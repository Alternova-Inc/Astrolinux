set -e

# Desktop software and tweaks will only be installed if we're running Gnome
RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

# Check the distribution name and version and abort if incompatible
source ~/.local/share/astrolinux/check-version.sh

if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0

	echo "Starting Desktop tools installation..."
    
    # Install Desktop tools
    source ~/.local/share/astrolinux/install/desktop.sh
else
	echo "Unable to install because the terminal is not GNOME".
fi