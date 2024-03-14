{ config, pkgs, userName, ... }:
let
  Modules = ../../HomeManagerModules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (Modules + "/NetworkTools")
  ];

  networkTools = {
    enable = true;
    exclude = [ pkgs.postman ];
  };
  
  home.packages = with pkgs; [
    lolcat
  ];

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

