{config, lib, ...}:
let
  cfg = config.ollama;
in with lib; {
  options.ollama ={
    enable = mkEnableOption "Enables ollama with rocm support" // { default = true; };
    withAMD = mkEnableOption "Setups ollama to use a RX 6600";
    enableUI = mkEnableOption "enables open-webui" // { default = true; };
  };

  config.services = {
    ollama = mkIf cfg.enable {
      enable = true;
      acceleration = mkIf cfg.withAMD "rocm";

      environmentVariables = mkIf cfg.withAMD {
        ROCM_PATH = "/opt/rocm";
        AMD_SERIALIZE_KERNEL = "3";
        ROCR_VISIBLE_DEVICES = "0";
      };

      rocmOverrideGfx = mkIf cfg.withAMD "10.3.0"; # needed for rx 6600 support
    };
    open-webui.enable = cfg.enableUI;
  };
}
