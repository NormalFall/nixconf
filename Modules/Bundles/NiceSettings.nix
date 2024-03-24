{lib, config, pkgs, ...}:
let
  cfg = config.niceSettings;
in
with lib; {
  options.niceSettings.enable = 
    mkEnableOption "Adds a few core settings and nice to have for NixOS";

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";

    programs.mtr.enable = true;
  };
}
