{ pkgs, ... }:
{
  imports = [ ../../core/main-user ];

  config.mainUser.modules = [
    ({...} : {
      qt = {
        enable = true;
        style.name = "adwaita-dark";
      };
    })
  ];
}
