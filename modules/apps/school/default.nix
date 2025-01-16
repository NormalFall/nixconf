{ config, pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.libreoffice-fresh
    ];
  };
}
