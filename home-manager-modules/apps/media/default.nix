{lib, config, pkgs, ...}:
let
  cfg = config.apps.media;
in with lib; {
  options.apps.media = {
    enable = mkEnableOption "Enables media player for popular format";
    editors = mkEnableOption "Common editors medias";
    images.enable = mkOption { default = true; };
    images.editor = mkOption { default = true; };
    video.enable = mkOption { default = true; };
    video.editor = mkOption { default = true; };
    audio.enable = mkOption { default = true; };
    audio.editor = mkOption { default = true; };
  };

  config = mkIf cfg.enable {
    home.packages =
       (if cfg.images.enable then [ pkgs.gthumb ] ++ (if (cfg.images.editor && cfg.editors) then [ pkgs.gimp ] else []) else [])
    ++ (if cfg.video.enable then [ pkgs.mpv ] ++ (if (cfg.video.editor && cfg.editors) then [ pkgs.kdenlive ] else []) else [])
    ++ (if cfg.audio.enable then [ pkgs.lollypop ] ++ (if (cfg.audio.editor && cfg.editors) then [ pkgs.audacity ] else []) else []);
  };
}
