{lib, pkgs, ...}:
with lib; {
  imports = [
    ./wireshark.nix
    ./embeded.nix
  ];

  config = {
    dev.wireshark.enable = mkDefault true;
    dev.embeded.enable = mkDefault true;
  };
}
