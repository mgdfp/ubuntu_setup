#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

if is_apt_installed "google-chrome-stable"; then
  echo "  ✓ Google Chrome is already installed."
else
  echo "  ➜ Installing Google Chrome..."

  cd /tmp
  wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  # Using apt to install the local deb ensures dependencies are resolved
  sudo apt install -y -qq ./google-chrome-stable_current_amd64.deb

  rm google-chrome-stable_current_amd64.deb
  cd - >/dev/null
fi

echo "Setting Google Chrome as default browser..."
xdg-settings set default-web-browser google-chrome.desktop

echo "Google Chrome setup complete!"
