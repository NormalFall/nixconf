{lib, config, pkgs, ...}:
let
  cfg = config.apps.spotify;
in
with lib; {
  options.apps.spotify = {
    enable = mkEnableOption "Enables spotify";
  };

  config = {
    home.packages = [ pkgs.spotify ];
  };
}
