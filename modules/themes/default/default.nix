{ pkgs, ... }:
{
  imports = [
    ../../core/wms/hyprland
    ../../core/wms/niri
    ./zsh.nix
    ./kitty.nix
    ./hyprland
    ./niri.nix
    ./nwg-drawer
    ./waybar
    ./dunst.nix
    ./gtk.nix
    ./qt.nix
  ];

  config = {
    niri.extraKeybinds."Mod+R".action.spawn = [ "${pkgs.nwg-drawer}/bin/nwg-drawer" ];
    hyprland.wm.extraKeybinds = [ "SUPER,R,exec,${pkgs.nwg-drawer}/bin/nwg-drawer" ];
  };
}
