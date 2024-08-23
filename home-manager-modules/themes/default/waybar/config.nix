{
  bar = {
    layer = "top";
    position = "top";
    height = 24;
    spacing = 5;

    modules-left = [
      "hyprland/workspaces"
      "group/usage"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "pulseaudio"
      "group/bat"
      "group/net"
      "tray"
    ];

    "group/usage" = {
      orientation = "horizontal";
      modules = [
        "memory"
        "cpu"
        "temperature"
      ];
    };

    "group/bat" = {
      orientation = "horizontal";
      modules = [
        "power-profiles-daemon"
        "battery"
        "backlight"
      ];
    };

    "group/net" = {
      orientation = "horizontal";
      modules = [
        "network"
        "bluetooth"
      ];
    };

    "hyprland/workspaces" = {
      on-click = "activate";
      icon-size = 50;
      sort-by-number = true;
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
      };
    };

    clock = {
      format = "{:%d.%m.%Y | %H:%M}";
    };

    pulseaudio = {
      format = "󰕾  {volume}%";
      max-volume = 100;
      scroll-step = 5;
    };

    battery = {
      bat = "BATT";
      interval = 60;
      format = "{icon}  {capacity}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
    };

    power-profiles-daemon = {
      format = "{icon} ";
      tooltip-format = ''
        Power profile: {profile}
        Driver: {driver}'';
      tooltip = true;
      format-icons = {
        default = "";
        performance = "";
        balanced = "";
        power-saver = "";
      };
    };

    backlight = {
      format = "󰃟  {percent}%";
    };

    memory = {
      interval = 10;
      format = "  {used:0.1f}G";
    };

    cpu = {
      interval = 10;
      format = "  {}%";
    };

    temperature = {
      format = " {temperatureC}°C";
    };

    "network" = {
      format = "";
      format-ethernet = "󰈀 ";
      format-wifi = "{icon} ";
      format-disconnected = "󰲜 ";
      format-icons = [
        "󰤯"
        "󰤟"
        "󰤢"
        "󰤥"
        "󰤨"
      ];
      tooltip-format-wifi = "{essid} ({signalStrength}%)";
      tooltip-format-ethernet = "{ifname}";
      tooltip-format-disconnected = "Disconnected";
    };

    bluetooth = {
      format = "󰂯";
      format-disabled = "󰂲";
      format-connected = "󰂱";
      tooltip-format = "{controller_alias}	{controller_address}";
      tooltip-format-connected = ''
        {controller_alias}	{controller_address}

        {device_enumerate}'';
      tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
    };

    tray = {
      icon-size = 16;
      spacing = 16;
    };
  };
}
