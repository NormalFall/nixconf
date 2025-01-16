{
  config,
  pkgs,
  lib,
  userName,
  modules,
  ...
} : {
  imports = modules;
  
  nixpkgs.config.allowUnfree = true;

  xdg.mimeApps.enable = true;
  home.stateVersion = "23.11";
}