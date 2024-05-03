{ config, pkgs, userName, ... }:
let
  modules = ../../home-manager-modules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (modules + /themes/default)
    (modules + /dev/network-tools)
    (modules + /cad)
    (modules + /gaming)
    (modules + /window-manager/hyprland)
    (modules + /terminal/nixvim)
    (modules + /terminal/zsh)
    (modules + /terminal/kitty)
    (modules + /school)
    (modules + /apps/media)
    (modules + /apps/spotube)
    (modules + /apps/spotify)
    (modules + /apps/discord)
    (modules + /apps/obs)
  ];

  hyprland = {
    enable = true;
    monitors = [ "eDP-1, 2880x1800@90,0x0,1.5" ];
    gdkScale = 1.5;
    cursor.size = 24;
    exec = [ "waybar" ];
    idle.enable = true;
    idle.dimTime = 100;
  };

  zsh = {
    enable = true;
    host = "laptop";
  };

  media.enable = true;
  media.editors = true;

  spotube.enable = true;
  spotify.enable = true;
  discord.enable = true;
  obs.enable = true;
  
  kitty.enable = true;

  nixvim.enable = true;

  networkTools = {
    enable = true;
    exclude = [ pkgs.postman ];
  };

  cad.enable = true;

  gaming.enable = true;
  
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}

