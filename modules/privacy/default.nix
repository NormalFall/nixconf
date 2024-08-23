{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.privacy;
in
with lib;
{
  options.privacy = {
    enable = mkOption { default = true; };
    mullvad = mkOption {
      default = true;
      description = "Enables mullcad common packages";
    };

    browsers = mkOption {
      default = true;
      description = "Enables Browsers";
    };
  };

  config = mkIf cfg.enable {
    programs.openvpn3.enable = true;
    environment.systemPackages =
      with pkgs;
      [
        wireguard-tools
        v2raya
      ]
      ++ (if cfg.mullvad then [ mullvad-closest ] else [ ])
      ++ (
        if cfg.browsers then [ tor-browser ] ++ (if cfg.mullvad then [ mullvad-browser ] else [ ]) else [ ]
      );
    services.mullvad-vpn.enable = cfg.mullvad;
  };
}
