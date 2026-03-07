#!/bin/bash
set -e

install_vscode_apt() {
  echo "Installing VS Code (APT version)..."
  sudo apt update
  sudo apt install -y wget gpg apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  sudo apt update
  sudo apt install -y code
  rm -f packages.microsoft.gpg
}

if snap list code &>/dev/null; then
  echo "VS Code is currently installed as a snap package."
  read -p "Have you enabled Settings Sync in VS Code to back up your data? (y/n): " sync_check

  if [[ "$sync_check" =~ ^[Yy]$ ]]; then
    echo "Removing Snap version..."
    sudo snap remove code
    install_vscode_apt
    echo "Done. Open VS Code and turn on Settings Sync to restore your data."
  else
    echo "Please open VS Code, enable Settings Sync, and run this script again."
  fi
else
  install_vscode_apt
fi
