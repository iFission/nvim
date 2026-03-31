return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      icons = {
        kinds = {
          dir_icon = function(_)
            return "", nil
          end,
        },
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)

      local api = require("dropbar.api")
      -- vim.keymap.set("n", "<Leader>.", api.pick, { desc = "Dropbar: pick symbol" })
      -- vim.keymap.set("n", "[.", api.goto_context_start, { desc = "Dropbar: go to context start" })
      -- vim.keymap.set("n", "].", api.select_next_context, { desc = "Dropbar: select next context" })
    end,
  },
}
