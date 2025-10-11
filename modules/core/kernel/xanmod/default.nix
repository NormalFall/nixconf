{lib, config, pkgs, ...}: 
let
  cfg = config.xanmod;
in with lib; {
  options.xanmod = {
    enable = mkEnableOption "Enables xanmod with some settings" // { default = true; };
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_xanmod;
  };
}
