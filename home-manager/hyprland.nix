# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ##################################################
      # Configuration and Initial Setup
      ##################################################

      monitor=,preferred,auto,auto,bitdepth,10
      monitor=Unknown-1,disable

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

      ##################################################
      # Visuals
      ##################################################

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
          new_status = master
      }

      ##################################################
      # Workspaces
      ##################################################

      workspace = 2, persistent:true

      ##################################################
      # Windows
      ##################################################

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
      windowrulev2 = opacity 0.9 0.9,class:^(dev.warp.Warp)$
      windowrulev2 = tile,class:^(dev.warp.Warp)$

      # Firefox
      windowrulev2 = opacity 0.8 0.8,class:^(firefox)$
      exec-once = [workspace 1 silent] firefox

      # Discord
      windowrulev2 = opacity 0.8 0.8,class:^(discord)$
      exec-once = [workspace 2 silent] discord

      # Spotify
      windowrulev2 = opacity 0.8 0.8,initialTitle:^(Spotify Premium)$

      ##################################################
      # Controls
      ##################################################

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
    '';
  };
}
