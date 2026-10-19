return {
  {
    "kevintraver/nvim-treesitter-textsubjects",
    event = "BufEnter",
    init = function()
      require("nvim-treesitter-textsubjects").configure()
    end,
  },
}
