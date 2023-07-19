return {
  {
    "f-person/git-blame.nvim",
    event = "BufEnter",
    config = function()
      vim.g.gitblame_virtual_text_column = 80
      vim.g.gitblame_date_format = "%r"
    end,
  },
}
