{ lib, config, pkgs, inputs, ... }:

let
  cfg = config.mainUser;
in
with lib; {
  options.mainUser = {
    enable = mkOption { default = true; };

    homeManager = {
      enable = mkEnableOption "enables home-manager for main user";
      config = mkOption {
	description = "location of your home.nix";
      };
    };

    shell = mkOption {
      default = "zsh";
      description = "default shell";
    };

    userName = mkOption {
      default = "mainuser";
      description = "username";
    };
  };

  config = mkIf cfg.enable {
    programs.${cfg.shell}.enable = true;

    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "dialout"
        "plugdev"
      ];
      shell = pkgs.${cfg.shell};
    };

    home-manager = mkIf cfg.homeManager.enable {
      backupFileExtension = "backup";
      extraSpecialArgs = {
        inherit (cfg) userName;
        inherit inputs;
      };

      users.${cfg.userName} = cfg.homeManager.config;
    };
  };
}
