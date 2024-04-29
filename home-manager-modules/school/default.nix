{config, pkgs, ...}:
{
  config = {
    home.packages = [ pkgs.inkscape ];
  };
}
