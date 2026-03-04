return {
  {
    "hedyhli/outline.nvim",
    dependencies = { "epheien/outline-treesitter-provider.nvim" },
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>9", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      outline_window = {
        position = "left",
        auto_jump = true,
      },
      keymaps = {
        toggle_preview = "\\",
      },
      providers = {
        priority = { "lsp", "coc", "markdown", "norg", "treesitter" },
      },
    },
  },
}
