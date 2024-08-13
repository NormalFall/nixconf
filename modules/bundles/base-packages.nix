{ config, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      fastfetch
      neovim
      tree
      fd
      git
      gdu
      firefox
      btop
      killall
      nh
    ];
  };
}
