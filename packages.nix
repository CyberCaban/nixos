{ pkgs, inputs, ... }: with pkgs; [
  git
  wget
  sudo
  # archivers
  gnutar
  p7zip
  zip
  # network
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
  kitty
  # file manager
  nautilus
  # pdf viewer
  zathura
  # md viewer
  glow
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
  waytrogen
]
