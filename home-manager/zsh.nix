# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
      sysup = "sudo nixos-rebuild switch --flake /home/michael/Projects/nix-config/#nixos";
      homeup = "home-manager switch --flake /home/michael/Projects/nix-config/#michael@nixos";
    };
  };
}
