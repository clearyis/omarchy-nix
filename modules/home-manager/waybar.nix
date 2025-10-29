inputs:
{
  config,
  pkgs,
  ...
}:
let
  palette = config.colorScheme.palette;
  convert = inputs.nix-colors.lib.conversions.hexToRGBString;
  backgroundRgb = "rgb(${convert ", " palette.base00})";
  foregroundRgb = "rgb(${convert ", " palette.base05})";
in
{
  home.file = {
    ".config/waybar/" = {
      source = ../../config/waybar;
      recursive = true;
    };
    ".config/waybar/theme.css" = {
      text = ''
        @define-color background ${backgroundRgb};
        * {
          color: ${foregroundRgb}; 
        }

        window#waybar {
          background-color: ${backgroundRgb};
        }
      '';
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "battery"
        ];
        modules-right = [
          "group/tray-expander"
          "idle_inhibitor"
          "bluetooth"
          "network"
          "wireplumber"
	  "backlight"
          "memory"
          "cpu"
          "power-profiles-daemon"
          "temperature"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "   ";
            deactivated = "   ";
          }; 
        };
        cpu = {
          interval = 5;
          format = "󰍛 ";
          on-click = "ghostty --command='btop'";
        };
        memory = {
          format = "   ";
          tooltip-format = "{percentage}%\n{used:0.1f}GiB";
          on-click = "ghostty --command='btop'";
        };
        clock = {
          format = "{:%A %I:%M %p}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };
        network = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "ghostty --command='nmtui'";
        };
        battery = {
          interval = 5;
          #format = "{capacity}% {icon} ";
          format = "{power:>1.0f}W↓ {capacity}%";
          #format-discharging = "{icon} {capacity}% ";
          format-discharging = "{power:>1.0f}W↓ {capacity}%";
          format-charging = "{power:>1.0f}W↑ {capacity}%";
          #format-charging = "{icon} {capacity}% ";
          #format-plugged= " ";
          format-plugged = "{power:>1.0f}W↑ {capacity}%";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰂃"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged ";
          #tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          #tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          states = {
            warning = 20;
            critical = 10;
          };
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon7/temp1_input";
          critical-threshold = 95;
          format = "{icon}  ";
          format-icons = [
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	    ""
	  ];
          interval = 5;
          on-click = "ghostty --command='btop'";
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        wireplumber = {
          # Changed from "pulseaudio"
          format = " {icon} ";
	  format-icons = [
	     ""
	     ""
	     ""
	   ];
          format-muted = "󰝟";
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip-format = "Playing at {volume}%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # Updated command
          max-volume = 150; # Optional: allow volume over 100%
        };
	backlight = {
	  device = "intel_backlight";
	  format = "{icon}   ";
	  on-click = "hyprsunset -t 4500";
	  on-click-right = "pkill hyprsunset";
	  tooltip-format = "{percent}%";
	  format-icons = [
	    "󰃞"
	    "󰃟"
	    "󰃠"
	  ];
        };
	"group/tray-expander" = {
	  orientation = "inherit";
          drawer = {
            transition-duration = 600;
            children-class = "tray-group-item";
          };
          modules = [
	    "custom/expand-icon"
	    "tray"
	  ];
          };
          "custom/expand-icon" = {
            format = "   ";
            tooltip = false;
          };
        tray = {
	  icon-size = 12;
          spacing = 17;
        };
        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = "󰡳";
            balanced = "󰊚";
            performance = "󰡴";
          };
        };
        # "custom/dropbox" = {
        #   format = "";
        #   on-click = "nautilus ~/Dropbox";
        #   exec = "dropbox-cli status";
        #   return-type = "text";
        #   interval = 5;
        #   tooltip = true;
        #   tooltip-format = "{}";
        # };
      }
    ];
  };
}
