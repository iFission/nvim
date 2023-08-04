return {
  {
    "simrat39/symbols-outline.nvim",
    event = "BufRead",
    config = function()
      require("symbols-outline").setup { position = "left", width = 20 }
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        command = "SymbolsOutlineOpen",
      })
      vim.keymap.set({ "n" }, "<leader>o", "<cmd>SymbolsOutline<cr>")
    end,
  },
}
