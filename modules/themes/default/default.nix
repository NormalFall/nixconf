{ pkgs, ... }:
{
  imports = [
    ../../core/wms/hyprland
    ../../core/wms/niri
    ./zsh.nix
    ./kitty.nix
    ./hyprland
    ./niri.nix
    ./walker
    ./waybar
    ./dunst.nix
    ./gtk.nix
    ./qt.nix
  ];

  config = {
    niri.extraKeybinds."Mod+R".action.spawn = [ "${pkgs.netcat-openbsd}/bin/nc -U $XDG_RUNTIME_DIR/walker/walker.sock" ];
    hyprland.wm.extraKeybinds = [ "SUPER,R,exec,${pkgs.netcat-openbsd}/bin/nc -U $XDG_RUNTIME_DIR/walker/walker.sock" ];
  };
}
