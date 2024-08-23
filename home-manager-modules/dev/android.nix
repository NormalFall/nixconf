{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.dev.android;
in
with lib;
{
  options.dev.android.enable = mkEnableOption "Enable Android Studio";

  config = mkIf cfg.enable { home.packages = [ pkgs.android-studio ]; };
}
