{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.hyprland.lock;
in
with lib;
{
  options.hyprland.lock = with lib; {
    enable = mkEnableOption "Enables Hyprlock";
    theme = mkOption {
      default = { };
      description = "Hyprlock configs";
    };
  };

  imports = [ ../../main-user ];

  config.mainUser.modules = [
    ({...} : {
      programs.hyprlock = {
        enable = true;
        settings = cfg.theme;
      };
    })
  ];
}
