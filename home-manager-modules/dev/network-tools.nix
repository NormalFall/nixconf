{ lib, config, pkgs, ... }:
let
  cfg = config.dev.networkTools;

  basicPkgs = {
    free = with pkgs; [
      nmap
      dig
      # More stuff later
    ];

    unfree = [ ];
  };

  apiPkgs = {
    free = with pkgs; [ insomnia ];

    unfree = with pkgs; [ postman charles3 ];
  };

  sniffPkgs = {
    free = with pkgs; [ wireshark ];

    unfree = [ ];
  };

in with lib; {
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

    sniff = mkOption {
      default = true;
      type = types.bool;
      description = "Advanced tool to check network traffic";
    };

    allowUnfree = mkOption {
      default = true;
      type = types.bool;
      description = "Enables unfree packages";
    };

    exclude = mkOption {
      default = [ ];
      description = "Exclude specific packages from the install";
    };
  };

  config = mkIf cfg.enable {
    home.packages = lists.subtractLists cfg.exclude ((if cfg.basic then
      (if cfg.allowUnfree then basicPkgs.unfree else [ ]) ++ basicPkgs.free
    else
      [ ]) ++ (if cfg.api then
        (if cfg.allowUnfree then apiPkgs.unfree else [ ]) ++ apiPkgs.free
      else
        [ ]) ++ (if cfg.sniff then
          (if cfg.allowUnfree then sniffPkgs.unfree else [ ]) ++ sniffPkgs.free
        else
          [ ]));
  };
}
