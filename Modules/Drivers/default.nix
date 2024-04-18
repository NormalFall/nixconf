{lib, config, pkgs, ...}:
let
  cfg = config.drivers;
in
with lib; {
  options.drivers = {
    logitech.enable = mkEnableOption "Enables drivers for logitechG and logitech mouses";

    laptop = {
      # Add asus UM3402YA drivers
      enable = mkEnableOption "Laptops common drivers and tools";
    };
  };

  config = {
    services.tlp.enable = cfg.laptop.enable;
    services.upower.enable = cfg.laptop.enable;

    environment.systemPackages = (if cfg.logitech.enable then [ pkgs.solaar pkgs.piper ] else []);
  };
}
