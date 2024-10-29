{lib, pkgs, config, ...}:
let
  cfg = config.dev.wireshark;
in with lib; {
  options.dev.wireshark.enable = mkEnableOption "Enables wireshark";

  config = mkIf cfg.enable {
    programs.wireshark.package = pkgs.wireshark;
    programs.wireshark.enable = true;
  };
}
