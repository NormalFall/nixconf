{
  lib,
  config,
  pkgs,
  customPkgs,
  ...
}:
let
  cfg = config.hyprland.wm;
in
with lib;
{

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
      default = [ ];
      description = "Basicly exec-once";
    };

    polkit = mkOption {
      default = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      description = "Path of polkit agent";
    };

    ssh-agent = mkOption {
      default = "eval $(${pkgs.openssh}/bin/ssh-agent)";
      description = "Command for the ssh agent";
    };

    touchScreen = mkEnableOption "Enables or disables touchscreens";

    extraKeybinds = mkOption {
      default = [ ];
      description = "Add additional keybinds for themes";
    };

    wallpaper = mkOption {
      default = null;
      description = "Wallpaper that hyprland uses";
    };

    theme = mkOption {
      default = {
        general = { };
        animations = { };
        decoration = { };
        layerrule = { };
      };
      description = "Hyprland's style config";
    };
  };

  imports = [ ../../../main-user ];

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    mainUser.modules = [
      ./keybinds.nix
      ./hyprexpo.nix

      ({...} : {
        home.packages = [ pkgs.xdg-utils ];

        home.pointerCursor = {
          gtk.enable = true;
          size = cfg.cursor.size;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };

        wayland.windowManager.hyprland = {
          enable = true;
          systemd = {
            variables = [ "--all" ];
            extraCommands = [
              "systemctl --user stop graphical-session.target && sleep 2 && systemctl --user start hyprland-session.target"
            ];
          };

          settings = {
            monitor = cfg.monitors;

            misc.disable_hyprland_logo = true;
            misc.disable_splash_rendering = true;

            bind = cfg.extraKeybinds;

            exec-once = cfg.exec ++ [
              cfg.polkit 
              cfg.ssh-agent
              "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular" # Make clipboard outlive windows
              "${customPkgs.clipsync}/bin/clipsync watch without-notifications"
            ];

            input.touchdevice.enabled = cfg.touchScreen;

            gestures.workspace_swipe = true;

            env = [
              "HYPRCURSOR_SIZE,${builtins.toString (builtins.toString (cfg.cursor.size))}"
              "GDK_SCALE,${builtins.toString cfg.gdkScale}"
            ];

            xwayland.force_zero_scaling = !cfg.fakeres;

            general = cfg.theme.general;

            decoration = cfg.theme.decoration;
            animations = cfg.theme.animations;
            layerrule = cfg.theme.layerrule;
          };
        };

        services.hyprpaper = mkIf (cfg.wallpaper != null) {
          enable = true;

          settings = {
            wallpaper = [ ",${cfg.wallpaper}" ];

            preload = [ "${cfg.wallpaper}" ];
          };
        };
      })
    ];
  };
}
