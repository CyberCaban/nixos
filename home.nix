
{ config, pkgs, system, inputs, ... }:

let
  pkgsOther = import inputs.vscode {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  vscodeFhs = pkgsOther.vscode.fhs.override {
    # Nix-patched interpreters use their own ld.so.cache, so expose the C++
    # runtime explicitly for binary Python wheels and extension binaries.
    profile = ''
      export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib''${LD_LIBRARY_PATH:+:}$LD_LIBRARY_PATH"
    '';
    # Graphical sessions inherit CAP_SYS_NICE from the compositor. Drop it
    # before bubblewrap starts, otherwise bwrap refuses to run.
    extraPreBwrapCmds = ''
      if [ -z "$VSCODE_CAPS_DROPPED" ]; then
        export VSCODE_CAPS_DROPPED=1
        exec ${pkgs.util-linux}/bin/setpriv --ambient-caps=-all --inh-caps=-all -- "$0" "$@"
      fi
    '';
  };
  dotfiles = "${config.home.homeDirectory}/Documents/nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    btop = "btop";
    dunst = "dunst";
    hypr = "hypr";
    kitty = "kitty";
    nvim = "nvim";
    wallust = "wallust";
    waybar = "waybar";
    waytrogen = "waytrogen";
    wlogout = "wlogout";
    yazi = "yazi";
    tmux = "tmux";
  };
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

	home.username = "dmitry";
	home.homeDirectory = "/home/dmitry";
  home.stateVersion = "25.11";
	home.packages = with pkgs; [
	  inputs.zen-browser.packages."${system}".twilight
    vscodeFhs
    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
    pkgs.bibata-cursors
    fira-code
    psmisc
    bun
    nodejs
    # flameshot
    # google-chrome
    qbittorrent
    gh
    python313
    python313Packages.pip
    prismlauncher
    inetutils
	];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    # theme = {
    #   package = pkgs.flat-remix-gtk;
    #   name = "Flat-Remix-GTK-Grey-Darkest";
    # };
    cursorTheme= {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  home.file = {
      ".bashrc".source = create_symlink "${dotfiles}/.bashrc";
  };

  programs = {
    home-manager.enable = true;
    vesktop.enable = true;
    lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          activeBorderColor = [ "blue" "bold" ];
          inactiveBorderColor = [ "black" ];
          selectedLineBgColor = [ "default" ];
        };
      };
    };
    obsidian.enable = true;
    noctalia = {
      enable = true;
    };
  };

  xdg.configFile = builtins.mapAttrs 
    (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
      })
    configs;
}
