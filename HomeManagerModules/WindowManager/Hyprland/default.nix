{lib, config, pkgs, inputs, ...}:
let
  cfg = config.hyprland;

  binds = (import ./keybinds.nix) pkgs;
in
with lib; {

  imports = [ 
    inputs.hyprland.homeManagerModules.default
  ];

  options.hyprland = {
    enable = mkEnableOption "Enables Hyprland's ecosystem";
    monitors = mkOption {
      default = [ ",preferred,auto,1" ];
      description = "Setup your monitors";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = cfg.monitors;

        bind = binds.key;
	bindm = binds.mouse;

	general = {
	  sensitivity = 1;

	  gaps_in = 11;
	  gaps_out = 15;
          border_size = 2;
	};

	decoration = {
	  rounding = 15;
	  blur.enabled = true;
	};

	animations = {
	  enabled = true;

	  bezier = [
	    "Overshoot, 0.05, 0.9, 0.1, 0.1"
	  ];

	  animation = [
            "windows, 1, 5, Overshoot, slide"
            "windowsOut, 1, 7, Overshoot, popin 80%"
	    "workspaces, 1, 6, Overshoot, slidevert"
	  ];
	};

      };
    };
  };
}
