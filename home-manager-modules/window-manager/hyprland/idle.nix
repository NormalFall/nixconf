{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.hyprland.idle;
in
with lib;
{
  options.hyprland.idle = with lib; {
    enable = mkEnableOption "Enables hypridle";

    lockBeforeSleep = mkOption { default = true; };

    dimTime = mkOption {
      default = null;
      description = "Dims every lights. Disabled if not set";
    };

    lockTime = mkOption {
      default = 150;
      description = "Time before hyprlock";
    };

    displayTime = mkOption {
      default = 200;
      description = "Closes screen without going into sleep";
    };

    sleepTime = mkOption {
      default = 600;
      description = "Time before sleep";
    };
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = cfg.enable;
      settings = {
        listener = [
          (mkIf (cfg.dimTime != null) {
            timeout = cfg.dimTime;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl s 5% -s & ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight s 0 -s";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r & ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight -r";
          })

          (mkIf (cfg.lockTime != null) {
            timeout = cfg.sleepTime;
            on-timeout = "loginctl lock-session";
          })

          (mkIf (cfg.displayTime != null) {
            timeout = cfg.sleepTime;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          })

          (mkIf (cfg.sleepTime != null) {
            timeout = cfg.sleepTime;
            on-timeout = "systemctl suspend";
          })
        ];

        general = {
          lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = if cfg.lockBeforeSleep then "loginctl lock-session" else "";
        };
      };
    };
  };
}
