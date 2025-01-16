{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.gaming.steam;

  extraSteamPackage = with pkgs; [
    gamescope
    mangohud
    r2modman
  ];

in
with lib;
{
  options.gaming.steam = {
    enable = mkEnableOption "Enables steam";

    enableExtraPackages = mkEnableOption "Enables common steam utilities" // {default = true;};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = (if cfg.enableExtraPackages then extraSteamPackage else [ ]);
    
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamemode.enable = true;
  };
}
