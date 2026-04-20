return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = {
        enabled = true,
        keymap = {
          preset = "inherit",
        },
        completion = {
          menu = { auto_show = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
        },
      },
      keymap = {
        preset = "none",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Right>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
      },
      completion = {
        ghost_text = { enabled = true },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          draw = {
            padding = 0,
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "kind", gap = 2 },
            },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
