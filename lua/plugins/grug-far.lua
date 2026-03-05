return {
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      {
        "<leader>fr",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "Replace in current file",
      },
      {
        "<leader>fR",
        function()
          require("grug-far").open()
        end,
        desc = "Replace in files",
      },
      {
        "<leader>fr",
        function()
          require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "Replace in current file (current word)",
        mode = "v",
      },
      {
        "<leader>fR",
        function()
          require("grug-far").with_visual_selection()
        end,
        desc = "Replace in files (current word)",
        mode = "v",
      },
    },
  },
}
