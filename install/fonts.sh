#!/bin/bash
set -e

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
sudo apt update
sudo apt install -y alacritty zellij

echo "Configuring Alacritty..."
mkdir -p ~/.config/alacritty

# Create a single, minimal alacritty.toml
cat <<EOF >~/.config/alacritty/alacritty.toml
[font]
size = 12.0

[font.normal]
# The patched name for Cascadia Code Nerd Font
family = "CaskaydiaCove Nerd Font"
style = "Regular"

[window]
padding = { x = 10, y = 10 }
dynamic_padding = true

[scrolling]
history = 10000
EOF

echo "Setting Alacritty as the default terminal..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

echo "Alacritty and Zellij setup complete!"

cat <<'EOF' >>~/.bashrc

# Auto-start Zellij in Alacritty
if [ "$TERM" = "alacritty" ] && [ -z "$ZELLIJ" ]; then
  exec zellij attach -c main
fi
EOF
