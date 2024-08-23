{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.files.media;
in
with lib;
{
  options.files.media = {
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
      (
        if cfg.images.enable then
          [ pkgs.gthumb ] ++ (if (cfg.images.editor && cfg.editors) then [ pkgs.gimp ] else [ ])
        else
          [ ]
      )
      ++ (
        if cfg.video.enable then
          [ pkgs.mpv ]
          ++ (
            if (cfg.video.editor && cfg.editors) then
              [
                pkgs.kdenlive
                pkgs.ffmpeg
              ]
            else
              [ ]
          )
        else
          [ ]
      )
      ++ (
        if cfg.audio.enable then
          [ pkgs.rhythmbox ] ++ (if (cfg.audio.editor && cfg.editors) then [ pkgs.audacity ] else [ ])
        else
          [ ]
      );

    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/png" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/gif" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/bmp" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/webp" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/x-xpixmap" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/x-portable-bitmap" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/x-portable-graymap" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/x-portable-pixmap" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/tiff" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/x-xcf" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/vnd.adobe.photoshop" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/svg+xml" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";
      "image/avif" = mkIf cfg.images.enable "org.gnome.gThumb.desktop";

      "video/mp4" = mkIf cfg.video.enable "mpv.desktop";
      "video/x-msvideo" = mkIf cfg.video.enable "mpv.desktop";
      "video/avi" = mkIf cfg.video.enable "mpv.desktop";
      "video/x-matroska" = mkIf cfg.video.enable "mpv.desktop";
      "video/webm" = mkIf cfg.video.enable "mpv.desktop";
      "video/x-flv" = mkIf cfg.video.enable "mpv.desktop";
      "video/3gpp" = mkIf cfg.video.enable "mpv.desktop";
      "video/3gpp2" = mkIf cfg.video.enable "mpv.desktop";
      "video/x-ms-wmv" = mkIf cfg.video.enable "mpv.desktop";
      "video/mpeg" = mkIf cfg.video.enable "mpv.desktop";
      "video/ogg" = mkIf cfg.video.enable "mpv.desktop";

      "audio/mpeg" = mkIf cfg.audio.enable "org.gnome.Rhythmbox3.desktop";
      "audio/x-wav" = mkIf cfg.audio.enable "org.gnome.Rhythmbox3.desktop";
      "audio/x-flac" = mkIf cfg.audio.enable "org.gnome.Rhythmbox3.desktop";
    };
  };
}
