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
	(Modules + "/Kde")
	(Modules + /Syncthing)
        (Bundles + /BasePackages.nix)
	(Modules + /Greetd)
	(Bundles + /NiceSettings.nix)
	(Modules + /MainUser)
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
