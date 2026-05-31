{ ... }:
{
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 20;
      spacing = 2;

      modules-left = [
        "custom/arch"
        "hyprland/workspaces"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "battery#bat2"
        "clock"
      ];

      "custom/arch" = {
        format = "󰣇";
        tooltip = true;
        "tooltip-format" = "btw";
      };

      "hyprland/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "warp-on-scroll" = false;
        format = "{name}";
        "format-icons" = {
          urgent = "";
          active = "";
          default = "";
        };
      };

      "pulseaudio" = {
        format = "{icon}  {volume}%";
        "format-bluetooth" = "{icon} {volume}%  {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "";
        "format-source-muted" = "";
        "format-icons" = {
          headphone = "";
          "hands-free" = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        "on-click" = "pavucontrol";
      };

      "network" = {
        "format-wifi" = "   {essid} ({signalStrength}%)";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "on-click" = "pkill nm-applet || nm-applet";
      };

      "cpu" = {
        format = "  {usage}%";
        tooltip = true;
      };

      "memory" = {
        format = "  {}%";
        tooltip = true;
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        "format-full" = "{icon}  {capacity}%";
        "format-charging" = "  {capacity}%";
        "format-plugged" = "  {capacity}%";
        "format-alt" = "{time}  {icon}";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      "battery#bat2" = {
        bat = "BAT2";
      };

      "clock" = {
        format = "{:%I:%M | %e %B} ";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };
    };
  };

  programs.waybar.style = ''
    @define-color rosewater #ebdbb2;
    @define-color flamingo  #fb4934;
    @define-color pink      #d3869b;
    @define-color mauve     #b16286;
    @define-color red       #cc241d;
    @define-color maroon    #d79921;
    @define-color peach     #fabd2f;
    @define-color yellow    #d79921;
    @define-color green     #98971a;
    @define-color teal      #8ec07c;
    @define-color sky       #83a598;
    @define-color sapphire  #458588;
    @define-color blue      #83a598;
    @define-color lavender  #a89984;
    @define-color text      #ebdbb2;
    @define-color subtext1  #a89984;
    @define-color subtext0  #928374;
    @define-color overlay2  #7c6f64;
    @define-color overlay1  #665c54;
    @define-color overlay0  #504945;
    @define-color surface2  #3c3836;
    @define-color surface1  #32302f;
    @define-color surface0  #282828;
    @define-color base      #1d2021;
    @define-color mantle    #1b1b1b;
    @define-color crust     #181818;

    * {
        font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 12px;
        transition: background-color .3s ease-out;
    }

    window#waybar {
        background: transparent;
        color: #ebdbb2;
        font-family:
            SpaceMono Nerd Font,
            feather;
        transition: background-color .5s;
    }

    .modules-left,
    .modules-right {
        background: rgba(0, 0, 8, 0.7);
        margin: 2px 10px;
        padding: 0 5px;
        border-radius: 15px;
    }

    .modules-left {
        padding: 0;
    }

    .modules-center {
        padding: 0 10px;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #wireplumber,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #power-profiles-daemon,
    #language,
    #mpd {
        padding: 0 10px;
        border-radius: 15px;
    }

    #clock:hover,
    #battery:hover,
    #cpu:hover,
    #memory:hover,
    #disk:hover,
    #temperature:hover,
    #backlight:hover,
    #network:hover,
    #pulseaudio:hover,
    #wireplumber:hover,
    #custom-media:hover,
    #tray:hover,
    #mode:hover,
    #idle_inhibitor:hover,
    #scratchpad:hover,
    #power-profiles-daemon:hover,
    #language:hover,
    #mpd:hover {
        background: rgba(29, 32, 33, 0.9);
    }

    #workspaces button {
        background: transparent;
        font-family:
            SpaceMono Nerd Font,
            feather;
        font-weight: 900;
        font-size: 13pt;
        color: #ebdbb2;
        border: none;
        border-radius: 15px;
    }

    #workspaces button.active {
        background: #1b1b1b;
    }

    #workspaces button:hover {
        background: #181818;
        color: #ebdbb2;
        box-shadow: none;
    }

    #custom-arch {
        margin-left: 5px;
        padding: 0 10px;
        font-size: 18px;
        transition: color .5s;
    }

    #custom-arch:hover {
        color: #458588;
    }
  '';
}
