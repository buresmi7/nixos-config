{ config, pkgs, ... }:

{
  # Sway configuration with visual improvements
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";  # Use Super key as modifier
      terminal = "foot";
      menu = "wofi --show drun";
      
      # Visual improvements
      gaps = {
        inner = 10;
        outer = 5;
      };
      
      window = {
        border = 2;
        titlebar = false;
      };
      
      colors = {
        focused = {
          background = "#285577";
          border = "#4c7899";
          childBorder = "#4c7899";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };
        unfocused = {
          background = "#222222";
          border = "#333333";
          childBorder = "#333333";
          indicator = "#292d2e";
          text = "#888888";
        };
      };
      
      # Startup programs
      startup = [
        { command = "waybar"; }
        { command = "swaybg -i ~/.config/sway/wallpaper.jpg -m fill"; }
      ];
      
      # Basic keybindings
      keybindings = let
        modifier = "Mod4";
      in {
        "${modifier}+Return" = "exec foot";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec wofi --show drun";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -b 'Yes' 'swaymsg exit'";
        
        # Screenshot
        "Print" = "exec grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png";
        
        # Volume controls
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        
        # Brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];
        
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        
        clock = {
          format = "{:%H:%M %d.%m.%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };
        
        network = {
          format-wifi = "{essid} ";
          format-ethernet = "Connected ";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "{ifname}: {ipaddr}";
        };
        
        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background-color: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
        border-bottom: 2px solid #89b4fa;
      }
      
      #workspaces button {
        padding: 0 10px;
        color: #cdd6f4;
        border-radius: 0;
      }
      
      #workspaces button.focused {
        background-color: #89b4fa;
        color: #1e1e2e;
      }
      
      #clock, #battery, #network, #pulseaudio {
        padding: 0 10px;
        margin: 0 2px;
      }
      
      #battery.warning {
        color: #f9e2af;
      }
      
      #battery.critical {
        color: #f38ba8;
      }
    '';
  };
}