#!/bin/bash
set -e

sudo apt update

# Create font directory if it doesn't exist
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Temporary workspace
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Installing Cascadia Code Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip -q CascadiaMono.zip -d Cascadia
cp Cascadia/*.ttf "$FONT_DIR/"

echo "Installing iA Writer Mono..."
wget -q -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip -q iafonts.zip
# Using 'find' is safer than hardcoding the path
find iA-Fonts-master -name "*.ttf" -exec cp {} "$FONT_DIR/" \;

# Clean up and refresh
cd ~
rm -rf "$TEMP_DIR"
fc-cache -f

echo "Fonts installed successfully!"

echo "Installing Alacritty and Zellij..."
sudo apt install -y alacritty
sudo snap install zellij --classic

echo "Configuring Alacritty..."
mkdir -p ~/.config/alacritty

# Create a single, minimal alacritty.toml

cat <<EOF >~/.config/alacritty/alacritty.toml
[env]
TERM = "xterm-256color"

[shell]
program = "zellij"

[font]
normal = { family = "CaskaydiaMono Nerd Font", style = "Regular" }
bold = { family = "CaskaydiaMono Nerd Font", style = "Bold" }
italic = { family = "CaskaydiaMono Nerd Font", style = "Italic" }
size = 9

[window]
padding.x = 16
padding.y = 14
dynamic_padding = true
dimensions.columns = 121
dimensions.lines = 40
decorations = "full"
opacity = 0.98

[scrolling]
history = 10000

[colors]

[colors.primary]
background = '#1a1b26'
foreground = '#a9b1d6'

# Normal colors
[colors.normal]
black = '#32344a'
red = '#f7768e'
green = '#9ece6a'
yellow = '#e0af68'
blue = '#7aa2f7'
magenta = '#ad8ee6'
cyan = '#449dab'
white = '#787c99'

# Bright colors
[colors.bright]
black = '#444b6a'
red = '#ff7a93'
green = '#b9f27c'
yellow = '#ff9e64'
blue = '#7da6ff'
magenta = '#bb9af7'
cyan = '#0db9d7'
white = '#acb0d0'

[colors.selection]
background = '#7aa2f7'

EOF

echo "Setting Alacritty as the default terminal..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

echo "Alacritty and Zellij setup complete!"
