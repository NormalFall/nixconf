{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.nh;
in
with lib;
{
  options.terminal.nh = {
    enable = mkEnableOption "Enable nh";
    flake = mkOption {
      default = "/home/${config.mainUser.userName}/.nixconf/";
      description = "Nixos flake path";
    };
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = cfg.flake;

      clean.extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
