return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  setup = function() require("neoclip").setup() end,
}
