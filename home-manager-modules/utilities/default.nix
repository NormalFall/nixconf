{ lib, config, ... }:
let cfg = config.utilities;
in with lib; {
  options.utilities.enable = mkEnableOption "Enables tooling to manage system"
    // {
      default = true;
    };

  imports = [ ./audio.nix ./disk.nix ./peripherals.nix ];

  config = mkIf cfg.enable {
    utilities.audio.enable = mkDefault true;
    utilities.disk.enable = mkDefault true;
    utilities.peripherals.enable = mkDefault true;
  };
}
