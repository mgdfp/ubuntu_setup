#!/bin/bash
set -e
sudo -v

echo "Updating system..."
sudo apt update -y

# Loop through every script in the 'install' directory
for script in install/*.sh; do
  # Extract just the filename without the .sh extension (e.g., 'vlc')
  app_name=$(basename "$script" .sh)

  # Ask the user
  read -p "Install $app_name? (y/n) " -n 1 -r
  echo

  # If yes, run the script
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running $script..."
    bash "$script"
  fi
done

echo "Setup complete!"
