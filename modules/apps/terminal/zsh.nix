{
  lib,
  config,
  customPkgs,
  ...
}:
let
  cfg = config.terminal.zsh;
in
with lib;
{
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

  imports = [ ../../core/main-user ];

  config.mainUser.modules = mkIf cfg.enable [
    ({...} : {
      programs.zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;

        shellAliases = {
          # NixOS management
          test = "nh os test -H ${cfg.host}";
          update = "nh os switch -H ${cfg.host}";
          upgrade = "update --update";
          clean = "nh clean all";
          clean-all = "nh clean all";
          edit = "nvim /home/${config.mainUser.userName}/.nixconf/";

          # Nix shell
          cs = "code-shell";

          # Git
          g = "git";
          s = "git status";
          a = "git add";
          d = "git diff";
          ds = "git diff --staged";
          l = "git log";
          commit = "git commit -m";
        };

        oh-my-zsh = {
          enable = true;
          theme = cfg.theme;
        };

        history.size = 10000;
      };
    })
  ];
}
