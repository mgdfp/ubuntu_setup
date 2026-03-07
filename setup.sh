#!/bin/bash
set -e

# Returns true (0) if the APT package is installed
is_apt_installed() {
  dpkg -s "$1" >/dev/null 2>&1
}
export -f is_apt_installed

# Returns true (0) if the Snap package is installed
is_snap_installed() {
  snap list "$1" >/dev/null 2>&1
}
export -f is_snap_installed

# Returns true (0) if the Flatpak ID is installed
is_flatpak_installed() {
  flatpak info "$1" >/dev/null 2>&1
}
export is_flatpak_installed

# Returns true (0) if the command/binary exists in the system path
is_command_installed() {
  command -v "$1" >/dev/null 2>&1
}
export is_command_installed

# Returns true (0) if the specific file/AppImage exists
is_file_installed() {
  [ -f "$1" ]
}
export is_file_installed

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ask for the administrator password upfront
sudo -v

# Keep sudo permissions alive in the background
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "--- Selecting Optional Applications ---"

# Array to hold the optional scripts you choose to run
selected_scripts=()

# 1. Ask the questions
if [ -d "$SCRIPT_DIR/optional_install" ]; then
  for script in "$SCRIPT_DIR/optional_install"/*.sh; do
    [ -e "$script" ] || continue

    app_name=$(basename "$script" .sh)

    read -p "Install $app_name? (y/n) " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      selected_scripts+=("$script")
    fi
  done
fi

# 2. Summary and Confirmation
echo ""
echo "--- The following will be installed: ---"
echo "Core Apps (Compulsory):"
for script in "$SCRIPT_DIR/install"/*.sh; do
  [ -e "$script" ] || continue
  echo "  - $(basename "$script" .sh)"
done

if [ ${#selected_scripts[@]} -gt 0 ]; then
  echo "Optional Apps (Selected):"
  for script in "${selected_scripts[@]}"; do
    echo "  - $(basename "$script" .sh)"
  done
fi
echo "-------------------------"

read -p "Proceed with installation? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Installation cancelled."
  exit 0
fi

# 3. Execution
echo "Updating and cleaning base system..."
sudo snap refresh
sudo systemctl daemon-reload
sudo apt update -qq
sudo apt full-upgrade -y -qq
sudo apt autopurge
sudo apt autoclean

# Run compulsory installs
echo "--- Running Core Installations ---"
for script in "$SCRIPT_DIR/install"/*.sh; do
  [ -e "$script" ] || continue
  app_name=$(basename "$script" .sh)
  echo ">>> Installing $app_name..."
  bash "$script"
done

# Run optional installs
if [ ${#selected_scripts[@]} -gt 0 ]; then
  echo "--- Running Optional Installations ---"
  for script in "${selected_scripts[@]}"; do
    app_name=$(basename "$script" .sh)
    echo ">>> Installing $app_name..."
    bash "$script"
  done
fi

bash "$SCRIPT_DIR"/dock.sh
bash "$SCRIPT_DIR"/dotfiles.sh

echo "All installations complete!"
