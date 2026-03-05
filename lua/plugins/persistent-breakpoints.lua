return {
  {
    "Weissle/persistent-breakpoints.nvim",
    lazy = false,
    init = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
  },
}
