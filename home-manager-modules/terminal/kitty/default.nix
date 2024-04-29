{lib, config, pkgs, ...}:
let
  cfg = config.kitty;
in
  with lib; {
    options.kitty = {
      enable = mkEnableOption "Enables kitty terminal";
      opacity = mkOption {
        default = 1;
        description = "Kitty opacity";
      };
    };

    config = {
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
    };
  }
