{pkgs, ...}: {
    mouse = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    key = [
      "SUPER,T,exec,${pkgs.kitty}/bin/kitty"
      "SUPER,C,killactive,"
      "SUPERSHIFT,M,exit,"
      "SUPER,Q,exec,xdg-open ~"
      "SUPER,V,togglefloating,"
      "SUPERSHIFT,V,pin,"
      "SUPER,P,pseudo,"
      "SUPER,A,exec, ${pkgs.libnotify}/bin/notify-send $(${pkgs.hyprpicker}/bin/hyprpicker)"
      "SUPER,F,fullscreen,0"
      "SUPERSHIFT,F,fullscreen,1"
      "SUPER,S,exec,${pkgs.grimblast}/bin/grimblast copy screen"
      "SUPERSHIFT,S,exec,${pkgs.grimblast}/bin/grimblast copy area"
      
      #Audio
      ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 5"
      ",XF86AudioRaiseVolume,exec, ${pkgs.pamixer}/bin/pamixer -i 5"
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
      "SUPER,0,workspace,10"
      
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
      "ALT,0,movetoworkspace,10"
      
      #Mouse winodw manipulation
      "SUPERSHIFT,up, resizeactive,0 60"
      "SUPERSHIFT,down, resizeactive,0 -60"
      "SUPERSHIFT,left, resizeactive,-60 0"
      "SUPERSHIFT,right, resizeactive,60 0"
   ];
   }
