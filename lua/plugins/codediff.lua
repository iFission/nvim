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
        view = { toggle_stage = "a" },
        explorer = {
          select = "o",
          hover = "-",
          restore = "d",
        },
      },
    },
  },
}
