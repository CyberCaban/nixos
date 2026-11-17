{
  description = "My nixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    vscode.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      rev = "531fc432036ef6f580688bc83502bacc7903c73f";
      submodules = true;
    };
    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, hyprland, vscode, ... }@inputs: 
    let
      system = "x86_64-linux";
    in
    {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./flakes/happ/happ-module.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.dmitry = ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
          };
        }
        (import ./hyprland-module.nix { inherit inputs; })
      ];
    };
  };
}
