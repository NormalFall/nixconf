{ config, pkgs, ... }:
let
  mainUser = "normal";
  Modules = ../../Modules;
  Bundles = Modules + "/Bundles";
in
  {
    imports =
      [ 
        ./hardware-configuration.nix
	(Modules + /Pipewire)
        (Modules + /Gaming)
        (Bundles + /BasePackages.nix)
        (Bundles + /Fonts.nix)
	(Modules + /Greetd)
	(Bundles + /NiceSettings.nix)
	(Modules + /MainUser)
        (Modules + /Privacy)
        (Modules + /Drivers)
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

    pipewire.enable = true;
  
    networking = {
      hostName = "NixfoSum";
      networkmanager.enable = true;
    };

    drivers.laptop.enable = true;
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
