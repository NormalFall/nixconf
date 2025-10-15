{lib, pkgs, config, ...}: 
let
  cfg = config.dev.common-compilers;
in with lib; {
  options.dev.common-compilers.enable = mkEnableOption "Adds compillers and runtimes I commonly use";
  # Put all commonly used compillers/runtimes here
  config.environment.defaultPackages = with pkgs; mkIf cfg.enable [
    cargo # Rust
    python314
  ];
}
