return {
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      require("gitsigns").setup({
        attach_to_untracked = true,
        signs = {
          add = { show_count = true },
          change = { show_count = true },
          delete = { show_count = true },
          topdelete = { show_count = true },
          changedelete = { show_count = true },
          untracked = { show_count = true },
        },
        signs_staged = {
          add = { show_count = true },
          change = { show_count = true },
          delete = { show_count = true },
          topdelete = { show_count = true },
          changedelete = { show_count = true },
        },
      })
    end,
  },
}
