{lib, config, pkgs, inputs, ...}:
let
  cfg = config.gaming;

  steamExtraPkgs = with pkgs; [
    gamescope
    mangohud
  ];

  emulatorPkgs = {
    cores = with pkgs.libretro; [
      # Nintendo
      melonds
      bsnes
      mgba
      nestopia
      parallel-n64
      sameboy
      dolphin

      # Sega
      picodrive
      genesis-plus-gx
    ];

    standalone = with pkgs; [
      ryujinx
    ];
  };
in
with lib; {
  options.gaming = {
    enable = mkEnableOption "Enable gaming module";

    steam.enable = mkOption {
      default = true;
    };

    r2modman = mkOption {
      default = true;
      description = "r2modman";
    };

    steamExtra = mkOption {
        default = true;
	description = "Enables Steam";
    };

    emulation = {
      enable = mkOption {
        default = true;
	description = "Enables dolphin, ryujinx and retroarch with basic cores";
      };
      
      retroarch = {
        enable = mkOption {
	  default = true;
	  description = "enables retroarch";
	};

        extraCores = mkOption {
          default = [];
	  description = "Add more cores for retroarch";
	};
      };
    };

    osu = mkOption {
      default = true;
      description = "install Osu-lazer-bin";
    };

    minecraft = mkOption {
      default = true;
      description = "install prismlauncher";
    };

    lutris = mkOption {
      default = true;
      description = "install lutris";
    };
  };

  config = mkIf cfg.enable {
    home.packages = 
      (if cfg.emulation.enable then (emulatorPkgs.standalone 
      ++ (if cfg.emulation.retroarch.enable then [ (pkgs.retroarch.override { cores = [] ++ (cfg.emulation.retroarch.extraCores ++ emulatorPkgs.cores); }) ] else [])) else [])
      ++ (if cfg.osu then [ inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin ] else [])
      ++ (if cfg.minecraft then [ pkgs.prismlauncher ] else [])
      ++ (if cfg.lutris then [ pkgs.lutris ] else [])
      ++ (if cfg.steamExtra then steamExtraPkgs else [])
      ++ (if cfg.steam.enable then [ pkgs.steam ] else [])
      ++ (if cfg.r2modman then [ pkgs.r2modman ] else []);
  };
}
