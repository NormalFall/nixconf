{lib, config, pkgs, ...}:
let
  cfg = config.hyprland.wm.plugins.expo;
in with lib; {
  options.hyprland.wm.plugins.expo.enable = mkEnableOption "Enables hyprexpo plugin" // {default = true;};

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      plugins = [pkgs.hyprlandPlugins.hyprexpo];
      settings = {
        bind = ["SUPER, W, hyprexpo:expo, toggle"];
        plugin.hyprexpo = {
          columns = 3;
          workspace_method = "center current";
        };
      };
    };
  };
}
