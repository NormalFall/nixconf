{ lib, config, ... }:
let
  cfg = config.gaming;
in
with lib;
{
  options.gaming.enable = mkEnableOption "Enables everything gaming" // {
    default = true;
  };

  imports = [
    ./emulation.nix
    ./steam.nix
    ./extras.nix
  ];

  config = mkIf cfg.enable {
    gaming.emulation.enable = mkDefault true;
    gaming.steam.enable = mkDefault true;
    gaming.extras.enable = mkDefault true;
  };
}
