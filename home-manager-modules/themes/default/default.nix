{lib, pkgs, config, ...}:
let
  Modules = ../..;
in
  {
    imports = [
      (Modules + /window-manager/hyprland)
      (Modules + /window-manager/waybar)
      (Modules + /terminal/kitty)
      (Modules + /terminal/zsh)
    ];

    config = {
      hyprland = {
        wallpaper = lib.mkDefault ./nixos.png;
        theme = import ./hyprland.nix;
        extraKeybinds = [ "SUPER,R,exec,${pkgs.nwg-drawer}/bin/nwg-drawer" ];
      };

      # nwg-drawer config
      home.file = {
        ".config/nwg-drawer/drawer.css".source = ./nwg-drawer.css;
      };

      waybar.enable = true;
      waybar.config = ./Waybar/config.jsonc;
      waybar.style = ./Waybar/style.css;

      kitty.opacity = 0.35;

      zsh.theme = "agnoster";

      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
        style.package = pkgs.adwaita-qt;
      };
    };
  }
