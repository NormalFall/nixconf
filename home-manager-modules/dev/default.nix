{lib, config, ...}:
with lib; {
  imports = [
    ./network-tools.nix
    ./vscodium.nix
  ];

  config = {
    dev.networkTools.enable = mkDefault true;
    dev.vscodium.enable = mkDefault true;
  };
}
