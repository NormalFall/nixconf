{lib, config, ...}:
let cfg = config.drivers.peripherals;
in with lib; {
  options.drivers.peripherals.logitech.enable = mkEnableOption "Enables ratbagd for gaming mice";

  config.services.ratbagd.enable = cfg.logitech.enable;
}
