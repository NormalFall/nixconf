{
  general = {
    gaps_in = 10;
    gaps_out = 10;

    border_size = 3;
    "col.inactive_border" = "0x44404142";
    "col.active_border" = "0x77466494";
  };

  decoration = { rounding = 10; };

  animations = {
    bezier = [ "overshot,0.05,0.9,0.1,1.1" ];
    animation = [ "workspaces,1,8,overshot,slidevert" ];
  };

  layerrule = [ "blur,gtk-layer-shell" ];
}
