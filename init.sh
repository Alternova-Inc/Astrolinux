# set -e

# We open the gnome terminal with specific measures so that the welcome is well appreciated
# gnome-terminal --geometry=90x24 -- bash -c "./boot.sh; exec bash"

set -e

# Function to check if gnome-terminal command is available
is_gnome_terminal_available() {
    command -v gnome-terminal >/dev/null 2>&1
}

# Check if gnome-terminal is available
if is_gnome_terminal_available; then
    echo "gnome-terminal is available. Opening a new GNOME Terminal window..."
    # We open the gnome terminal with specific measures so that the welcome is well appreciated
    # TODO: update './boot.sh' to 'wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/boot.sh | bash'
    gnome-terminal --geometry=90x24 -- bash -c "./boot.sh; exec bash"
else
    echo "gnome-terminal is not available. Executing script in the current terminal..."
    # TODO: update 'source ./boot.sh' to 'wget -qO- https://raw.githubusercontent.com/Alternova-Inc/Astrolinux/main/boot.sh | bash'
    source ./boot.sh
fi

clear