{lib, config, pkgs, ...}:
let
  cfg = config.apps.obs;
in
with lib; {
  options.apps.obs = {
    enable = mkEnableOption "Enables obs";
  };

  config = {
    home.packages = [ pkgs.obs-studio ];
  };
}
