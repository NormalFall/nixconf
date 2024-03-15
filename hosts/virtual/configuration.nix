{ config, pkgs, ... }:
let
  mainUser = "normal";
  Modules = ../../Modules;
  Bundles = Modules + "/bundles";
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
	(Modules + /Main-user)
      ];
  
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
  
    networking = {
      hostName = "nixos-in-qemu"; 
      networkmanager.enable = true;
    };

    niceSettings.enable = true;
  
    kde.enable = true;

    basePkgs.enable = true;

    main-user = {
      enable = true;
      home-manager = true;
      userName = mainUser;
    };

    services.openssh.enable = true;
  
    system.stateVersion = "23.11"; 
  }
