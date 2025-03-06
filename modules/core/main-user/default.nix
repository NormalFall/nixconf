{
  lib,
  config,
  pkgs,
  inputs,
  customPkgs,
  userName,
  ...
}:

let
  cfg = config.mainUser;
in
with lib;
{
  options.mainUser = {
    enable = mkOption { default = true; };

    modules = mkOption {
      default = [];
      description = "Imports for home manager";
    };

    groups = mkOption {
      default = [];
      description = "groups to add to the main user";
    };

    shell = mkOption {
      default = pkgs.zsh;
      description = "default shell";
    };

    userName = mkOption {
      default = "user";
      description = "username";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.shell ];
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = cfg.groups ++ [ "wheel" ];
      ignoreShellProgramCheck = true;
      shell = cfg.shell;
    };


    home-manager = {
      backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
      extraSpecialArgs = {
        inherit inputs;
        inherit customPkgs;
        inherit (cfg) userName modules;
      };

      users.${cfg.userName} = ./home.nix;
    };
  };
}
