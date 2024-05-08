{config, pkgs, ...}:
{
  config = {
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
