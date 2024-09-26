{ lib, config, ... }:
with lib;
{
  imports = [
    ./file-manager.nix
    ./compression.nix
    ./media.nix
    ./file-sharing.nix
    ./syncthing.nix
  ];

  config.files = {
    fileManager.enable = mkDefault true;
    compression.enable = mkDefault true;
    media.enable = mkDefault true;
    fileSharing.enable = mkDefault true;
    syncthing.enable = mkDefault true;
  };
}
