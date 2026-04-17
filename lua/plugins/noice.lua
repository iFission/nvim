return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      messages = { enabled = true, view = "notify" },
      notify = { enabled = true, view = "notify" },
      views = {
        cmdline_popup = {
          position = {
            row = "20%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { view = "cmdline_popup" },
          search_down = { view = "cmdline_popup" },
          search_up = { view = "cmdline_popup" },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = false },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", false},
      { "<leader>snl", false},
      { "<leader>snh", false},
      { "<leader>sna", false},
      { "<leader>snd", false},
      { "<c-f>", false},
      { "<c-b>", false}
    },
  },
}
