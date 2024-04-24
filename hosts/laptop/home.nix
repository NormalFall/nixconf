{ config, pkgs, userName, ... }:
let
  Modules = ../../HomeManagerModules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (Modules + /Themes/Default)
    (Modules + /Dev/NetworkTools)
    (Modules + /Cad)
    (Modules + /Gaming)
    (Modules + /WindowManager/Hyprland)
    (Modules + /Terminal/Nixvim)
    (Modules + /Terminal/Zsh)
    (Modules + /Terminal/Kitty)
    (Modules + /School)
    (Modules + /Apps/Media)
    (Modules + /Apps/Spotube)
    (Modules + /Apps/Spotify)
    (Modules + /Apps/Discord)
    (Modules + /Apps/OBS)
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

  waybar.enable = true;

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

