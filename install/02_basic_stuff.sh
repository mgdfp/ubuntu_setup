#!/bin/bash
set -e

sudo apt update
# Install the GNOME Shell extension manager
sudo apt install -y gnome-shell-extension-manager
# to get all the codecs.
sudo apt install -y ubuntu-restricted-extras
sudo apt install -y unzip p7zip unrar
sudo apt install -y git gitk meld curl wget

echo "Installing modern terminal tools..."

# eza: Replaces 'ls' (adds icons and colors)
# zoxide: Replaces 'cd' (remembers your most used folders so you can type 'z docs' instead of 'cd ~/Documents')
# fzf: A fuzzy finder for searching files instantly
# ripgrep: A lightning-fast search tool (required by many Neovim plugins)
# bat: Replaces 'cat' (adds syntax highlighting to files printed in the terminal)

sudo apt install -y eza zoxide fzf ripgrep bat

echo "Terminal tools installed!"
