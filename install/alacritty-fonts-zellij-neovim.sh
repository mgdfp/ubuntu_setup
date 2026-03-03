#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
cd "$HOME"
rm -rf "$TEMP_DIR"

#refresh the font cache
fc-cache -f

echo "Fonts installed successfully!"

echo "Installing Alacritty and Zellij..."
sudo apt install -y alacritty
sudo snap install zellij --classic

echo "Configuring Alacritty..."
mkdir -p ~/.config/alacritty

cp "$SCRIPT_DIR/../configs/alacritty.toml" ~/.config/alacritty/alacritty.toml

echo "Setting Alacritty as the default terminal..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

echo "Alacritty and Zellij setup complete!"

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies
sudo apt install -y libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip

# 2. Install Neovim (AppImage) - FIXED URL AND FILENAME
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

# 4. Setup LazyVim Starter
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

# 5. Apply custom languages config
mkdir -p "$HOME/.config/nvim/lua/plugins"

cp "$SCRIPT_DIR/../configs/languages.lua" ~/.config/nvim/lua/plugins/languages.lua

# 6. Apply custom options config - FIXED DESTINATION PATH
mkdir -p "$HOME/.config/nvim/lua/config"
cp "$SCRIPT_DIR/../configs/options.lua" ~/.config/nvim/lua/config/options.lua

echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."
