{
  lib,
  config,
  pkgs,
  customPkgs,
  ...
}:
let
  cfg = config.dev.vscodium;

  extensions = with pkgs.vscode-extensions; [
    # Rust
    rust-lang.rust-analyzer
    serayuzgur.crates

    #Nix
    jnoortheen.nix-ide

    #Python
    ms-python.python

    # Web
    ritwickdey.liveserver
    gencer.html-slim-scss-css-class-completion

    # Configs
    zainchen.json
    redhat.vscode-yaml
    bungcip.better-toml
    yzhang.markdown-all-in-one

    # Quality of life
    esbenp.prettier-vscode
  ];
in
with lib;
{
  options.dev.vscodium = {
    enable = mkEnableOption "Enables vscodium";

    code-shell.enable = mkEnableOption "Enables code-shell" // { default = true; };
    # Add theme options later
  };

  imports = [
    ../../core/main-user
  ];

  config = mkIf cfg.enable {
    # Make sure its installed systemwide
    environment.systemPackages = [ pkgs.vscodium ] 
      ++ (if cfg.code-shell.enable then [ customPkgs.code-shell ] else []);
    
    mainUser.modules = [
      ({...} : {
        programs.vscode = {
          package = pkgs.vscodium;
          enable = true;

          profiles.default = {
            enableUpdateCheck = false;
            enableExtensionUpdateCheck = false;

            userSettings = {
              "window.titleBarStyle" = "custom";
            };

            inherit extensions;
          };
        };
      })
    ];
  };
}
