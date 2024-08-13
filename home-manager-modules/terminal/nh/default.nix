{ lib, config, pkgs, userName, ... }:
let cfg = config.terminal.nh;
in with lib; {
  options.terminal.nh = {
    enable = mkEnableOption "Enable nh";
    flake = mkOption {
      default = "/home/${userName}/.nixconf";
      description = "Nixos flake path";
    };
  };

  config.home = mkIf cfg.enable {
    packages = [ pkgs.nh ];
    sessionVariables = { FLAKE = cfg.flake; };
  };
}
