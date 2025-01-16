{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.files.fileManager;
in
with lib;
{
  options.files.fileManager.enable = mkEnableOption "Enable nautilus as default filemanager";

  imports = [ ../../core/main-user ];

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nautilus ];

    mainUser.modules = [
      ({...} : { xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop"; })
    ];
  };
}
