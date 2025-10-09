{
  description = "My nixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    swww.url = "github:LGFae/swww";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, hyprland, ... }@inputs: 
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
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.dmitry = ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
          };
        }
      ];
    };
  };
}
