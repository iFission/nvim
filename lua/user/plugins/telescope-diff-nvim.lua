return {
  "jemag/telescope-diff.nvim",
  event = "BufEnter",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  init = function() require("telescope").load_extension "diff" end,
  config = function()
    vim.keymap.set(
      "n",
      "<leader>D",
      function() require("telescope").extensions.diff.diff_current { hidden = true } end,
      { desc = "Compare file with current" }
    )
  end,
}
