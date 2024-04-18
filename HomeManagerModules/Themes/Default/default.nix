{lib, config, ...}:
let
  Modules = ../..;
in
  {
    imports = [
      (Modules + /WindowManager/Hyprland)
      (Modules + /WindowManager/Waybar)
      (Modules + /Terminal/Kitty)
      (Modules + /Terminal/Zsh)
    ];

    config = {
      hyprland = {
        wallpaper = lib.mkDefault ./nixos.png;
        theme = import ./hyprland.nix;
      };

      waybar.config = ./Waybar/config.jsonc;
      waybar.style = ./Waybar/style.css;

      kitty.opacity = 0.35;

      zsh.theme = "agnoster";
    };
  }
