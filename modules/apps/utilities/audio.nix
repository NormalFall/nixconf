{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.utilities.audio;
in
with lib;
{
  options.utilities.audio.enable = mkEnableOption "Enable common audio tools";
  config.environment.systemPackages = mkIf cfg.enable [
    pkgs.pavucontrol
    pkgs.helvum
  ];
}
