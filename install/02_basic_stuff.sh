#!/bin/bash
set -e

sudo apt update -qq >/dev/null 2>&1
# Install the GNOME Shell extension manager
sudo apt install -y -qq gnome-shell-extension-manager >/dev/null 2>&1
# to get all the codecs.
sudo apt install -y -qq ubuntu-restricted-extras >/dev/null 2>&1
sudo apt install -y -qq unzip p7zip unrar >/dev/null 2>&1
sudo apt install -y -qq git gitk meld curl wget >/dev/null 2>&1

echo "Installing modern terminal tools..."

# eza: Replaces 'ls' (adds icons and colors)
# zoxide: Replaces 'cd' (remembers your most used folders so you can type 'z docs' instead of 'cd ~/Documents')
# fzf: A fuzzy finder for searching files instantly
# ripgrep: A lightning-fast search tool (required by many Neovim plugins)
# bat: Replaces 'cat' (adds syntax highlighting to files printed in the terminal)

sudo apt install -y -qq eza zoxide fzf ripgrep bat >/dev/null 2>&1

echo "Terminal tools installed!"
