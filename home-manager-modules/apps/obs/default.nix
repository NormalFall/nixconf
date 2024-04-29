{lib, config, pkgs, ...}:
let
  cfg = config.obs;
in
with lib; {
  options.obs = {
    enable = mkEnableOption "Enables obs";
  };

  config = {
    home.packages = [ pkgs.obs-studio ];
  };
}
