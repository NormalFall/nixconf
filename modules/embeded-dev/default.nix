{config, lib, ...}:
let
  cfg = config.embededDev;
in with lib; {
  options.embededDev.enable = mkOption {
    default = true;
    description = "Makes udev rules for various embeded plaforms";
  };

  config = mkIf cfg.enable {
    users.groups.plugdev = {};
    services.udev.extraRules = ''
    ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE:="0666", GROUP="plugdev"
    '';
  };
}
