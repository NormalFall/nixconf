{
  general = {
    no_fade_in = false;
    grace = 0;
    disable_loading_bar = true;
  };

  input-field = [{
    size = "250, 60";
    outline_thickness = 2;
    dots_size = 0.2;
    dots_spacing = 0.2;
    dots_center = true;
    outer_color = "rgba(0, 0, 0, 0)";
    inner_color = "rgba(0, 0, 0, 0.5)";
    font_color = "rgb(200, 200, 200)";
    fade_on_empty = false;
    placeholder_text =
      ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
    hide_input = false;
    position = "0, -120";
    halign = "center";
    valign = "center";
  }];

  label = [
    {
      text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
      font_size = 120;
      font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
      position = "0, -300";
      halign = "center";
      valign = "top";
    }
    {
      text = "Hi there, $USER";
      font_size = 25;
      font_family = "JetBrains Mono Nerd Font Mono";
      position = "0, -40";
      halign = "center";
      valign = "center";
    }
  ];

  background = [{
    path = "screenshot";
    blur_passes = 1;
  }];
}
