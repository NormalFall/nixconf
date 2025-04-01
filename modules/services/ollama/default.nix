{config, lib, ...}:
let
  cfg = config.ollama;
in with lib; {
  options.ollama.enable = mkEnableOption "Enables ollama with rocm support" // { default = true; };
  config.services.ollama = mkIf cfg.enable {
    enable = true;
    acceleration = "rocm";

    environmentVariables = {
      ROCM_PATH = "/opt/rocm";
      AMD_SERIALIZE_KERNEL = "3";
      ROCR_VISIBLE_DEVICES = "0";
    };

    rocmOverrideGfx = "10.3.0"; # needed for rx 6600 support
  };
}
