{ lib, config, pkgs, ... }:
with lib; {
  config = {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";

    programs.mtr.enable = true;
    programs.dconf.enable = true;
  };
}
