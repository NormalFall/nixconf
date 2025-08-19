{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.files.compression;
in
with lib;
{
  options.files.compression.enable = mkEnableOption "Enables common compression cli tools";

  config.environment.systemPackages = with pkgs; [
    unzip
    gnutar
    unrar
    p7zip
  ];
}
