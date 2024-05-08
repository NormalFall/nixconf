{ config, pkgs, userName, ... }:
let
  modules = ../../home-manager-modules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (modules + /themes/default)
    (modules + /cad)
    (modules + /dev)
    (modules + /gaming)
    (modules + /window-manager/hyprland)
    (modules + /terminal)
    (modules + /apps)
  ];

  hyprland = {
    monitors = [ "eDP-1, 2880x1800@90,0x0,1.5" ];
    gdkScale = 1.5;
    cursor.size = 24;
    exec = [ "waybar" ];
    idle.enable = true;
    idle.dimTime = 100;
  };

  terminal.zsh.host = "laptop";

  media.enable = true;
  media.editors = true;
  
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}

