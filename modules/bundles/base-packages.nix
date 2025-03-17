{ config, pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      fastfetch
      vim
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
