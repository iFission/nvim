return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    local actions = require "telescope.actions"
    local get_icon = require("astronvim.utils").get_icon
    return {
      defaults = {
        prompt_prefix = get_icon("Selected", 1),
        selection_caret = get_icon("Selected", 1),
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.6 },
          vertical = { mirror = true, preview_height = 0.6, prompt_position = "top" },
          flex = { flip_columns = 120 },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 0,
        },
        mappings = {
          i = {
            ["<leader><leader>"] = actions.close,
            ["<S-Down>"] = actions.cycle_history_next,
            ["<S-Up>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = { q = actions.close },
        },
      },
    }
  end,
}
