{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.misc.discord;
in
with lib;
{
  options.misc.discord = {
    # todo: add plugin support.
    enable = mkEnableOption "Enables vesktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vesktop ];
  };
}
