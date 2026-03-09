#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

if is_apt_installed "evolution"; then
  echo "  ✓ Evolution is already installed."
else
  echo "  ➜ Installing Evolution email client..."
  sudo apt install evolution evolution-ews
fi

echo "Evolution setup complete!"
