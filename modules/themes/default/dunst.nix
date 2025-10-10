{ config, ... }:
{
  imports = [ ../../core/main-user ];
  config.mainUser.modules = [
    ({...} : {
      services.dunst.enable = true;
      services.dunst.settings = {
        global = {
          follow = "mouse";
          indicate_hidden = "yes";
          shrink = "no";

          padding = 8;
          horizontal_padding = 8;
          frame_width = 1;
          frame_color = "#31363b";
          sort = "yes";
          font = "Mononoki Nerd Font 12";
          markup = "full";

          format = ''
            <b>%a</b>
            <i>%s</i>
            %b'';
          corner_radius = 7;
          icon_corner_radius = 4;
          min_icon_size = 200;
          width = 500;

          idle_threshold = 120;
          ignore_dbusclose = true;
        };

        urgency_low.timeout = 10;

        urgency_normal = {
          background = "#232629";
          foreground = "#eff0f1";
          timeout = 30;
        };

        urgency_critical = {
          background = "#232629";
          foreground = "#1f2124";
        };
      };
    })
  ];
}
