return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    always_trigger = true,
    handler_opts = {
      border = "shadow", -- double, rounded, single, shadow, none, or a table of borders
    },
    hint_enable = false,
  },
}
