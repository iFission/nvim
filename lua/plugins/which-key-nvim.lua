return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        { "g", group = "Go" },
        { "<leader><tab>", group = "Tab" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>D", group = "Diff" },
        { "<leader>f", group = "Find" },
        { "<leader>fs", group = "Snacks" },
        { "<leader>g", group = "Git" },
        { "<leader>p", group = "Package" },
        { "<leader>t", group = "Trouble/Test" },
        { "<leader>T", group = "Vim-Test" },
        { "<leader>r", group = "Refactor" },
        { "<leader>s", group = "Session" },
        { "<leader>u", group = "UI" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add(opts.defaults)
    end,
  },
}
