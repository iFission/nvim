return {
  {
    "rcarriga/nvim-notify",
    lazy = true, -- only load when we decide to
    opts = {
      render = "compact",
      stages = "static",
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
}
