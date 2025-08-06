{ config, pkgs, ... }:
let
  mainUser = "normal";

  core = ../../modules/core;
  bundles = ../../modules/bundles;
  apps = ../../modules/apps;
  services = ../../modules/services;
  themes = ../../modules/themes;
in
{
  imports = [
    ./hardware-configuration.nix
    (core + /main-user)
    (core + /greetd)
    (core + /wms/hyprland)
    (core + /drivers)
    (core + /pipewire)
    (services + /vms)
    (bundles + /base-packages.nix)
    (bundles + /fonts.nix)
    (bundles + /nice-settings.nix)
    (apps + /misc)
    (apps + /school)
    (apps + /gaming)
    (apps + /files)
    (apps + /dev)
    (apps + /compat-tools)
    (apps + /privacy)
    (apps + /terminal)
    (apps + /utilities)
    (themes + /default)
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  networking = {
    hostName = "NixfoSum";
    networkmanager.enable = true;
  };

  drivers.amd-gpu.enable = true;

  greetd = {
    command = "Hyprland";
    greeter = "tuigreet";
  };

  hyprland = {
    wm.monitors = [ "eDP-1, 1920x1200@90,0x0,1" ];
    wm.gdkScale = 1.5;
    idle.enable = true;
    idle.dimTime = 100;
  };

  drivers.laptop.enable = true;

  mainUser.userName = mainUser;

  terminal.zsh.host = "laptop";
  files.media.editors = true;

  utilities.peripherals = {
    logitech.enable = true;
    logitechg.enable = true;
  };

  system.stateVersion = "23.11";
}
