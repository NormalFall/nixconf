{ lib, config, pkgs, ... }:
let cfg = config.utilities.audio;
in with lib; {
  options.utilities.audio.enable = mkEnableOption "Enable common audio tools";
  config.home.packages = mkIf cfg.enable [ pkgs.pavucontrol pkgs.helvum ];
}
