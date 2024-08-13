{ lib, config, ... }:
with lib; {
  imports = [ ./file-manager.nix ./compression.nix ./media.nix ];

  config.files = {
    fileManager.enable = mkDefault true;
    compression.enable = mkDefault true;
    media.enable = mkDefault true;
  };
}
