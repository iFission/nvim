return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      require("dropbar").setup()

      local api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>.", api.pick, { desc = "Dropbar: pick symbol" })
      vim.keymap.set("n", "[.", api.goto_context_start, { desc = "Dropbar: go to context start" })
      vim.keymap.set("n", "].", api.select_next_context, { desc = "Dropbar: select next context" })
    end,
  },
}
