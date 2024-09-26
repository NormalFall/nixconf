{lib, config, ...}:
let cfg = config.drivers.bluetooth;
in with lib; {
  options.drivers.bluetooth.enable = mkEnableOption "Enable bluetooth with common settings";

  config.hardware.bluetooth = mkIf cfg.enable {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      experimental = true;
    };
  };
}
