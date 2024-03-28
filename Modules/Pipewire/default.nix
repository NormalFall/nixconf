# Add a noise filter option
{lib, config, pkgs, ...}:
let
  cfg = config.pipewire;
in
with lib; {
  options.pipewire = {
    enable = mkEnableOption "Enables Pipewire audio backend";
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
