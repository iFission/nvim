return {
  "nvim-telescope/telescope-live-grep-args.nvim",
  version = "^1.0.0",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = { -- extend mappings
            i = {
              ["<C-d>"] = lga_actions.quote_prompt(),
              ["<C-f>"] = lga_actions.quote_prompt({ postfix = " --iglob *" }),
              -- freeze the current list and start a fuzzy search in the frozen list
              -- ["<C-f>"] = lga_actions.to_fuzzy_refine,
            },
          },
        },
      },
    })

    telescope.load_extension("live_grep_args")
  end,
}
