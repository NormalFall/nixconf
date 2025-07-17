{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.misc.torrent;
in
with lib;
{
  options.misc.torrent = {
    enable = mkEnableOption "Enables qbittorrent";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.qbittorrent-enhanced ];
  };
}
