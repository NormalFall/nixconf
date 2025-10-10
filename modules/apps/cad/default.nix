{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.cad;
in
with lib;
{
  options.cad = {
    enable = mkOption {
      default = true;
      description = "Enables prototyping, CAD tools and 3d printer software";
    };
    exclude = mkOption {
      default = [ ];
      description = "Exclude packages from being installed";
    };
  };

  config = {
    environment.systemPackages = lists.subtractLists cfg.exclude (
      with pkgs;
      [
        fritzing
        prusa-slicer
        blender
      ]
    );
  };
}
