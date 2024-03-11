# add SOPS later

{lib, config, pkgs, ...}:
let
  cfg = config.syncthing;
in
with lib; {
  options.syncthing = {
    enable = mkEnableOption "Enable Syncthing";

    user = mkOption {
      default = "";
      description = "Sets the syncthing user";
    };

    dataPath = mkOption {
      default = "/home/${cfg.user}/Documents/Sync/";
      description = "Directory that stores the synced documents";
    };

    configPath = mkOption {
      default = "/home/${cfg.user}/.config/Syncthing/";
      description = "Directory for syncthing settings";
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = cfg.enable;
      user = cfg.user;
      dataDir = cfg.dataPath;
      configDir = cfg.configPath;
    };
  };
}
