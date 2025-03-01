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
      description = "Enables rototyping, CAD tools and 3d printer software";
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
        kicad
        fritzing
        prusa-slicer
        blender
      ]
    );
  };
}
