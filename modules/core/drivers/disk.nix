{lib, config, ...}:
let cfg = config.drivers.disk;
in with lib; {
  options.drivers.disk.enable = mkEnableOption "Starts Disk management deamon and adds support for ntfs";

  config = mkIf cfg.enable {
    services.gvfs.enable = cfg.enable;
    services.devmon.enable = cfg.enable;
    services.udisks2.enable = cfg.enable;
    boot.supportedFilesystems = [ "ntfs" ];
  };
}
