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

      -- list your servers here
      servers = {
        -- lua_ls = {},
        -- pyright = {},
      },
    },

    config = function(_, opts)
      -- diagnostics UI
      vim.diagnostic.config(opts.diagnostics or {})

      -- inlay hints (Neovim 0.11+)
      if opts.inlay_hints and opts.inlay_hints.enabled and vim.lsp.inlay_hint then
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspInlayHints", { clear = true }),
          callback = function(args)
            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
          end,
        })
      end

      -- LSP capabilities (for nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- configure servers (old-style lspconfig, still works today)
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.servers or {}) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_opts or {}))
      end
    end,
  },
}
