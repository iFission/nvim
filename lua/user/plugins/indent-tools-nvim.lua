return {
  "arsham/indent-tools.nvim",
  dependencies = {
    "arsham/arshlib.nvim",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = "BufEnter",
  config = true,
  -- or to provide configuration
  -- config = { normal = {..}, textobj = {..}},
}
