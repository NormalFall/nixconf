{
  general = {
    gaps_in = 11;
    gaps_out = 15;
    border_size = 1;
  };

  decoration = {
    rounding = 15;
    blur.enabled = true;
  };

  animations = {
    enabled = true;

    bezier = [
      "Overshoot,0.05,0.9,0.1,1.1"
    ];

    animation = [
      "windows, 1, 5, Overshoot, slide"
      "windowsOut, 1, 7, Overshoot, popin 80%"
      "workspaces, 1, 6, Overshoot, slidevert"
    ];
  };
}
