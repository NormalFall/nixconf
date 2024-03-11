{ config, pkgs, userName, ... }:

{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  home.stateVersion = "23.11"; # Please read the comment before changing.

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

  programs.home-manager.enable = true;
}

