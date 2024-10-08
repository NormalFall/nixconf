{
  lib,
  config,
  pkgs,
  inputs,
  userName,
  ...
}:
let
  cfg = config.gaming.extras;
in
with lib;
{
  options.gaming.extras = {
    enable = mkEnableOption "Enables minecraft, lutris and osu";

    minecraft = mkEnableOption "Enables PrismLauncher" // {
      default = true;
    };
    osu = mkEnableOption "Enables OSU!Laser" // {
      default = true;
    };
    lutris = mkEnableOption "Enables lutris" // {
      default = true;
    };
    slippi = {
      enable = mkEnableOption "Enable slippi launcher" // {
        default = true;
      };
      isoPath = mkOption {
        default = "/home/${userName}/.roms/GC/ssbm.iso";
        description = "Melee's iso path";
      };
    };
  };

  imports = [ inputs.ssbm-nix.homeManagerModule ];

  config = mkIf cfg.enable {
    home.packages = [
      (mkIf cfg.minecraft pkgs.prismlauncher)
      (mkIf cfg.osu pkgs.osu-lazer-bin)
      (mkIf cfg.lutris pkgs.lutris)
    ];

    ssbm.slippi-launcher = {
      enable = cfg.slippi.enable;
      isoPath = cfg.slippi.isoPath;
      # Add more options later
    };
  };
}
