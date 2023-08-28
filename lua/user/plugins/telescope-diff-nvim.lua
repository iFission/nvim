return {
  "jemag/telescope-diff.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  init = function() require("telescope").load_extension "diff" end,
  keys = {
    {
      "<leader>D",
      function() require("telescope").extensions.diff.diff_current { hidden = true } end,
      { desc = "Compare with file" },
    },
  },
}
