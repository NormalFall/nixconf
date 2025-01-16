{
  lib,
  config,
  pkgs,
  ...
}:
let

  cfg = config.dev.networkTools;

  basicPkgs = {
    pkgs = with pkgs; [
      nmap
      dig
      # More stuff later
    ];

    conf = {};
  };

  apiPkgs = {
    pkgs = with pkgs; [
      insomnia
      postman
      charles
    ];
    
    conf = {
      # wireshark
      programs.wireshark.package = lib.mkDefault pkgs.wireshark;
      programs.wireshark.enable = lib.mkDefault true;
      mainUser.groups = lib.mkIf config.programs.wireshark.enable [ "wireshark" ];
    };
  };
in
with lib;
{
  options.dev.networkTools = {
    enable = mkEnableOption "Gives a usefull list of networking tools";

    basic = mkOption {
      default = true;
      type = types.bool;
      description = "Gives basic tools to manage networks";
    };

    api = mkOption {
      default = true;
      type = types.bool;
      description = "Tools to reverse engineer APIs";
    };

    allowUnfree = mkOption {
      default = true;
      type = types.bool;
      description = "Enables unfree packages";
    };

    # todo: remove the exclude option or find alternative
    exclude = mkOption {
      default = [ ];
      description = ''Exclude specific packages from the install from the lists.
      Packages that are installed with options must be disabled with there respective options'';
    };
  };

  imports = [
    ../../core/main-user # add user to wireshark group
  ];

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = lists.subtractLists cfg.exclude (
        (if cfg.basic then basicPkgs.pkgs else [ ])
        ++ (if cfg.api then apiPkgs.pkgs else [ ])
      );
    }
    apiPkgs.conf
    basicPkgs.conf
  ]);
}
