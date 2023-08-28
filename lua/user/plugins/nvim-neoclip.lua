return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "kkharji/sqlite.lua",           module = "sqlite" },
  },
  config = function()
    require("neoclip").setup { enable_persistent_history = true, default_register = "unnamed,unnamedplus" }
    require("telescope").load_extension "neoclip"
    vim.keymap.set({ "n", "x" }, "<leader>8", "<cmd>Telescope neoclip<cr>")
  end,
}
