# This is imported within homeManager
{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      #Apps
      "SUPER,T,exec,${pkgs.kitty}/bin/kitty"
      "SUPER,Q,exec,xdg-open ~"
      "SUPER,A,exec, ${pkgs.libnotify}/bin/notify-send $(${pkgs.hyprpicker}/bin/hyprpicker)"
      "SUPER,F,fullscreen,0"

      #Lock
      "SUPER,L,exec,loginctl lock-session"
      "SUPERSHIFT,L,exec,systemctl sleep"

      #Windows
      "SUPERSHIFT,F,fullscreen,1"
      "SUPER,C,killactive,"
      "SUPERSHIFT,M,exit,"
      "SUPER,V,togglefloating,"
      "SUPERSHIFT,V,pin,"
      "SUPER,P,pseudo,"

      #ScreenShots
      ''ALT,S,exec,${pkgs.swappy}/bin/swappy -f "$(${pkgs.hyprshot}/bin/hyprshot -o /tmp/pictures -zsm output -- echo)"''
      ''ALTSHIFT,S,exec,${pkgs.swappy}/bin/swappy -f "$(${pkgs.hyprshot}/bin/hyprshot -o /tmp/pictures -zsm region -- echo)"''

      #Audio
      ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 5"
      ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 5"
      ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t"

      #Playback
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ",XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous"
      ",XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next"
      "ALT,F9,exec,${pkgs.playerctl}/bin/playerctl previous"
      "ALT,F10,exec,${pkgs.playerctl}/bin/playerctl next"

      #Brightness
      ",XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
      ",XF86MonBrightnessUp,exec,${pkgs.brightnessctl}/bin/brightnessctl s +10%"

      #Aim Focus
      "SUPER,left,movefocus,l"
      "SUPER,right,movefocus,r"
      "SUPER,up,movefocus,u"
      "SUPER,down,movefocus,d"

      #Move workspace to other monitor
      "SUPER,Z,movecurrentworkspacetomonitor,+1"
      "SUPER,X,movecurrentworkspacetomonitor,-1"

      #Workspaces
      "SUPER,1,workspace,1"
      "SUPER,2,workspace,2"
      "SUPER,3,workspace,3"
      "SUPER,4,workspace,4"
      "SUPER,5,workspace,5"
      "SUPER,6,workspace,6"
      "SUPER,7,workspace,7"
      "SUPER,8,workspace,8"
      "SUPER,9,workspace,9"

      #Move window to
      "ALT,1,movetoworkspace,1"
      "ALT,2,movetoworkspace,2"
      "ALT,3,movetoworkspace,3"
      "ALT,4,movetoworkspace,4"
      "ALT,5,movetoworkspace,5"
      "ALT,6,movetoworkspace,6"
      "ALT,7,movetoworkspace,7"
      "ALT,8,movetoworkspace,8"
      "ALT,9,movetoworkspace,9"

      #Mouse window manipulation
      "SUPERSHIFT,up, resizeactive,0 60"
      "SUPERSHIFT,down, resizeactive,0 -60"
      "SUPERSHIFT,left, resizeactive,-60 0"
      "SUPERSHIFT,right, resizeactive,60 0"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
