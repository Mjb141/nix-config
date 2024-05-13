# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,auto,bitdepth,10

      # exec-once = ~/.config/hypr/xdg-portal-hyprland
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      
      exec-once = waybar
      exec-once = mako
      exec-once = nm-applet --indicator
      exec-once = wl-paste --watch cliphist store
      
      exec = hyprpaper
      
      input {
          kb_layout = gb
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
      
          follow_mouse = 1
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(ff0000cc)
          col.inactive_border = rgba(ff5800cc)
          layout = dwindle
      }
      
      misc {
          disable_hyprland_logo = yes
      }
      
      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          rounding = 6
      
          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur {
              size = 7
              passes = 4
              new_optimizations = on
          }
      
          drop_shadow = yes
          shadow_range = 8
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }
      
      animations {
          enabled = yes
      
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = myBezier, 0.10, 0.9, 0.1, 1.05
      
          animation = windows, 1, 7, myBezier, slide
          animation = windowsOut, 1, 7, myBezier, slide
          animation = border, 1, 10, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }
      
      # Windows that should float by default
      windowrule = float,^(pavucontrol)$
      windowrule = float,^(blueman-manager)$
      windowrule = float,^(nm-connection-editor)$
      
      # Rules for Kitty, Thunar, Wofi
      windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
      windowrulev2 = animation popin,class:^(kitty)$,title:^(update-sys)$
      windowrulev2 = animation popin,class:^(thunar)$
      windowrulev2 = opacity 0.8 0.8,class:^(thunar)$
      windowrulev2 = move cursor -3% -105%,class:^(wofi)$
      windowrulev2 = noanim,class:^(wofi)$
      windowrulev2 = opacity 0.8 0.6,class:^(wofi)$
      
      # Rule for Last Epoch
      windowrulev2 = fullscreen,class:^(Last Epoch)$
      
      # Rule for Warp
      windowrulev2 = tile,class:^(dev.warp.Warp)$
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER_CTRL
      $secondaryMod = SUPER_CTRL_SHIFT
      
      # Keybinds. see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, T, exec, warp-terminal
      bind = $mainMod, F, exec, firefox # open firefox
      bind = $mainMod, F4, killactive, # close the active window
      bind = $mainMod, M, exec, wlogout --protocol layer-shell # show the logout window
      bind = $mainMod, SPACE, exec, wofi # Show the graphical app launcher
      bind = $mainMod, S, exec, grim -g "$(slurp)" - | swappy -f - # take a screenshot
      bind = $secondaryMod, T, exec, kitty  # open the terminal
      
      bind = ALT, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy # open clipboard manager
      bind = ALT, L, exec, swaylock
      
      # Movements
      # Switch apps within workspace
      bind = $mainMod, j, movefocus, l
      bind = $mainMod, k, movefocus, r
      # Switch workspaces
      bind = $mainMod, w, workspace, -1
      bind = $mainMod, e, workspace, +1
      
      # Move apps within workspace
      bind = $secondaryMod, j, movewindow, l 
      bind = $secondaryMod, k, movewindow, r 
      # Move workspaces
      bind = $secondaryMod, w, movetoworkspace, -1
      bind = $secondaryMod, e, movetoworkspace, +1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      
      # Volume
      binde = , xf86audioraisevolume, exec, pamixer -i 10
      binde = , xf86audiolowervolume, exec, pamixer -d 10
      
      # Source a file (multi-file configs)
      # source = ~/.config/hypr/env_var.conf
      # source = ~/.config/hypr/env_var_nvidia.conf
    '';
  };
    
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "michael";
    homeDirectory = "/home/michael";
  };

  # Add programs
  programs = {
    home-manager.enable = true;
    git.enable = true;
    zoxide.enable = true;
    neovim.enable = true;

    waybar = {
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
	  modules-right = ["clock" "network" "temperature" "pulseaudio" "pulseaudio#microphone" "tray"];
	  "hyprland/workspaces" = {
	    format = "{name}";
	    show-special =  false;
	    on-click = true;
	    all-outputs =  true;
	    sort-by-number = true;
	    on-scroll-up = "hyprctl dispatch workspace e+1";
	    on-scroll-down = "hyprctl dispatch workspace e-1";
	  };
	  "hyprland/window" = {
	    format =  "{}";
	  };
	  "network" = {
	    format-wifi = "{signalStrength}%";
	    format-ethernet =  "{ipaddr}/{cidr}";
	    format-linked =  "{ifname} (No IP)";
	    format-disconnected =  "Disconnected";
	  };
	  "temperature" = {
	    thermal-zone = 1;
	  };
	  "pulseaudio" = {
	    format =  "{icon} {volume}%";
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
          color: rgba(255, 0, 0, 0.9);
          margin-right: 5px;
        }
        
        #workspaces button.active {
          color: rgba(0, 0, 0, 1);
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
        #temperature,
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
        
        /* close to left */
        #temperature {
          border-radius: 10px 0px 0px 10px;
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
          border-left: 0px;
          border-right: 0px;
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

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git"
          "ssh-agent"
        ];
        extraConfig = "zstyle :omz:plugins:ssh-agent identities GithubNix";
      };

      shellAliases = {
        vim = "nvim";
        sysup = "sudo nixos-rebuild switch --flake /home/michael/Projects/nix-config/#nixos";
        homeup = "home-manager switch --flake /home/michael/Projects/nix-config/#michael@nixos";
      };
    };  
  };

  # Add services
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
	preload = [
	  "/home/michael/Pictures/gfy47ugj6beb1.webp"
	];
        wallpaper = [
	  "DP-2,/home/michael/Pictures/gfy47ugj6beb1.webp"
	];
      };
    };
    mako.enable = true;
  };

  # Add packages
  home.packages = with pkgs; [ 
    steam 
    warp-terminal
    obsidian
    hyprland-workspaces
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
