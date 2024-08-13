{ lib, config, pkgs, ... }:
let cfg = config.apps.spotube;
in with lib; {
  options.apps.spotube = {
    # need to add config support
    enable = mkEnableOption "Enables spotube";
  };

  config = { home.packages = [ pkgs.spotube ]; };
}
