{lib, config, pkgs, ...}:
let
  cfg = config.discord;
in
with lib; {
  options.spotify = {
    # need to add spicetify support
    enable = mkEnableOption "Enables spotify";
  };

  config = {
    home.packages = [ pkgs.spotify ];
  };
}
