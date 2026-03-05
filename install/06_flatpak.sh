#!/bin/bash
set -e

sudo add-apt-repository universe -y
sudo apt update -qq >/dev/null 
sudo apt install -y -qq flatpak gnome-software-plugin-flatpak >/dev/null 
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
