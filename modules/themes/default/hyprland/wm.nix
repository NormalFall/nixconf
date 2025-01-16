{
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
    bezier = [ "myBezier,0.22, 1, 0.36, 1" ];
    animation = [
      "windows, 1, 5, myBezier, popin"
      "workspaces,1,8,myBezier,slidevert"
    ];
  };

  layerrule = [ "blur,gtk-layer-shell" ];
}
