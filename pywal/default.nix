
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pywal
  ];
  xdg.configFile."wal/templates/" = { 
    source = ./template;
    recursive = true;
    force = true;
  };
}
