{lib, pkgs, config, inputs, system, ...}:
let
  cfg = config.misc.zen-browser;
in with lib; {
  options.misc.zen-browser.enable = mkEnableOption "Enables zen-browser default pakcage";

  config.environment.systemPackages = [
    inputs.zen-browser.packages."${system}".default
  ];
}