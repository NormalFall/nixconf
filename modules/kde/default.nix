{lib, config, pkgs, ...}:
let
  cfg = config.kde;
in with lib; {
  options.kde = {
    enable = mkOption { default = true; };

    sddm = mkOption {
      default = false;
      type = types.bool;
      description = "Enable sddm";
    };
    kbLayout = mkOption {
      default = "us";
      type = types.str;
      description = ''Set x11 keyboard layout'';
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.sddm.enable = cfg.sddm;     
      enable = true;
      desktopManager.plasma5.enable = true;
    };

    services.xserver.xkb = {
      layout = "${cfg.kbLayout}";
      variant = "";
    };
  };
}
