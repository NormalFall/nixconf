{ lib, config, pkgs, ... }:
let cfg = config.files.compression;
in with lib; {
  options.files.compression.enable =
    mkEnableOption "Enables common compression cli tools";

  config.home.packages = with pkgs; [ unzip gnutar rar p7zip ];
}
