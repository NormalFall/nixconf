{lib, config, pkgs, inputs, ...}:
let
  cfg = config.gaming;

  steamExtraPkgs = with pkgs; [
    gamescope
    mangohud
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
  ];

  emulatorPkgs = {
    cores = with pkgs.libretro; [
      melonds
      mgba
      snes9x
      nestopia
      parallel-n64
      pcsx2
    ];

    standalone = with pkgs; [
      ryujinx
      dolphin-emu
    ];
  };
in
with lib; {
  options.gaming = {
    enable = mkEnableOption "Enable gaming module";

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
  };

  config = mkIf cfg.enable {
    home.packages = 
      (if cfg.emulation.enable then (emulatorPkgs.standalone 
      ++ (if cfg.emulation.retroarch.enable then (cfg.emulation.retroarch.extraCores ++ emulatorPkgs.cores ++ [ pkgs.retroarch ]) else [])) else [])
      ++ (if cfg.steamExtra then steamExtraPkgs else [])
      ++ (if cfg.osu then [ inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin ] else []);
  };
}
