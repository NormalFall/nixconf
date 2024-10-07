{ config, pkgs, ... }:
{
  config = {
    home.packages = [
      pkgs.teams-for-linux
      pkgs.libreoffice-fresh
    ];
  };
}
