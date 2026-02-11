{ pkgs, inputs, ... }: with pkgs; [
  # Graphics/Display
  libGL
  libglvnd
  mesa
  vulkan-loader

  # X11
  libx11
  libxrandr
  libxinerama
  libxcursor
  libxi
  libxext

  # Wayland
  wayland
  wayland-scanner
  libxkbcommon

  # Audio
  alsa-lib
  pipewire
  libpulseaudio

  file
  git
  wget
  sudo
  # archivers
  gnutar
  p7zip
  zip
  unzip
  # archiver gui
  peazip
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
  waytrogen
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

  # gdb
  gdbHostCpuOnly
  gdbgui

  google-chrome

  # watch tools
  inotify-tools
  # uml
  plantuml

  # remote desktop
  rustdesk-flutter
]
