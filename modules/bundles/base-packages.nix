{ config, pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      fastfetch
      neovim
      tree
      fd
      git
      gdu
      btop
      killall
      nh
      nixfmt-rfc-style
    ];
  };
}
