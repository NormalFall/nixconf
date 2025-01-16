{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";

    programs.mtr.enable = true;
    programs.dconf.enable = true;

    nixpkgs.config.allowUnfree = true;
  };
}
