
{ config, pkgs, system, inputs, ... }:

{
  imports = [
    ./pywal
    ./wallust
  ];

	home.username = "dmitry";
	home.homeDirectory = "/home/dmitry";
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
    beamMinimal27Packages.elixir
    yazi
    # flameshot
    (flameshot.override { enableWlrSupport = true; })
    # google-chrome
    qbittorrent
    wallust
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

  programs = {
    home-manager.enable = true;
    vesktop.enable = true;
    git = {
      enable = true;
      userName = "Dmitry";
      userEmail = "andrewgamer63@gmail.com";
    };
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
  home.stateVersion = "25.05";
}
