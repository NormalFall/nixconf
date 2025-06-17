{config, lib, pkgs, userName, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Apps
    "Mod+T".action.spawn = [ "${pkgs.kitty}/bin/kitty" ];
    "Mod+Q".action.spawn = [ "xdg-open" "/home/${userName}"];
    
    # Lock
    "Mod+L".action.spawn = [ "loginctl" "lock-session" ];

    # Windows
    "Mod+Shift+F".action = maximize-column;
    "Mod+F".action = fullscreen-window;
    "Mod+C".action = close-window;
    "Mod+Shift+M".action.quit.skip-confirmation = true;
    "Mod+V".action = toggle-window-floating;
    "Mod+D".action = switch-preset-column-width;
    "Mod+Shift+D".action = expand-column-to-available-width;

    # ScreenShots
    "Alt+S".action = screenshot;
    "Alt+Shift+S".action = screenshot;

    # Audio
    "XF86AudioLowerVolume".action.spawn = [ "${pkgs.pamixer}/bin/pamixer" "-d" "5" ];
    "XF86AudioRaiseVolume".action.spawn = [ "${pkgs.pamixer}/bin/pamixer" "-i" "5" ];

    "XF86AudioPlay".action.spawn = [ "${pkgs.playerctl}/bin/playerctl" "play-pause" ];
    "XF86AudioPrev".action.spawn = [ "${pkgs.playerctl}/bin/playerctl" "previous" ];
    "XF86AudioNext".action.spawn = [ "${pkgs.playerctl}/bin/playerctl" "next" ];
    "Alt+F9".action.spawn = [ "${pkgs.playerctl}/bin/playerctl" "previous" ];
    "Alt+F10".action.spawn = [ "${pkgs.playerctl}/bin/playerctl" "next" ];

    # Brightness
    "XF86MonBrightnessDown".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "s" "10%-" ];
    "XF86MonBrightnessUp".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "s" "+10%" ];

    # Aim focus
    "Mod+WheelScrollDown".action = focus-column-left;
    "Mod+WheelScrollUp".action = focus-column-right;
    "Mod+Shift+WheelScrollDown".action = focus-window-down;
    "Mod+Shift+WheelScrollUp".action = focus-window-up;

    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+Shift+WheelScrollLeft".action = focus-window-down;
    "Mod+Shift+WheelScrollRight".action = focus-window-up;

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-window-down;
    "Mod+Up".action = focus-window-up;

    # Move workspace
    "Mod+Z".action = move-workspace-down;
    "Mod+X".action = move-workspace-up;

    "Mod+Shift+Z".action = move-workspace-to-monitor-previous;
    "Mod+Shift+X".action = move-workspace-to-monitor-next;

    # Workspaces
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;

    # Move Windows
    "Alt+1".action.move-window-to-workspace = 1;
    "Alt+2".action.move-window-to-workspace = 2;
    "Alt+3".action.move-window-to-workspace = 3;
    "Alt+4".action.move-window-to-workspace = 4;
    "Alt+5".action.move-window-to-workspace = 5;
    "Alt+6".action.move-window-to-workspace = 6;
    "Alt+7".action.move-window-to-workspace = 7;
    "Alt+8".action.move-window-to-workspace = 8;
    "Alt+9".action.move-window-to-workspace = 9;

    # Resize window
    "Mod+Shift+Left".action.set-window-width = "-10%";
    "Mod+Shift+Right".action.set-window-width = "+10%";
    "Mod+Shift+Up".action.set-window-height = "+10%";
    "Mod+Shift+Down".action.set-window-height = "-10%";

    # Overview
    "Mod+W".action = toggle-overview;
  };
}
