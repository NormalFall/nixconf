{ pkgs, ... }:
{
  imports = [
    ../../core/hyprland
    ./zsh.nix
    ./kitty.nix
    ./hyprland
    ./nwg-drawer
    ./waybar
    ./dunst.nix
    ./gtk.nix
    ./qt.nix
  ];

  config = {
    hyprland.wm.extraKeybinds = [ "SUPER,R,exec,${pkgs.nwg-drawer}/bin/nwg-drawer" ];
  };
}
