{lib, config, pkgs, ...}:
let
  cfg = config.gaming;
in
with lib; {
  options.gaming.enable = mkEnableOption "Settings for a better gaming experience";

  config = mkIf cfg.enable {
    programs.steam = {
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamemode.enable = true;
  };
}
