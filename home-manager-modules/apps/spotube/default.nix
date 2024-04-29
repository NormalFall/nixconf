{lib, config, pkgs, ...}:
let
  cfg = config.spotube;
in
with lib; {
  options.spotube = {
    # need to add config support
    enable = mkEnableOption "Enables spotube";
  };

  config = {
    home.packages = [ pkgs.spotube ];
  };
}
