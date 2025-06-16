{lib, config, pkgs, inputs, ...}: 
let
  cfg = config.niri;
in with lib; {

  options.niri = {
    enable = mkEnableOption "Enables niri and it's environment" // { default = true;};

    layout = mkOption {
      default = null;
      description = "Layout options of niri";
    };

    extraKeybinds = mkOption {
      default = {};
      description = "Additional binds for external modules";
    };
  };

  imports = [ ../../main-user ];

  config = mkIf cfg.enable {
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
        programs.niri.package = pkgs.niri;
        programs.niri.settings = {
          input = {
            focus-follows-mouse.enable = true;
            focus-follows-mouse.max-scroll-amount = "5%";
            warp-mouse-to-focus = true;

            touchpad = {
              tap = true;
              natural-scroll = true;
            };
          };

          # Temporairy while there are no options for display
          outputs."DP-1".mode = {
            width = 3440;
            height = 1440;
            refresh = 144.000;
          };

          # Disable server decorations
          prefer-no-csd = true;

          # Support xwayland
          spawn-at-startup = [{command = [
            "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
          ];}];
          environment.DISPLAY = ":0";

          layout = mkIf (cfg.layout != null) cfg.layout;
          binds = cfg.extraKeybinds;
        };
      })
    ];
  };
}
