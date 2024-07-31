set -e

# ASCII Art
ascii_art='
  █████╗ ███████╗████████╗██████╗  ██████╗ ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
 ██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
 ███████║███████╗   ██║   ██████╔╝██║   ██║██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ 
 ██╔══██║╚════██║   ██║   ██╔══██╗██║   ██║██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ 
 ██║  ██║███████║   ██║   ██║  ██║╚██████╔╝███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
 ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝

AstroLinux is only for fresh installations of Ubuntu 24.04. Install it and enjoy ✨!
'

# Defines Alternova color palette in the gradient
colors=(
    '\e[38;2;249;172;127m' # #F9AC7F - Light Peach
    '\e[38;2;247;148;160m' # #F794A0 - Peach Pink
    '\e[38;2;245;119;177m' # #F577B1 - Pink Blush
    '\e[38;2;244;91;193m'  # #F45BC1 - Vibrant Pink
    '\e[38;2;194;82;202m'  # #C252CA - Purple Pink
    '\e[38;2;156;78;216m'  # #9C4ED8 - Violet
    '\e[38;2;118;113;229m' # #7671E5 - Lavender Blue
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

# Apply the gradient
apply_gradient "$ascii_art"
