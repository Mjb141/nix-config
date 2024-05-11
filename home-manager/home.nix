# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER_CTRL";
    "$secondaryMod" = "SUPER_CTRL_SHIFT";

    # Exec-once
    # "exec-once" = "/home/michael/.config/hypr/xdg-portal-hyprland";

    input = {
      kb_layout = "gb";
      follow_mouse = "1";
      sensitivity = "0";
    };

    bind = 
      [
	# Shortcuts
        "$mainMod, T, exec, warp-terminal"
        "$mainMod, F, exec, firefox"
	"$mainMod, F4, killactive, "
        "$secondaryMod, T, exec, xterm"
	# Movements
	"bind = $mainMod, j, movefocus, l"
	"bind = $mainMod, k, movefocus, r"
	"bind = $mainMod, w, workspace, -1"
	"bind = $mainMod, e, workspace, +1"
	# Move apps
	"bind = $secondaryMod, j, movewindow, l"
	"bind = $secondaryMod, k, movewindow, r"
	"bind = $secondaryMod, w, movetoworkspace, -1"
	"bind = $secondaryMod, e, movetoworkspace, +1"
      ];
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
  programs.neovim.enable = true;

  programs.zsh = {
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
      sysup = "sudo nixos-rebuild switch --flake /home/michael/Documents/nix-config/#nixos";
      homeup = "home-manager switch --flake /home/michael/Documents/nix-config/#michael@nixos";
    };
  };

  # Add packages
  home.packages = with pkgs; [ steam warp-terminal ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zoxide.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
