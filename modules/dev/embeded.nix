{ config, lib, ... }:
let
  cfg = config.dev.embeded;
in
with lib;
{
  options.dev.embeded.enable = mkEnableOption "Makes udev rules for various embeded plaforms";

  config = mkIf cfg.enable {
    users.groups.plugdev = { };
    services.udev.extraRules = ''
      ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE:="0666", GROUP="plugdev"
    '';
  };
}
