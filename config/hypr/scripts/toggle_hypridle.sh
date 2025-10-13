if pgrep hypridle; then
  pkill hypridle
  hyprctl notify 1 5000 "rgb(40a02b)" "Hypridle [OFF]"
  exit 1
else
  hyprctl notify 1 5000 "rgb(d20f39)" "Hypridle [ON] "
  hypridle &
  exit
fi
