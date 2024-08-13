{ lib, config, pkgs, ... }:
let cfg = config.utilities.peripherals;
in with lib; {
  options.utilities.peripherals = {
    enable = mkEnableOption "Enables Managers for peripherals";
    logitechg.enable = mkEnableOption "Enable piper to manager logitechg mouse"
      // {
        default = true;
      };
    logitech.enable = mkEnableOption "Enable Solaar to manage logitech mouse"
      // {
        default = true;
      };
  };

  config.home.packages = mkIf cfg.enable
    ((if cfg.logitechg.enable then [ pkgs.piper ] else [ ])
      ++ (if cfg.logitech.enable then [ pkgs.solaar ] else [ ]));
}
