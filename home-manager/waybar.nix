# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        height = 50;
        passthrough = false;
        gtk-layer-shell = true;
        exclusive = true;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["clock" "network" "pulseaudio" "pulseaudio#microphone" "tray"];
        "hyprland/workspaces" = {
          format = "{name}";
          show-special = false;
          on-click = true;
          all-outputs = true;
          sort-by-number = true;
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "hyprland/window" = {
          format = "{}";
        };
        "network" = {
          format-wifi = "WiFi: {signalStrength}%";
          format-disconnected = "Disconnected";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = "Muted";
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "{volume}%";
          format-source-muted = "Muted";
          on-click = "pamixer --default-source -t";
          on-click-right = "pavucontrol";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 16px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(255, 77, 0, 0);
        color: rgba(0, 0, 0, 1);
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: rgba(0, 0, 0, 1);
        margin-right: 5px;
      }

      #workspaces button.active {
        color: rgba(255, 0, 0, 0.9);
      }

      #workspaces button.focused {
        color: rgba(255, 0, 0, 0.2);
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button.urgent {
        color: #11111b;
        background: #a6e3a1;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #custom-power_profile,
      #custom-weather,
      #custom-myhyprv,
      #custom-light_dark,
      #window,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #bluetooth,
      #workspaces,
      #tray,
      #backlight {
        background: rgba(255, 77, 0, 0.4);
        opacity: 0.8;
        padding: 0px 10px;
        margin: 3px 0px;
        margin-top: 10px;
        border: 1px solid rgba(255, 77, 0, 0.4);
      }

      /*close to the right */
      #bluetooth,
      #custom-light_dark {
        border-radius: 0px 10px 10px 0px;
        margin-right: 10px;
      }

      #temperature.critical {
        color: #eba0ac;
      }

      #tray {
        border-radius: 10px;
        margin-right: 10px;
      }

      #workspaces {
        color: rgba(0, 0, 0, 1);
        border-radius: 10px;
        margin-left: 10px;
        padding-right: 0px;
        padding-left: 5px;
      }

      #custom-power_profile {
        color: #a6e3a1;
        border-left: 0px;
        border-right: 0px;
      }

      #window {
        border-radius: 10px;
        margin-left: 10px;
        margin-right: 10px;
      }

      #clock {
        color: rgba(0, 0, 0, 0.9);
        border-radius: 10px 10px 10px 10px;
        margin-left: 10px;
        border-left: 10px;
        margin-right: 10px;
        border-right: 10px;
      }

      #network {
        color: rgba(0, 0, 0, 0.9);
        border-radius: 10px 10px 10px 10px;
        margin-right: 10px;
      }

      #bluetooth {
        color: rgba(0, 0, 0, 0.9);
        border-radius: 0px 10px 10px 0px;
        margin-right: 10px;
      }

      #pulseaudio {
        color: rgba(0, 0, 0, 0.9);
        border-radius: 10px 0px 0px 10px;
      }

      #pulseaudio.microphone {
        color: rgba(0, 0, 0, 0.9);
        border-left: 0px;
        border-right: 0px;
        border-radius: 0px 10px 10px 0px;
        margin-right: 10px;
      }

      #battery {
        color: #ff0000;
        border-radius: 0 10px 10px 0;
        margin-right: 10px;
        border-left: 0px;
      }

      #custom-weather {
        border-radius: 10px 10px 10px 10px;
        border-right: 0px;
        margin-left: 10px;
      }
    '';
  };
}
