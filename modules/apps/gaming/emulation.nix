{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.gaming.emulation;

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
    switch = ryujinx-greemdev;

    # Sega
    sega = kega-fusion;

    # Sony
    psp = ppsspp;
    ps1 = duckstation;
    ps2 = pcsx2;
  };

in
with lib;
{
  options.gaming.emulation = {
    enable = mkEnableOption "Enables dolphin, ryujinx and other common emulators";

    exclude = mkOption {
      default = [ ];
      description = "list of name of excluded consoles";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = (builtins.attrValues (builtins.removeAttrs emulatorPkgs cfg.exclude));
  };
}
