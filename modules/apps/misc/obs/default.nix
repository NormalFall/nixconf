{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.misc.obs;
in
with lib;
{
  options.misc.obs = {
    enable = mkEnableOption "Enables obs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.obs-studio ];
  };
}
