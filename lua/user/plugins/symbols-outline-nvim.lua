return {
  {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",
    config = function()
      require("symbols-outline").setup { position = "left", width = 20 }
      vim.keymap.set({ "n" }, "<leader>E", "<cmd>SymbolsOutline<cr>")
    end,
  },
}
