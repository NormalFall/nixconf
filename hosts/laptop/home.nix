{ config, pkgs, userName, ... }:
let
  Modules = ../../HomeManagerModules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (Modules + /NetworkTools)
    (Modules + /Gaming)
    (Modules + /WindowManager/Hyprland)
    (Modules + /Terminal/Nixvim)
  ];

  hyprland = {
    enable = true;
    monitors = [ "eDP-1, 2880x1800@90,0x0,1.6" ];
    cursor.size = 30;
  };

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

