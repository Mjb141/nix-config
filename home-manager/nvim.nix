# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{pkgs, ...}: let
  neovim_config = ./files/nvim;
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      alejandra
      gcc9
      lua-language-server
      nodePackages.bash-language-server
      nodePackages.prettier
      nodePackages.typescript-language-server
      vimPlugins.nvim-treesitter.withAllGrammars
      ruff
      shellcheck
      shfmt
      stylua
      terraform-ls
      tflint
      yaml-language-server
    ];
  };

  # source lua config from this repo
  xdg.configFile = {
    "nvim" = {
      source = "${neovim_config}";
      recursive = true;
    };
  };
}
