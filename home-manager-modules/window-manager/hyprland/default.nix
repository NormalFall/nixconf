{lib, config, ...}:
let
  cfg = config.hyprland;
in with lib; {
  options.hyprland.enable = mkEnableOption "Enables Hyprland's ecosystem" // {default = true;};

  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  config = mkIf cfg.enable {
    hyprland.wm.enable = mkDefault true;
    hyprland.idle.enable = mkDefault true;
    hyprland.lock.enable = mkDefault true;
  };
}
