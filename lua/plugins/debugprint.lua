return {
  "andrewferrier/debugprint.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  version = "*",
  config = function()
    local opts = {}
    require("debugprint").setup(opts)

    vim.keymap.set({ "n", "x" }, "<C-b>", function()
      -- Note: setting `expr=true` and returning the value are essential
      return require("debugprint").debugprint({ variable = true })
    end, {
      expr = true,
    })
  end,
}
