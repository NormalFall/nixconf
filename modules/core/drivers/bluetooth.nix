{lib, pkgs, config, ...}:
let cfg = config.drivers.bluetooth;
in with lib; {
  options.drivers.bluetooth.enable = mkEnableOption "Enable bluetooth with common settings";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        experimental = true;
      };
    };

    environment.systemPackages = [ pkgs.bluetuith ];
  };
}
