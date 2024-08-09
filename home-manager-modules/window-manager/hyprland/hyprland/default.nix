{lib, config, pkgs, ...}:
let
  cfg = config.hyprland.wm;

  binds = (import ./keybinds.nix) pkgs;

in with lib; {
    
  options.hyprland.wm = with lib; {
    enable = mkEnableOption "Enables Hyprland";
    monitors = mkOption {
      default = [ ",preferred,auto,1" ];
      description = "Setup your monitors";
    };

    fakeres = mkEnableOption "Enables neirestNeibour";

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

    extraKeybinds = mkOption {
      default = [];
      description = "Add additional keybinds for themes";
    };

    wallpaper = mkOption {
      default = null;
      description = "Wallpaper that hyprland uses";
    };
    
    theme = mkOption {
      default = {general = {}; animations = {}; decoration = {}; layerrule = {};};
      description = "Hyprland's style config";
    };
  };

  imports = [
    ./hyprexpo.nix
  ];

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

	general = ( cfg.theme.general // {
	  sensitivity = 1;
        });

        decoration = cfg.theme.decoration;
        animations = cfg.theme.animations;
        layerrule = cfg.theme.layerrule;
      };
    };

    services.hyprpaper = mkIf (cfg.wallpaper != null) {
      enable = true;

      settings = {
        wallpaper = [
          ",${cfg.wallpaper}"
        ];

        preload = [
          "${cfg.wallpaper}"
        ];
      };
    };
  };
}
