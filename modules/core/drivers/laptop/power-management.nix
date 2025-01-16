{lib, config, ...}:
let cfg = config.drivers.power-management;
in with lib; {
  options.drivers.power-management.enable = mkEnableOption "Help to manage battery and battery life";

  config = mkIf cfg.enable {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
