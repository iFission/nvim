return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
  },

  keys = {
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
  },

  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,

      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
        default = {
          winbar_info = true,
        },
      },

      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 35,
        },
      },

      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
      },

      hooks = {},

      keymaps = {
        disable_defaults = false,

        view = {
          { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
          { "n", "[c", actions.prev_entry, { desc = "Previous entry" } },
          { "n", "]c", actions.next_entry, { desc = "Next entry" } },
          { "n", "<leader>gr", actions.refresh_files, { desc = "Refresh" } },
        },

        file_panel = {
          { "n", "q", actions.close, { desc = "Close panel" } },
          { "n", "j", actions.next_entry, { desc = "Next entry" } },
          { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
          { "n", "<cr>", actions.select_entry, { desc = "Select entry" } },
          { "n", "e", actions.focus_entry, { desc = "Focus entry" } },
          { "n", "R", actions.refresh_files, { desc = "Refresh" } },
        },

        file_history_panel = {
          { "n", "q", actions.close, { desc = "Close panel" } },
          { "n", "j", actions.next_entry, { desc = "Next entry" } },
          { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
          { "n", "<cr>", actions.select_entry, { desc = "Select commit" } },
        },
      },
    })
  end,
}
