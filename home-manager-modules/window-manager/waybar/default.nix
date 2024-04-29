{lib, config, pkgs, ...}:
let
  cfg = config.waybar;
  cfgDir = "~/.config/waybar";
in
with lib; {
  options.waybar = {
    enable = mkEnableOption "Enables waybar";

    config = mkOption {
      default = null;
      description = "config.jsonc configuaration file";
    };

    style = mkOption {
      default = null;
      description = "style.css configuaration file";
    };

    colors = mkOption {
      default = null;
      description = "Color scheme in a css file or in plain text";
    };

    scripts = mkOption {
      default = null;
      description = "Folder containing the waybar scripts";
    };

    deps = mkOption {
      default = [];
      description = "Dependecies for the scripts";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.waybar ] ++ cfg.deps;
    home.file = if (cfg.config != null && cfg.style != null) then {
      ".config/waybar/config".source = cfg.config;
      ".config/waybar/style.css".text = 
        (builtins.readFile cfg.style) + (if cfg.colors != null then ("\n" + (builtins.readFile cfg.colors)) else "");
    } // (if (cfg.scripts != null) then { ${cfgDir + "/scripts"}.source = cfg.scripts; } else {}) else {};
  };
}
