#!/usr/bin/env bash

#################
### AUTOSTART ###
#################

# the bar
# waybar &
noctalia &
# browser
zen-twilight &
# notifications
dunst &
# devices automount
udiskie --tray --automount --notify &

change_wp
