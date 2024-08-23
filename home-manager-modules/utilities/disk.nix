{ lib, config, pkgs, ... }:
let cfg = config.utilities.disk;
in with lib; {
  options.utilities.disk.enable =
    mkEnableOption "Enable common disk management tools";
  config.home.packages = mkIf cfg.enable [ pkgs.gparted pkgs.popsicle ];
}