{ lib, config, pkgs, ... }:
let cfg = config.drivers;
in with lib; {
  options.drivers = {
    disks = {
      enable = mkOption {
        default = true;
        description = "Enables common desktop services for disks";
      };

      extraPartitionFormats = mkOption { default = true; };
    };

    logitech.enable =
      mkEnableOption "Enables drivers for logitechG and logitech mouses";

    laptop = {
      # Add asus UM3402YA drivers
      enable = mkEnableOption "Laptops common drivers and tools";
    };
  };

  config = {
    services.gvfs.enable = cfg.disks.enable;
    services.devmon.enable = cfg.disks.enable;
    services.udisks2.enable = cfg.disks.enable;
    boot.supportedFilesystems = mkIf cfg.disks.extraPartitionFormats [ "ntfs" ];

    services.upower.enable = cfg.laptop.enable;
    services.power-profiles-daemon.enable = cfg.laptop.enable;

    services.ratbagd.enable = cfg.logitech.enable;
  };
}
