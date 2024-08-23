{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.gaming;
in
with lib;
{
  options.gaming.enable = mkOption { default = true; };

  config = mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamemode.enable = true;
  };
}
