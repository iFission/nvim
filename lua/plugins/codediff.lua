return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      diff = {
        cycle_hunks_across_files = true,
      },
      explorer = {
        view_mode = "tree",
      },
      keymaps = {
        view = {
          toggle_explorer = "<leader>E",
          focus_explorer = "<leader>e",
          toggle_stage = "a",
        },
        explorer = {
          hover = "-",
          restore = "d",
        },
      },
    },
  },
}
