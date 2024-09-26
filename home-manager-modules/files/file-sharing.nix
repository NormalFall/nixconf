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

  config.home.packages = [ pkgs.localsend ];
}
