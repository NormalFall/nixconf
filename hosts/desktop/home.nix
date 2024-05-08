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
    (modules + /gaming)
    (modules + /window-manager/hyprland)
    (modules + /terminal)
    (modules + /apps)
  ];

  hyprland = {
    enable = true;
    monitors = [ "DP-1, 3440x1440@144,0x0,1" ];
    exec = [ "waybar" ];
    cursor.size = 30;
  };

  terminal.zsh.host = "desktop";

  apps.media.editors = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}

