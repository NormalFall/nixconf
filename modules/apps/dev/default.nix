{ lib, config, ... }:
with lib;
{
  imports = [
    ./network-tools.nix
    ./vscodium.nix
    ./android.nix
    ./embedded.nix
  ];

  config = {
    dev.networkTools.enable = mkDefault true;
    dev.vscodium.enable = mkDefault true;
    dev.android.enable = mkDefault true;
    dev.embedded.enable = mkDefault true;
  };
}
