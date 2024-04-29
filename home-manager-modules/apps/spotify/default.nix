{lib, config, pkgs, ...}:
let
  cfg = config.spotify;
in
with lib; {
  options.spotify = {
    enable = mkEnableOption "Enables spotify";
  };

  config = {
    home.packages = [ pkgs.spotify ];
  };
}
