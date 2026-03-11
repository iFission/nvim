return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
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
