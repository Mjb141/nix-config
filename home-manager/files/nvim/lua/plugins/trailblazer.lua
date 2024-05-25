return {
  "LeonHeidelbach/trailblazer.nvim",
  version = false,
  event = "VeryLazy",
  keys = {
    {
      "<leader>t",
      desc = "Trailblazer",
    },
    {
      "<leader>tm",
      function()
        require("trailblazer").new_trail_mark()
      end,
      desc = "New Trail Mark",
    },
    {
      "<leader>tb",
      function()
        require("trailblazer").track_back()
      end,
      desc = "Track Back",
    },
  },
}
