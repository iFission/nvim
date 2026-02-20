return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.servers or {}) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_opts or {}))
      end
    end,
  },
}
