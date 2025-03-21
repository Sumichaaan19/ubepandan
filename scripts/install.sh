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

# Function to display the welcome ASCII art
function welcome_ascii() {
    echo -e "\033[32m"
    cat << "EOF"
 _    _      _                         
| |  | |    | |                         
| |  | | ___| | ___ ___  _ __ ___   ___ 
| |/\| |/ _ \ |/ __/ _ \|  _   _ \ / _ \
\  /\  /  __/ | (_| (_) | | | | | |  __/
 \/  \/ \___|_|\___\___/|_| |_| |_|\___|
EOF
    echo -e "\033[0m"
}
# Define your GitHub repository URL
REPO_URL="https://github.com/Sumichaaan19/ubepandan.git"
DEST_DIR="$HOME/ubepandan"

# Clone the repository if it doesn't exist
welcome_ascii
echo "Cloning ubepandan repository..."
if [ ! -d "$DEST_DIR" ]; then
    git clone "$REPO_URL" "$DEST_DIR"
else
    echo "ubepandan repository already exists, pulling latest changes..."
    cd "$DEST_DIR"
    git pull
fi

# Ensure the .config directory exists
mkdir -p "$HOME/.config"

# Prompt the user for confirmation
echo "WARNING: This will replace existing configuration files in ~/.config/ and ~/.bashrc"
read -p "Are you sure you want to proceed? (y/n): " choice

# Convert input to lowercase
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

if [[ "$choice" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

# Copy the dotfiles to ~/.config/
copying_files_ascii
echo "Copying dotfiles to ~/.config/"
cp -rf "$DEST_DIR/.config/cava" "$HOME/.config/cava" && echo "Copied cava to ~/.config/cava"
cp -rf "$DEST_DIR/.config/waybar" "$HOME/.config/waybar" && echo "Copied waybar to ~/.config/waybar"
cp -rf "$DEST_DIR/.config/hypr" "$HOME/.config/hypr" && echo "Copied hypr to ~/.config/hypr"
cp -rf "$DEST_DIR/.config/hyde" "$HOME/.config/hyde" && echo "Copied hyde to ~/.config/hyde"
cp -rf "$DEST_DIR/.config/kitty" "$HOME/.config/kitty" && echo "Copied kitty to ~/.config/kitty"
cp -rf "$DEST_DIR/.config/neofetch" "$HOME/.config/neofetch" && echo "Copied neofetch to ~/.config/neofetch"
cp -rf "$DEST_DIR/.config/nwg-look" "$HOME/.config/nwg-look" && echo "Copied nwg-look to ~/.config/nwg-look"
cp -rf "$DEST_DIR/.config/gtk-3.0" "$HOME/.config/gtk-3.0" && echo "Copied gtk-3.0 to ~/.config/gtk-3.0"
cp -rf "$DEST_DIR/.config/gtk-4.0" "$HOME/.config/gtk-4.0" && echo "Copied gtk-4.0 to ~/.config/gtk-4.0"
cp -rf "$DEST_DIR/.config/ranger" "$HOME/.config/ranger" && echo "Copied ranger to ~/.config/ranger"
cp -rf "$DEST_DIR/.config/rofi" "$HOME/.config/rofi" && echo "Copied rofi to ~/.config/rofi"
cp -rf "$DEST_DIR/.config/swaync" "$HOME/.config/swaync" && echo "Copied swaync to ~/.config/swaync"
cp -rf "$DEST_DIR/.config/wal" "$HOME/.config/wal" && echo "Copied wal to ~/.config/wal"
cp -rf "$DEST_DIR/.config/wall" "$HOME/.config/wall" && echo "Copied wall to ~/.config/wall"
cp -rf "$DEST_DIR/.config/wlogout" "$HOME/.config/wlogout" && echo "Copied wlogout to ~/.config/wlogout"
cp -rf "$DEST_DIR/.config/xsettingsd" "$HOME/.config/xsettingsd" && echo "Copied xsettingsd to ~/.config/xsettingsd"
cp -rf "$DEST_DIR/.config/btop" "$HOME/.config/btop" && echo "Copied btop to ~/.config/btop"


# Copy .bashrc and replace the existing one
echo "Replacing .bashrc..."
cp -f "$DEST_DIR/.bashrc" "$HOME/.bashrc"
echo "Copied .bashrc to home directory."


# Copy ..gtkrc-2.0 and replace the existing one
echo "Replacing .bashrc..."
cp -f "$DEST_DIR/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
echo "Copied .gtkrc-2.0 to home directory."

# Optional: Install necessary dependencies using yay
installing_packages_ascii
echo "Installing necessary dependencies using yay..."
yay -Syu --noconfirm  # Update system first

# Install packages using yay
yay -S --noconfirm swaync sway waybar rofi fastfetch ranger kitty cava wlogout swww hypridle thunar hyprlock blueman hyprshot python-pillow flat-remix-gtk flat-remix nwg-look cmatrix cbonsai tty-clock btop

# Install the basic Nerd Font (e.g., FiraCode) from AUR
yay -S --noconfirm otf-aurulent-nerd

# For thunar plugins
yay -S --noconfirm thunar tumbler ffmpegthumbnailer libheif

# Done
echo "Installation complete! Please restart your terminal for .bashrc changes to take effect."