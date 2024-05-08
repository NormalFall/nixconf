{config, pkgs, ...}:
{
  config = {
    environment.systemPackages = with pkgs; [
      fastfetch
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
