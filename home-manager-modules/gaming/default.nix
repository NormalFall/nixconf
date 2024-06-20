{lib, config, pkgs, inputs, ...}:
let
  cfg = config.gaming;

  steamExtraPkgs = with pkgs; [
    gamescope
    mangohud
  ];

  emulatorPkgs = with pkgs; {
    # Nintendo
    ds = melonDS;
    snes = snes9x;
    gba = mgba;
    nes = nestopia-ue;
    n64 = mupen64plus;
    gb = sameboy;
    wii = dolphin-emu;
    wiiu = cemu;
    switch = ryujinx;

    # Sega
    sega = kega-fusion;

    # Sony
    psp = ppsspp;
    ps1 = pcsxr;
    ps2 = pcsx2;
  };
in with lib; {
  options.gaming = {
    enable = mkOption {
      default = true;
      description = "Enable gaming module";
    };

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

      exclude = mkOption {
        default = [];
        description = "list of name of excluded consoles";
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
      (if cfg.osu then [ pkgs.osu-lazer-bin ] else [])
      ++ (if cfg.minecraft then [ pkgs.prismlauncher ] else [])
      ++ (if cfg.lutris then [ pkgs.lutris ] else [])
      ++ (if cfg.steamExtra then steamExtraPkgs else [])
      ++ (if cfg.steam.enable then [ pkgs.steam ] else [])
      ++ (if cfg.r2modman then [ pkgs.r2modman ] else [])
      ++ (if cfg.emulation.enable then (builtins.attrValues (builtins.removeAttrs emulatorPkgs cfg.emulation.exclude)) else []);
  };
}
