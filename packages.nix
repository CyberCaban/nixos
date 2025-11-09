{ pkgs, inputs, ... }: with pkgs; [
  file
  git
  wget
  sudo
  # archivers
  gnutar
  p7zip
  zip
  unzip
  # network
  nftables
  # devel
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  neovim
  gcc
  gcc.cc.lib
  rustup
  tmux
  lazydocker
  yazi
  # find - fd
  fd
  # WM things
  # Default terminal
  alacritty
  kitty
  # file manager
  nautilus xfce.thunar
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
  waytrogen mpvpaper
  # colorschemes
  wallust
  # wayland zoom woomer
  # disk usage analyzer
  dust
  # devices automount
  udiskie
  # monitor selection
  nwg-displays
  # connect media devices
  mtpfs jmtpfs gvfs libmtp

  vimPlugins.nvim-dbee
  # wine
  wineWowPackages.stable
  # internalisation for C# apps
  icu
  # global java 21
  temurin-bin

  google-chrome
]
