{lib, config, pkgs, ...}:
let
  cfg = config.gaming.steam;

  extraSteamPackage = with pkgs; [
    gamescope
    mangohud
  ];

in with lib; {
  options.gaming.steam = {
    enable = mkEnableOption "Enables steam";

    enableExtraPackages = mkEnableOption "Enables common steam utilities";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.steam]
    ++ (if cfg.enableExtraPackages then extraSteamPackage else []);
  };
}
