# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    timeout = 0;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      timeoutStyle = "hidden"; # options: menu, hidden
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
      variant = "";
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
      openFirewall = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmitry = {
    isNormalUser = true;
    description = "dmitry";
    extraGroups = [ "networkmanager" "wheel" "network" ];
    packages = with pkgs; [];
  };

  # RICE START ```
  services.displayManager = {
    defaultSession = "hyprland";
    autoLogin = {
        enable = true; # set to false for different DE or WM
        user = "dmitry";
    };
    gdm = {
        enable = true;
        autoLogin.delay = 0;
        settings = { };
    };
  };
  services.gns3-server = {
    enable = true;

    auth = {
      enable = true;
      user = "gns3";
      passwordFile = "/var/lib/secrets/gns3_password";
    };

    ssl = {
      enable = true;
      certFile = "/var/lib/gns3/ssl/cert.pem";
      keyFile = "/var/lib/gns3/ssl/key.pem";
    };

    dynamips.enable = true;
    ubridge.enable = true;
    vpcs.enable = true;
  };
  programs = { 
    hyprland = { 
      enable = true;
      xwayland.enable = true;
    };
    steam.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  hardware.graphics.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Auto gc
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Store optimise
  nix.settings.auto-optimise-store = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  # nix-ld for dynamic linked programs
  programs.nix-ld.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # RICE STOP  ```

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs; inherit inputs; }; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";

}
