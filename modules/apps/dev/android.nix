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

  # todo: add a check for if VM module is enabled
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.android-studio ];
    networking.firewall.allowedTCPPorts = [ 8081 ]; # react native/expo ports
  };
}
