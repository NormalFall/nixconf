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
	(modules + /kde)
        (bundles + /base-packages.nix)
        (bundles + /fonts.nix)
	(modules + /greetd)
	(bundles + /nice-settings.nix)
	(modules + /main-user)
      ];
  
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
  
    networking = {
      hostName = "nixos-in-qemu"; 
      networkmanager.enable = true;
    };

    niceSettings.enable = true;
  
    kde.enable = true;

    greetd = {
      enable = true;
      command = "startplasma-wayland";
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

    services.openssh.enable = true;
  
    system.stateVersion = "23.11"; 
  }
