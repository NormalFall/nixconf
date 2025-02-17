{ pkgs, ... }:
{
  imports = [ ../../core/main-user ];
  config.mainUser.modules  = [
    ({...} : {
      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    })
  ];
}
