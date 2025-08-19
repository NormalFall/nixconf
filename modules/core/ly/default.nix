{config, pkgs, lib, ...}:
let
  cfg = config.ly;
in with lib; {
  options.ly.enable = mkEnableOption "Enables with ly with related options" // { default = true; };

  config.services.displayManager.ly = mkIf cfg.enable {
    enable = true;
    settings = {
      allow_empty_password = false;
      xinitrc = "null";

      brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q s 10%-";
      brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q s 10%+";

      # Theming
      animation = "colormix";
    };
  };
}
