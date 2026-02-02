return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false }, -- disable hover
            -- you can add your own too:
            -- { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
          },
        },
      },
      inlay_hints = { enabled = true },
      diagnostics = {
        virtual_text = {
          prefix = "■",
        },
      },
    },
  },
}
