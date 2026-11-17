{ pkgs, inputs, ... }: with pkgs; [
  # Graphics/Display
  libGL
  libglvnd
  librsvg
  mesa
  vulkan-loader
  cmake

  kubectl
  kubernetes-helm
  k9s # kuber tui

  # X11
  libx11
  libxrandr
  libxinerama
  libxcursor
  libxi
  libxext
  libxrender
  libxtst

  # Wayland
  wayland
  wayland-scanner
  libxkbcommon

  # Audio
  alsa-lib
  pipewire
  libpulseaudio

  # gtk
  webkitgtk_4_1
  wrapGAppsHook4

  xdg-utils
  pkg-config

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
  inputs.codex-cli-nix.packages.${pkgs.system}.default
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  neovim
  ripgrep
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
  nautilus thunar
  # pdf viewer
  zathura
  # resource monitor
  btop
  #video playback
  mpv
  totem
  # image viewer
  loupe
  # brightness control
  brightnessctl

  # android screencasting
  scrcpy
  # notifications
  libnotify
  # video wallpapers
  mpvpaper
  # colorschemes
  wallust
  # disk usage analyzer
  dust
  # devices automount
  udiskie
  # monitor selection
  nwg-displays
  ncdu
  # work vpn
  openvpn3
  stunnel

  vimPlugins.nvim-dbee
  # wine
  # wineWowPackages.stable
  # internalisation for C# apps
  icu
  # global java 21
  temurin-bin

  # gdb
  gdbHostCpuOnly
  gdbgui

  google-chrome

  # office
  libreoffice-qt

  # remote desktop
  rustdesk-flutter

  niri
]
