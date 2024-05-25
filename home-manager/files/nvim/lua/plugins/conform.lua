return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_lint" },
      javascript = { { "prettierd", "prettier" } },
      terraform = { { "terraform_fmt", "tflint" } },
      lua = { "stylua" },
      nix = { "alejandra" },
    },
  },
}
