
{ config, pkgs, system, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/Documents/nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    btop = "btop";
    dunst = "dunst";
    flameshot = "flameshot";
    hypr = "hypr";
    kitty = "kitty";
    nvim = "nvim";
    wallust = "wallust";
    waybar = "waybar";
    waytrogen = "waytrogen";
    wlogout = "wlogout";
    yazi = "yazi";
  };
in
{
  imports = [

  ];

	home.username = "dmitry";
	home.homeDirectory = "/home/dmitry";
  home.stateVersion = "25.05";
	home.packages = with pkgs; [
	  inputs.zen-browser.packages."${system}".twilight
    pkgs.bibata-cursors
    pkgs.flat-remix-gtk
    fira-code
    psmisc
    pavucontrol
    telegram-desktop
    bun
    nodejs
    # flameshot
    (flameshot.override { enableWlrSupport = true; })
    # google-chrome
    qbittorrent
    gh
    python313
    python313Packages.pip
    prismlauncher
    inetutils
    jetbrains.idea-community
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        (nix-search-tv.overrideAttrs {
          env.GOEXPERIMENT = "jsonv2";
        })
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
	];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
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
  };

  xdg.configFile = builtins.mapAttrs 
    (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
      })
    configs;
}
