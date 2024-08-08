{lib, ...}:
{
  imports = [
    ../../../window-manager/hyprland/hyprland.nix
    ../../../window-manager/hyprland/hyprlock.nix
  ];
  
  config = {
    hyprland.wm = {
      wallpaper = lib.mkDefault ../nixos.png;
      theme = import ./wm.nix;
    };

    hyprland.lock.theme = import ./lock.nix;
  };
}
