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
    (bundles + /base-packages.nix)
    (bundles + /fonts.nix)
    (bundles + /nice-settings.nix)
    (apps + /misc)
    (apps + /school)
    (apps + /privacy)
    (apps + /gaming)
    (apps + /files)
    (apps + /compat-tools)
    (apps + /dev)
    (apps + /privacy)
    (apps + /terminal)
    (apps + /utilities)
    (themes + /default)
  ];

  # Use systemd for usb boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "DaUSB";
    networkmanager.enable = true;
  };

  greetd = {
    command = "Hyprland";
    greeter = "${pkgs.tuigreet}/bin/tuigreet";
  };

  hyprland = {
    wm.monitors = [ "auto, highrr,0x0,1" ];
    wm.gdkScale = 1.5;
    idle.enable = true;
    idle.dimTime = 100;
  };

  mainUser.userName = mainUser;

  terminal.zsh.host = "usb";

  system.stateVersion = "23.11";
}
