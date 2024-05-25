return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  opts = {
    servers = {
      ruff = {
        enabled = true,
      },
    },
  },
}
