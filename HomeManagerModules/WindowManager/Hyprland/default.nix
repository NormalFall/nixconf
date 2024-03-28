{lib, config, pkgs, inputs, ...}:
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
      description = "Enables neirestNeibour ";
    };

    cursor = {
      size = mkOption {
        default = 24;
        description = "Cursor size";
      };
    };

    theme = mkOption {
      default = "default";
      description = "Hyprland Theme";
    };

    themeData = import (./Themes + "/${cfg.theme}.nix");

    touchScreen = mkEnableOption "Enables or disables touchscreens";
  };

  theme = import (./Themes + "/${cfg.theme}.nix");
in
  with lib; {
    
  inherit options;

  imports = [ 
    inputs.hyprland.homeManagerModules.default
  ];

  config = mkIf cfg.enable {
    xdg.portal= {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config.common.default = "*";
    };

    home.pointerCursor = {
      gtk.enable = true;
      size = cfg.cursor.size;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = cfg.monitors;

        bind = binds.key;
	bindm = binds.mouse;

        input.touchdevice.enabled = cfg.touchScreen;
        
        env = [
          "HYPRCURSOR_SIZE,${builtins.toString (cfg.cursor.size / 1.2)}"
        ];

        xwayland.force_zero_scaling = !cfg.fakeres;

	general = ( theme.general // {
	  sensitivity = 1;
        });

        decoration = theme.decoration;
        animations = theme.animations;
      };
    };
  };
}
