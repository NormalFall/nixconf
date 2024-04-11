{lib, config, pkgs, ...}:
let
  cfg = config.waybar;
  cfgDir = ".config/waybar";
in
with lib; {
  options.waybar = {
    enable = mkEnableOption "Enables waybar";
    configuration = mkOption {
      default = ./config;
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
    home.packages = [pkgs.waybar] ++ cfg.deps;
    home.file = if !(cfg.configuration == null || cfg.style == null) then {
      ${cfgDir + "/config"}.source = cfg.configuration;
      ${cfgDir + "/style.css"}.text = 
        (builtins.readFile cfg.style) + (if colors != null then ("\n" + (builtins.readFile cfg.colors)) else "");
    } // (if (cfg.scripts != null) then { ${cfgDir + "config"}.source = cfg.scripts; } else {}) else {};
  };
}
