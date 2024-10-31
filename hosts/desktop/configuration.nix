{ config, pkgs, ... }:
let
  mainUser = "normal";
  modules = ../../modules;
  bundles = modules + "/bundles";
in
{
  imports = [
    ./hardware-configuration.nix
    (bundles + /base-packages.nix)
    (bundles + /fonts.nix)
    (bundles + /nice-settings.nix)
    (modules + /compat-tools)
    (modules + /drivers)
    (modules + /dev)
    (modules + /gaming)
    (modules + /greetd)
    (modules + /main-user)
    (modules + /pipewire)
    (modules + /privacy)
    (modules + /vms)
  ];

  # Use systemd for usb boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "snowFlakeThe6th";
    networkmanager.enable = true;
  };

  drivers.peripherals.logitech.enable = true;

  greetd = {
    command = "Hyprland";
    greeter = "tuigreet";
  };

  mainUser = {
    homeManager = {
      enable = true;
      config = ./home.nix;
    };
    userName = mainUser;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "23.11";
}
