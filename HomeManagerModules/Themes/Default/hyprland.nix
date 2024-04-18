{
  hyprland = {
    general = {
      gaps_in = 10;
      gaps_out = 10;

      border_size = 3;
      "col.inactive_border" = "0x44404142";
      "col.active_border" = "0x77466494";
    };

    decoration = {
      rounding = 10;
    };

    animations = {
      bezier = [ "overshot,0.05,0.9,0.1,1.1" ];
      animation = [
        "workspaces,1,8,overshot,slidevert"
      ];
    };

    layerrule = [];
  };

  hyprlock = {
    general = {
      no_fade_in = false;
      grace = 0;
      disable_loading_bar = true;
    };

    input-fields = [
      {
        size = { width = 250; height = 60; };
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
        hide_input = false;
        position = { x = 0; y = -120; };
        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
        font_size = 120;
        font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
        position = { x = 0; y = -300; };
        halign = "center";
        valign = "top";
      }
      {
        text = "Hi there, $USER";
        font_size = 25;
        font_family = "JetBrains Mono Nerd Font Mono";
        position = { x = 0; y = -40; };
        halign = "center";
        valign = "center";
      }
    ];

    backgrounds = [
      {
        path = "screenshot";
        blur_passes = 1;
      }
    ];
  };
}
