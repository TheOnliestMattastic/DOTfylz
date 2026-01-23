-- using lazy.nvim
return {
  "S1M0N38/love2d.nvim",
  event = "VeryLazy",
  version = "2.*",
  opts = {},
  keys = {
    { "<leader>ll", "<cmd>LoveRun<cr>", desc = "Run [L]ÖVE" },
    { "<leader>lL", "<cmd>LoveStop<cr>", desc = "Stop [L]ÖVE" },
  },
}
