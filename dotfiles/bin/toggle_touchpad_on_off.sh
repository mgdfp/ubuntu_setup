#!/bin/bash

current=$(gsettings get org.gnome.desktop.peripherals.touchpad send-events | tr -d "'")

if [[ $current == "enabled" ]]; then
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
    notify-send "Touchpad" "Disabled"
else
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
    notify-send "Touchpad" "Enabled"
fi

