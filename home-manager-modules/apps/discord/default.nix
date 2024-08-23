{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.discord;
in
with lib;
{
  options.apps.discord = {
    # Need to add plugin support.
    enable = mkEnableOption "Enables vesktop";
  };

  config = {
    home.packages = [ pkgs.vesktop ];
  };
}
