{lib, config, pkgs, ...}:
let
  cfg = config.kde;
in
{
  options.kde = {
    enable = lib.mkEnableOption "Enable KDE";

    sddm = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable sddm";
    };
    kbLayout = lib.mkOption {
      default = "us";
      description = ''Set x11 keyboard layout'';
    };
  };

  config = lib.mkIf cfg.enable {
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
