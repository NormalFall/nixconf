{lib, config, pkgs, ...}:
let
  cfg = config.basePkgs;
in
with lib; {
  options.basePkgs.enable = mkEnableOption "Install basic packages to manage linux";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
      neovim
      tree
      git
      gdu
      firefox
      btop
      killall
    ];
  };
}
