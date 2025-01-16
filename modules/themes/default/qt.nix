{ pkgs, ... }:
{
  imports = [ ../../core/main-user ];

  config.mainUser.modules = [
    ({...} : {
      qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
        style.package = pkgs.adwaita-qt;
      };
    })
  ];
}
