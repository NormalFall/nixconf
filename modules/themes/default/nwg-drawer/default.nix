{ lib, config, ... }:
{
  imports = [ ../../../core/main-user ];
  config.mainUser.modules = [({...} : {home.file.".config/nwg-drawer/drawer.css".source = ./nwg-drawer.css;})];
}
