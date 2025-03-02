{ lib, config, ... }:
let
  cfg = config.misc;
in
with lib;
{
  options.misc.enableAll = mkOption { default = true; };

  imports = [
    ./discord
    ./obs
    ./spotify
    ./zen-browser
  ];

  config.misc = mkIf cfg.enableAll {
    discord.enable = mkDefault true;
    obs.enable = mkDefault true;
    spotify.enable = mkDefault true;
    zen-browser.enable = mkDefault true;
  };
}
