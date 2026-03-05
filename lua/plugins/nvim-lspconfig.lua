return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        virtual_text = { prefix = "■" },
      },
      servers = {},
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics or {})
      if opts.inlay_hints and opts.inlay_hints.enabled and vim.lsp.inlay_hint then
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspInlayHints", { clear = true }),
          callback = function(args)
            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
          end,
        })
      end
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.servers or {}) do
        server_opts = server_opts or {}
        server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
        lspconfig[server].setup(server_opts)
      end
    end,
  },
}
