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
    (core + /hyprland)
    (core + /drivers)
    (core + /pipewire)
    (services + /vms)
    (services + /ollama)
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
    (apps + /cad)
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
    hostName = "snowFlakeThe6th";
    networkmanager.enable = true;
  };

  greetd = {
    command = "Hyprland";
    greeter = "tuigreet";
  };

  hyprland = {
    enable = true;
    idle.enable = false;
    wm.monitors = [ "DP-1, 3440x1440@120,0x0,1" ];
    wm.cursor.size = 30;
  };

  mainUser.userName = mainUser;

  terminal.zsh.host = "desktop";
  files.media.editors = true;
  gaming.extras.slippi.isoPath = "/mnt/nvme/ROMs/GC/ANIMELEE.iso";

  utilities = {
    rgb.enable = true;
    peripherals = {
      logitech.enable = true;
      logitechg.enable = true;
    };
  };

  ollama.withAMD = true;

  system.stateVersion = "23.11";
}
