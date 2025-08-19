{lib, config, pkgs, inputs, ...}: 
let
  cfg = config.niri;
in with lib; {

  options.niri = {
    enable = mkEnableOption "Enables niri and it's environment" // { default = true;};

    theme = mkOption {
      default = {
        layout = {};
        overview = {};
        layer-rules = [];
        window-rules = [];
        no-csd = true;
      };
    };

    extraKeybinds = mkOption {
      default = {};
      description = "Additional binds for external modules";
    };

    polkit = mkOption {
      default = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      description = "Path of polkit agent";
    };

    touchScreen = mkEnableOption "Enables laptop touch screen";

    monitors = mkOption {
      default = {};
    };
  };

  imports = [ ../../main-user ];

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.niri.enable = true;

    mainUser.modules = [
      inputs.niri.homeModules.niri
      #inputs.niri.homeModules.config
      ./keybinds.nix
      ({pkgs, ...}: {

        xdg.portal = {
          enable = true;
          extraPortals =  [
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-gtk
          ];
        };

        programs.niri.enable = true;
        programs.niri.package = pkgs.niri; # Prefer nixpkgs niri
        programs.niri.settings = {
          input = {
            power-key-handling.enable = false;

            focus-follows-mouse.enable = true;
            focus-follows-mouse.max-scroll-amount = "30%";
            warp-mouse-to-focus.enable = true;

            touchpad = {
              tap = true;
              natural-scroll = false;
            };

            touch.enable = cfg.touchScreen;
            touch.map-to-output = "eDP-1"; # Map touch to laptop screen
          };

          gestures.hot-corners.enable = false;

          hotkey-overlay.skip-at-startup = true;

          clipboard.disable-primary = true;

          spawn-at-startup = [
            {command = [
              "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
            ];}

            {command = [
              cfg.polkit
            ];}
          ];

          # xwayland env
          environment.DISPLAY = ":0";

          # Hack to have preopened workspaces
          # Don't add too many since it messes with bars
          workspaces."1" = {};
          workspaces."2" = {};
          workspaces."3" = {};
          workspaces."4" = {};

          # Configurables
          layout = cfg.theme.layout // {
              preset-column-widths = [
                { proportion = 1. / 3.; }
                { proportion = 1. / 2.; }
                { proportion = 2. / 3.; }
              ];

              default-column-width.proportion = 1. / 3.;
          };

          overview = cfg.theme.overview;

          layer-rules = cfg.theme.layer-rules;

          window-rules = cfg.theme.window-rules;

          prefer-no-csd = cfg.theme.no-csd;

          binds = cfg.extraKeybinds;

          outputs = cfg.monitors;
        };
      })
    ];
  };
}
