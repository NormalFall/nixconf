{ pkgs, ... }:
let
  Modules = ../..;
in
{
  imports = [
    (Modules + /window-manager/hyprland)
    (Modules + /terminal/kitty)
    (Modules + /terminal/zsh)

    ./hyprland
    ./nwg-drawer
    ./waybar
    ./dunst.nix
    ./zsh.nix
    ./kitty.nix
    ./gtk.nix
    ./qt.nix
  ];

  config.hyprland.wm.extraKeybinds = [ "SUPER,R,exec,${pkgs.nwg-drawer}/bin/nwg-drawer" ];
}
