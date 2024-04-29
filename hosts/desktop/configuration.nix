{ config, pkgs, ... }:
let
  mainUser = "normal";
  modules = ../../modules;
  bundles = modules + "/bundles";
in
  {
    imports =
      [ 
        ./hardware-configuration.nix
	(modules + /pipewire)
        (modules + /gaming)
        (bundles + /base-packages.nix)
        (bundles + /fonts.nix)
	(modules + /greetd)
	(bundles + /nice-settings.nix)
	(modules + /main-user)
        (modules + /privacy)
        (modules + /drivers)
      ];
  
    # Use systemd for usb boot
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = true;
    
    pipewire.enable = true;
  
    networking = {
      hostName = "snowFlakeThe5th";
      networkmanager.enable = true;
    };

    drivers.logitech.enable = true;

    niceSettings.enable = true;

    gaming.enable = true;

    privacy.enable = true;

    greetd = {
      enable = true;
      command = "Hyprland";
      greeter = "tuigreet";
    };

    basePkgs.enable = true;

    mainUser = {
      enable = true;
      homeManager = {
        enable = true;
	config = ./home.nix;
      };
      userName = mainUser;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    system.stateVersion = "23.11"; 
  }
