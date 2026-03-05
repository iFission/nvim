return {
  {
    "sustech-data/wildfire.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup({
        surrounds = {
          { "(", ")" },
          { "{", "}" },
          { "<", ">" },
          { "[", "]" },
        },
        keymaps = {
          init_selection = "vv",
          node_incremental = ".",
          node_decremental = ",",
        },
        filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
      })
    end,
  },
}
