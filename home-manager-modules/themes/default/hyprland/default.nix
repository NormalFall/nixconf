{lib, ...}:
{
  imports = [
    ../../../window-manager/hyprland/wm
    ../../../window-manager/hyprland/lock.nix
  ];
  
  config = {
    hyprland.wm = {
      wallpaper = lib.mkDefault ../nixos.png;
      theme = import ./wm.nix;
    };

    hyprland.lock.theme = import ./lock.nix;
  };
}
