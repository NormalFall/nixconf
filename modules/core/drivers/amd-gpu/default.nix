{config, pkgs, lib, ...}: 
let
  cfg = config.drivers.amd-gpu;
in with lib; {
  options.drivers.amd-gpu = {
    enable = mkEnableOption "Enables all utils for an amd GPU";
    statusTool = mkEnableOption "Enables NVTOP" // { default = true; };
    rocm = mkEnableOption "Enables rocm";
  };

  config = mkIf cfg.enable {
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    # Enables ROCM
    systemd.tmpfiles.rules = mkIf cfg.rocm [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    environment.systemPackages = mkIf cfg.statusTool [ pkgs.nvtopPackages.amd ];
  };
}
