{lib, config, pkgs, ...}:
let
  cfg = config.networkTools;

  basicPkgs= {
    free = with pkgs; [
      nmap
      dig
      # More stuff later
    ];

    unfree = [];
  };

  apiPkgs = {
    free = with pkgs; [
      insomnia
    ];

    unfree = with pkgs; [
      postman
      charles3
    ];
  };

  reversePkgs = {
    free = with pkgs; [
      wireshark
    ];

    unfree = [];
  };

  freePkgs = (basicPkgs.free ++ apiPkgs.free ++ reversePkgs.free);
  unfreePkgs = (basicPkgs.unfree ++ apiPkgs.unfree ++ reversePkgs.unfree);

in
with lib; {
  options.networkTools = {
    enable = mkEnableOption "Gives a usefull list of networking tools";
    
    basic.enable = mkOption {
        default = true;
	type = types.bool;
	description = "Gives basic tools to manage networks";
    };

    api.enable = mkOption {
        default = true;
	type = types.bool;
	description = "Tools to reverse engineer APIs";
    };

    reverse.enable = mkOption {
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
      default = [];
      description = "Exclude specific packages from the install";
    };
  };

  config = {
    home.packages = lists.subtractLists cfg.exclude (if cfg.allowUnfree then (freePkgs ++ unfreePkgs) else freePkgs); 
  };
}
