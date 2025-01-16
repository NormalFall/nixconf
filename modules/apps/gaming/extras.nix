{
  lib,
  config,
  pkgs,
  inputs,
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
        default = "/home/${config.mainUser.userName}/.roms/GC/ssbm.iso";
        description = "Melee's iso path";
      };
    };
  };

  imports = [ ../../core/main-user ];

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (mkIf cfg.minecraft pkgs.prismlauncher)
      (mkIf cfg.osu pkgs.osu-lazer-bin)
      (mkIf cfg.lutris pkgs.lutris)
    ];

    mainUser = {
      modules = [
        inputs.ssbm-nix.homeManagerModule
        ({...} : {
          ssbm.slippi-launcher = {
            enable = cfg.slippi.enable;
            isoPath = cfg.slippi.isoPath;
            # Add more options later
          };
        })
      ];
    };
  };
}
