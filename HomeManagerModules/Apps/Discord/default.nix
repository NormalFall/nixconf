{lib, config, pkgs, ...}:
let
  cfg = config.discord;
in
with lib; {
  options.discord = {
    # Need to add plugin support.
    enable = mkEnableOption "Enables vesktop";
  };

  config = {
    home.packages = [ pkgs.vesktop ];
  };
}
