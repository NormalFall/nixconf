{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.utilities.rgb;
in
with lib;
{
  options.utilities.rgb.enable = mkEnableOption "Enable common disk management tools";
  config.services.hardware.openrgb = mkIf cfg.enable {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
}
