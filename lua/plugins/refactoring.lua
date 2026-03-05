return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  event = "BufEnter",
  config = function()
    require("refactoring").setup {}

    require("telescope").load_extension "refactoring"
    vim.keymap.set({ "n", "x" }, "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end)

    vim.keymap.set("n", "<leader>rp", function() require("refactoring").debug.printf { below = false } end)
    vim.keymap.set({ "x", "n" }, "<leader>rv", function() require("refactoring").debug.print_var() end)
    vim.keymap.set("n", "<leader>rc", function() require("refactoring").debug.cleanup {} end)
  end,
}
