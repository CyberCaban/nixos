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
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "systemd.show_status=false"
  ];
  swapDevices = [{
      device = "/var/lib/swapfile";
      size = 16 * 1024;
  }];
  boot.plymouth = {
      enable = true;
      # themes:
      # catppuccin-[latte/macchiato/frappe/mocha] (latte is broken)
      # bgrt
      theme = "catppuccin-macchiato";
      themePackages = [ pkgs.catppuccin-plymouth ];
    };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    timeout = 5;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      timeoutStyle = "menu"; # options: menu, hidden
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
      ports = [ 9876 ];
      settings = {
        PermitRootLogin = "no";
      };
      openFirewall = true;
    };
    happ.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmitry = {
    isNormalUser = true;
    description = "dmitry";
    extraGroups = [ "networkmanager" "wheel" "network" "docker" ];
    packages = with pkgs; [];
  };

  # RICE START ```
  services.udisks2.enable = true;
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
  # services.journald.settings.Journal = ''
  #   SystemMaxUse=500M
  #   MaxFileSec=1week
  #   Compress=yes
  # '';
  programs = { 
    hyprland = { 
      enable = true;
      xwayland.enable = true;
    };
    niri = {
      enable = true;
    };
    steam = {
      enable = true;
      # Hyprland/niri sessions inherit an ambient CAP_SYS_NICE capability
      # from systemd-logind (compositor realtime scheduling). bwrap refuses
      # to run when the calling process holds any capability unless it's
      # setuid-root, so Steam's bwrap-based FHS wrapper fails with
      # "Unexpected capabilities but not setuid, old file caps config?".
      # Drop the ambient/inheritable caps once, then re-exec into the
      # normal FHS wrapper script.
      package = pkgs.steam.override {
        extraPreBwrapCmds = ''
          if [ -z "$STEAM_CAPS_DROPPED" ]; then
            export STEAM_CAPS_DROPPED=1
            exec ${pkgs.util-linux}/bin/setpriv --ambient-caps=-all --inh-caps=-all -- "$0" "$@"
          fi
        '';
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  # Auto gc
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 7d";
  # };

  # Store optimise
  nix.settings.auto-optimise-store = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
      ];
    };
  };
  # nix-ld for dynamic linked programs
  programs.nix-ld.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
      # extra packages for appimage format files
      ];
    };
  };
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
  # environment.variables = {
  #   XDG_DATA_DIRS = [
  #     "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  #     "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}"
  #     "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  #     "${pkgs.webkitgtk_4_1}/share"
  #   ];
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.tuned.enable = true;
  services.k3s = {
    enable = false;
    role = "server";
    extraFlags = toString [
      "--write-kubeconfig-mode=644"   # чтобы читать kubeconfig без root
      # "--disable=traefik"           # раскомментируйте, если поставите свой ingress
    ];
  };

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      25565 # Minecraft server
      24454
      6443 #k3s
    ];
    allowedUDPPorts = [
      25565 # Minecraft server
      24454
      8472 # flannel vxlan k8s
    ];
    trustedInterfaces = [ "cni0" "flannel.1" ];      # доверять трафику подов
  };
  # Or disable the firewall altogether.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";

}
