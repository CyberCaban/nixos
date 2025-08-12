
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wallust
  ];
  xdg.configFile."wallust/wallust.toml" = { 
    source = ./wallust.toml;
    force = true;
  };
  xdg.configFile."wallust/templates/" = { 
    source = ./template;
    recursive = true;
    force = true;
  };
}
