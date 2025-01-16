{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.misc.spotify;
in
with lib;
{
  options.misc.spotify = {
    enable = mkEnableOption "Enables spotify";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.spotify ];
  };
}
