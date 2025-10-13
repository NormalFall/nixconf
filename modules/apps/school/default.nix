{ config, pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.libreoffice-fresh
      pkgs.kdePackages.okular
    ];
    virtualisation.vmware.host.enable = true;
  };
}
