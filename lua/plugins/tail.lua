return {
  {
    "thgrass/tail.nvim",
    ft = "log",
    cmd = { "TailEnable", "TailToggle" },
    keys = {
      {
        "<leader>ut",
        "<cmd>TailEnable<cr>",
        desc = "Tail log",
      },
    },
    init = function()
      require("tail").setup({
        -- enable timestamps by default
        timestamps = false,
        -- customise the format (see `:help os.date`)
        timestamp_format = "%Y-%m-%d %H:%M:%S",
        -- customise the highlight group used for the timestamp
        timestamp_hl = "Comment",
        -- enable log level highlighting by default
        log_level_hl = false,
      })
    end,
  },
}
