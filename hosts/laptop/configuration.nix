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
	(Modules + /Syncthing)
	(Modules + /Pipewire)
        (Modules + /Gaming)
        (Bundles + /BasePackages.nix)
        (Bundles + /Fonts.nix)
	(Modules + /Greetd)
	(Bundles + /NiceSettings.nix)
	(Modules + /MainUser)
      ];
  
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1200x750";
        font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
        fontSize = 36;
      };
    };

    pipewire.enable = true;
  
    networking = {
      hostName = "NixfoSum";
      networkmanager.enable = true;
    };

    niceSettings.enable = true;

    gaming.enable = true;

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
  
    system.stateVersion = "23.11"; 
  }
