{lib, config, ...}:
let
  cfg = config.apps;
  in with lib; {
  options.apps.enableAll = mkOption { default = true; };

  imports = [
    ./discord
    ./media
    ./obs
    ./spotify
    ./spotube
  ];

  config.apps = mkIf cfg.enableAll {
    discord.enable = mkDefault true;
    media.enable = mkDefault true;
    obs.enable = mkDefault true;
    spotify.enable = mkDefault true;
    spotube.enable = mkDefault true;
  };
}
