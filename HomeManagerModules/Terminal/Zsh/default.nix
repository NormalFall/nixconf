{lib, config, pkgs, ... }:
let
  cfg = config.zsh;
in
with lib; {
  options.zsh = {
    enable = mkEnableOption "Enables zsh";
    host = mkOption {
      default = null;
      description = "Add the flake profile to the shellAliases`";
    };
    theme = mkOption {
      default = "";
      description = "Gives a oh-my-zsh theme";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      shellAliases = {
        test = "sudo nixos-rebuild test --flake /etc/nixos#${cfg.host}";
        update = "sudo nixos-rebuild switch --flake /etc/nixos#${cfg.host}";
        edit = "sudo -E -s nvim /etc/nixos/";
      };

      oh-my-zsh = {
        enable = true;
        theme = cfg.theme;
      };

      history.size = 10000;
    };
  };
}
