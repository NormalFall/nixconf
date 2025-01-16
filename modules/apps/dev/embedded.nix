{ config, lib, ... }:
let
  cfg = config.dev.embedded;
in
with lib;
{
  options.dev.embedded.enable = mkEnableOption "Makes udev rules for various embeded plaforms";

  imports = [
    ../../core/main-user # add user to plugdev group
  ];

  config = mkIf cfg.enable {
    users.groups.plugdev = { }; # Create group
    mainUser.groups = [ "plugdev" ];
    services.udev.extraRules = ''
      ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE:="0666", GROUP="plugdev"
    '';
  };
}
