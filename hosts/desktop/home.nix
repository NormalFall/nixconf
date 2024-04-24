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
    (Modules + /Apps/Media)
    (Modules + /Apps/Spotube)
    (Modules + /Apps/Spotify)
    (Modules + /Apps/Discord)
    (Modules + /Apps/OBS)
  ];

  hyprland = {
    enable = true;
    monitors = [ "DP-1, 3440x1440@144,0x0,1" ];
    exec = [ "waybar" ];
    cursor.size = 30;
  };

  waybar.enable = true;

  zsh = {
    enable = true;
    host = "desktop";
  };

  kitty.enable = true;

  media.enable = true;
  media.editors = true;

  spotube.enable = true;
  spotify.enable = true;
  discord.enable = true;
  obs.enable = true;


  nixvim.enable = true;

  networkTools = {
    enable = true;
    exclude = [ pkgs.postman ];
  };

  gaming.enable = true;
  
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}

