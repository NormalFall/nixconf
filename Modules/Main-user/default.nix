{ lib, config, pkgs, inputs, ... }:

let
  cfg = config.main-user;
in
with lib; {
  options.main-user = {
    enable = mkEnableOption "enable user module";

    home-manager = mkEnableOption "enables home-manager for main user";

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
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.${cfg.shell};
    };

    home-manager = mkIf cfg.home-manager {
      extraSpecialArgs = {
        inherit (cfg) userName;
        inherit inputs;
      };

      users.${cfg.userName} = import ../../Users/Main/home.nix;
    };
  };
}
