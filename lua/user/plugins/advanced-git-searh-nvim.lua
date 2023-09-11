return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      require("telescope").setup { extensions = { advanced_git_search = {} } }

      require("telescope").load_extension "advanced_git_search"
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
    },
  },
}
