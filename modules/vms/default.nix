{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.vms;
in
with lib;
{
  options.vms.enable = mkOption { default = true; };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;
  };
}
