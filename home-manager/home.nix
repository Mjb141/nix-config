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
    
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ./hyprland.nix
    ./waybar.nix
    ./mako.nix
    ./wofi.nix
    ./zsh.nix
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
    kitty.enable = true;
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
  };

  # Add packages
  home.packages = with pkgs; [ 
    steam 
    warp-terminal
    obsidian
    discord
    hyprland-workspaces
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
