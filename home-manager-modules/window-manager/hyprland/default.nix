{lib, config, pkgs, ...}:
let
  cfg = config.hyprland;

  binds = (import ./keybinds.nix) pkgs;

  options.hyprland = with lib; {
    enable = mkEnableOption "Enables Hyprland's ecosystem";
    monitors = mkOption {
      default = [ ",preferred,auto,1" ];
      description = "Setup your monitors";
    };

    fakeres = mkOption {
      default = false;
      description = "Enables neirestNeibour";
    };

    gdkScale = mkOption {
      default = 1;
      description = "Changes the GDK_SCALE value";
    };

    cursor = {
      size = mkOption {
        default = 24;
        description = "Cursor size";
      };
    };

    exec = mkOption {
      default = [];
      description = "Basicly exec-once";
    };

    polkit = mkOption {
      default = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      description = "Path of polkit agent";
    };

    touchScreen = mkEnableOption "Enables or disables touchscreens";

    idle = {
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
      
      sleepTime = mkOption {
        default = 200;
        description = "Time before sleep";
      };
    };

    extraKeybinds = mkOption {
      default = [];
      description = "Add additional keybinds for themes";
    };

    wallpaper = mkOption {
      default = null;
      description = "Wallpaper that hyprland uses";
    };
    
    theme = mkOption {
      default = {};
      description = "Hyprland and hyprlock theme";
    };
  };

  theme = {
    hyprland = { general = {}; animations = {}; decoration = {}; layerrule = {};};
    hyprlock = {};
  } // cfg.theme;
in
  with lib; {
    
  inherit options;

  config = mkIf cfg.enable {
    home.packages = [ pkgs.xdg-utils ];
    xdg.portal= {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];

      config = {
        common.default = ["gtk" "hyprland"];
      };
    };
    
    home.pointerCursor = {
      gtk.enable = true;
      size = cfg.cursor.size;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };

      settings = {
        monitor = cfg.monitors;

        bind = binds.key ++ cfg.extraKeybinds;
	bindm = binds.mouse;

        exec-once = cfg.exec ++ [ cfg.polkit ];

        input.touchdevice.enabled = cfg.touchScreen;
        
        env = [
          "HYPRCURSOR_SIZE,${builtins.toString (builtins.toString (cfg.cursor.size))}"
          "GDK_SCALE,${builtins.toString cfg.gdkScale}"
        ];

        xwayland.force_zero_scaling = !cfg.fakeres;

	general = ( theme.hyprland.general // {
	  sensitivity = 1;
        });

        decoration = theme.hyprland.decoration;
        animations = theme.hyprland.animations;
        layerrule = theme.hyprland.layerrule;
      };
    };

    services.hyprpaper = if cfg.wallpaper != null then {
      enable = true;

      settings = {
        wallpaper = [
          ",${cfg.wallpaper}"
        ];

        preload = [
          "${cfg.wallpaper}"
        ];
      };
    } else {};

    services.hypridle = {
      enable = cfg.idle.enable;
      settings = {
        listener = [
          (if cfg.idle.dimTime != null 
          then {
            timeout = cfg.idle.dimTime;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl s 5% -s & ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight s 0 -s";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r & ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight -r";
          }
          else {})

          (if cfg.idle.lockTime != null 
          then {
            timeout = cfg.idle.sleepTime;
            on-timeout = "loginctl lock-session";
          }
          else {})

          (if cfg.idle.sleepTime != null 
          then {
            timeout = cfg.idle.sleepTime;
            on-timeout = "systemctl suspend";
          }
          else {})
        ];

        general = {
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = if cfg.idle.lockBeforeSleep
            then "loginctl lock-session"
            else "";
          };
        };
    };

    programs.hyprlock = theme.hyprlock // {enable = true;};
  };
}
