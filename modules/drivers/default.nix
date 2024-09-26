{
  lib,
  config,
  ...
}:
let
  cfg = config.drivers;
in
with lib;
{
  options.drivers = {
    enable = mkEnableOption "Enables all common drivers" // {default = true;};
    wireless.enable = mkEnableOption "Enables common wireless drivers" // {default = true;};
    laptop.enable = mkEnableOption "Enables common laptop services";
  };

  imports = [
    ./disk.nix
    ./peripherals.nix
    ./bluetooth.nix
    ./laptop/power-management.nix
  ];

  config = mkIf cfg.enable {
    drivers.disk.enable = mkDefault true;

    drivers.bluetooth.enable = mkDefault config.drivers.wireless.enable;

    drivers.power-management.enable = mkDefault config.drivers.laptop.enable;
  };
}
