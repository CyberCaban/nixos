{ pkgs, inputs, ... }: with pkgs; [
  wget
  sudo
  nftables
  # devel
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  neovim
  gcc
  rustup
  # find - fd
  fd
  # WM things
  # Default terminal
  alacritty
  # file manager
  nautilus
  # dmenu
  wofi
  # brightness control
  brightnessctl
  # clipboard daemon
  wl-clipboard
  cliphist
  waybar
  hyprpolkitagent
  # notification daemon
  dunst
  libnotify
  # resource monitor
  btop
  #video playback
  mpv
  totem
  # image viewer
  loupe
  # logout menu
  wlogout

  #network manager 
  networkmanagerapplet
  # lockscreen
  hyprlock
  hypridle
  # wallpapers
  inputs.swww.packages.${pkgs.system}.swww
]
