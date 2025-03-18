#!/bin/bash

# Function to display ASCII art
function copying_files_ascii() {
    echo -e "\033[32m"
    cat << "EOF"
    [====================] Copying Files...                 
                       _             
  ___ ___  _ __  _   _(_)_ __   __ _ 
 / __/ _ \|  _ \| | | | |  _ \ / _  |
| (_| (_) | |_) | |_| | | | | | (_| |
 \___\___/|  __/ \__  |_|_| |_|\__  |
          | |     __/ |         __/ |
          |_|    |___/         |___/ 
EOF
    echo -e "\033[0m"
}

# Function to display package installation ASCII art
function installing_packages_ascii() {
    echo -e "\033[32m"
    cat << "EOF"
    [====================] Installing Packages...
 _           _        _ _ _             
(_)         | |      | | (_)            
 _ _ __  ___| |_ __ _| | |_ _ __   __ _ 
| |  _ \/ __| __/ _  | | | |  _ \ / _  |
| | | | \__ \ || (_| | | | | | | | (_| |
|_|_| |_|___/\__\__,_|_|_|_|_| |_|\__, |
                                   __/ |
                                  |___/ 
EOF
    echo -e "\033[0m"
}

function welcome_ascii() {
    echo -e "\033[32m"
    cat << "EOF"
    [====================] Welcome!
EOF
    echo -e "\033[0m"
}

# Ensure script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo!"
    exit 1
fi

# Define repository details
REPO_URL="https://github.com/Sumichaaan19/ubepandan.git"
DEST_DIR="$HOME/ubepandan"

# Clone or update repository
welcome_ascii
echo "Checking repository..."
if [ ! -d "$DEST_DIR" ]; then
    git clone "$REPO_URL" "$DEST_DIR"
else
    echo "Repository exists, pulling latest changes..."
    git -C "$DEST_DIR" pull
fi

# Ensure the .config directory exists
mkdir -p "$HOME/.config"

# Prompt for confirmation
echo "WARNING: This will replace existing configuration files in ~/.config/ and ~/.bashrc"
read -p "Are you sure you want to proceed? (y/n): " choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
if [[ "$choice" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

# Copy files with proper replacement
copying_files_ascii
echo "Replacing configuration files..."
for dir in cava waybar hypr hyde kitty neofetch nwg-look gtk-3.0 gtk-4.0 ranger rofi swaync wal wall wlogout xsettingsd btop; do
    sudo rm -rf "$HOME/.config/$dir"
    sudo cp -rf "$DEST_DIR/.config/$dir" "$HOME/.config/"
    echo "Copied $dir to ~/.config/$dir"
done

# Replace .bashrc and .gtkrc-2.0
echo "Replacing .bashrc and .gtkrc-2.0..."
sudo cp -f "$DEST_DIR/.bashrc" "$HOME/.bashrc"
sudo cp -f "$DEST_DIR/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
echo "Configuration files updated."

# Install packages
echo "Checking for yay..."
if ! command -v yay &> /dev/null; then
    echo "Error: yay is not installed. Please install it manually and rerun this script."
    exit 1
fi

installing_packages_ascii
echo "Installing necessary dependencies using yay..."
sudo yay -Syu --noconfirm

sudo yay -S --noconfirm swaync sway waybar rofi fastfetch ranger kitty cava wlogout swww hypridle thunar hyprlock blueman hyprshot python-pillow flat-remix-gtk flat-remix nwg-look cmatrix cbonsai tty-clock btop otf-aurulent-nerd thunar tumbler ffmpegthumbnailer libheif

echo "Installation complete! Please restart your terminal for .bashrc changes to take effect."
