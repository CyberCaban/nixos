{ inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = inputs.hyprland.packages.${prev.system}.hyprland;
    })
  ];
}
