{lib, config, ...}:
let
  cfg = config.terminal;
in with lib; {
  options.terminal.enableAll = mkOption { default = true; };
  imports = [
    ./kitty
    ./nixvim
    ./zsh
    ./nh
  ];

  config.terminal = mkIf cfg.enableAll {
    kitty.enable = mkDefault true;
    nixvim.enable = mkDefault true;
    zsh.enable = mkDefault true;
    nh.enable = mkDefault true;
  };
}
