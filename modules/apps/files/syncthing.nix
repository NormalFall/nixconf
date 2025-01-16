{lib, config, pkgs, ...}: 
let cfg = config.files.syncthing;
in
with lib; {
  options.files.syncthing.enable = mkEnableOption "Enables syncthing";

  imports = [
    ../../core/main-user
  ];

  config.mainUser.modules = [
    ({...} : {
      services.syncthing = {
        enable = cfg.enable;
        tray = {
          enable = true;
          command = "syncthingtray --wait";
        };
      };
    })
  ];
}

