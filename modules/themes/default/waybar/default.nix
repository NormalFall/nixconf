{ ... }:
{
  imports = [ ../../../core/main-user ];

  config.mainUser.modules = [
    ({...} : {
      programs.waybar = {
        enable = true;
        settings = (import ./config.nix);
        style = ./style.css;

        systemd.enable = true;
      };
    })
  ];
}
