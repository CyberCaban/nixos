#!/usr/bin/env bash

# the bar
waybar &
# wallpaper daemon
swww-daemon &
# browser
zen-twilight &
#network manager
nm-applet --indicator &
# notifications
dunst &
# screenshot
flameshot &
# screen lock on timeout
hypridle &
#clipboard
wl-paste --type text --watch cliphist store &  # store text clipboard
wl-paste --type image --watch cliphist store & # store image clipboard

change_wp
