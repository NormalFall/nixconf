{ lib, config, ... }:
with lib; {
  imports = [ ./network-tools.nix ./vscodium.nix ./android.nix ];

  config = {
    dev.networkTools.enable = mkDefault true;
    dev.vscodium.enable = mkDefault true;
    dev.android.enable = mkDefault true;
  };
}
