{lib, config, pkgs, ...}:
let
  cfg = config.files.fileManager;
in with lib; {
  options.files.fileManager.enable = 
    mkEnableOption "Enable nautilus as default filemanager";
  
  config = mkIf cfg.enable {
    home.packages = [ pkgs.nautilus ];

    xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  };
}
