{ lib, ... }:
{
  imports = [
    ../../../core/hyprland/wm
    ../../../core/hyprland/lock.nix
  ];

  config = {
    hyprland.wm = {
      wallpaper = lib.mkDefault ../nixos.png;
      theme = import ./wm.nix;
    };

    hyprland.lock.theme = import ./lock.nix;
  };
}
