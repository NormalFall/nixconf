{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.terminal.kitty;
in
with lib;
{
  options.terminal.kitty = {
    enable = mkEnableOption "Enables kitty terminal";
    opacity = mkOption {
      default = 1;
      description = "Kitty opacity";
    };
  };

  imports = [ ../../core/main-user ];

  config.mainUser.modules = [
    ({...} : {
      programs.kitty = {
        enable = true;
        settings = {
          font_family = "JetBrainsMono";
          copy_on_select = "yes";
          cursor_shape = "block";
          cursor_blink_interval = 0;
          enable_audio_bell = "no";
          shell = "zsh";
          editor = "nvim";
          background_opacity = builtins.toString cfg.opacity;
        };
      };
    })
  ];
}
