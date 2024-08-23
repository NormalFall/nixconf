{
  config,
  pkgs,
  userName,
  ...
}:
let
  modules = ../../home-manager-modules;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    (modules + /themes/default)
    (modules + /cad)
    (modules + /dev)
    (modules + /files)
    (modules + /gaming)
    (modules + /window-manager/hyprland)
    (modules + /terminal)
    (modules + /apps)
    (modules + /utilities)
  ];

  hyprland = {
    wm.monitors = [ "eDP-1, 2880x1800@90,0x0,1.5" ];
    wm.gdkScale = 1.5;
    idle.enable = true;
    idle.dimTime = 100;
  };

  terminal.zsh.host = "laptop";

  files.media.editors = true;

  xdg.mimeApps.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
