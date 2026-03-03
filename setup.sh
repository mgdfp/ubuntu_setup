#!/bin/bash
set -e

# Ask for the administrator password upfront
sudo -v

# Keep sudo permissions alive in the background
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "--- Selecting Applications ---"

# Array to hold the scripts you choose to run
selected_scripts=()

# 1. Ask the questions
for script in install/*.sh; do
  # Skip if no .sh files exist
  [ -e "$script" ] || continue

  app_name=$(basename "$script" .sh)

  read -p "Install $app_name? (y/n) " -n 1 -r
  echo

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    selected_scripts+=("$script")
  fi
done

# Exit if nothing was selected
if [ ${#selected_scripts[@]} -eq 0 ]; then
  echo "Nothing selected for installation. Exiting."
  exit 0
fi

# 2. Summary and Confirmation
echo ""
echo "--- Ready to install: ---"
for script in "${selected_scripts[@]}"; do
  echo "- $(basename "$script" .sh)"
done
echo "-------------------------"

read -p "Proceed with installation? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Installation cancelled."
  exit 0
fi

# 3. Execution
echo ""
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

for script in "${selected_scripts[@]}"; do
  app_name=$(basename "$script" .sh)
  echo ">>> Installing $app_name..."
  bash "$script"
done

echo "All installations complete!"
