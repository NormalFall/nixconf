{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.files.fileSharing;
in
with lib;
{
  options.files.fileSharing.enable = mkEnableOption "Enables localsend";

  config.programs.localsend = mkIf cfg.enable {
    enable = true;
    openFirewall = true;
  };
}
