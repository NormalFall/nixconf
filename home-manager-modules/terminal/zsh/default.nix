{ lib, config, pkgs, ... }:
let cfg = config.terminal.zsh;
in with lib; {
  options.terminal.zsh = {
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
        test = "nh os test -H ${cfg.host}";
        update = "nh os switch -H ${cfg.host}";
        upgrade = "update --update";
        edit = "nvim $FLAKE";
      };

      oh-my-zsh = {
        enable = true;
        theme = cfg.theme;
      };

      history.size = 10000;
    };
  };
}
