{lib, config, pkgs, inputs, ...}:
let
  cfg = config.compat-tools;
in with lib; {
  options.compat-tools = {
    enable = mkOption {
      default = true; 
      description = "enables tools to support unpatched binaries";
    };

    appimage = mkOption {
      default = true; 
      description = "Tools to run unpatched .appimage";
    };

    nix-alien = mkOption {
      default = true; 
      description = "uses nix-alien to run unpatched binaries";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      (if cfg.appimage then [ pkgs.appimage-run ] else [])
      ++ (if cfg.nix-alien then [ inputs.nix-alien.packages.x86_64-linux.nix-alien ] else []);

    programs.nix-ld.enable = cfg.nix-alien;
  };
}
