return {
  {
    "kevintraver/nvim-treesitter-textsubjects",
    event = "BufEnter",
    init = function()
      require("nvim-treesitter-textsubjects").configure({
        textsubjects = {
          enable = true,
          prev_selection = "'", -- (Optional) keymap to select the previous selection
          keymaps = {
            [","] = "textsubjects-smart",
          },
        },
      })
    end,
  },
}
