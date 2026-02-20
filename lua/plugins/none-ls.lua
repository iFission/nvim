return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- replaces LazyFile
    dependencies = {
      "williamboman/mason.nvim",
      {
        "jay-babu/mason-null-ls.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        opts = {
          -- keep empty handlers so none-ls controls sources below
          handlers = {},
        },
      },
    },

    opts = function(_, opts)
      local null_ls = require("null-ls")

      opts = opts or {}

      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")

      -- merge/extend sources
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
      })

      return opts
    end,

    config = function(_, opts)
      require("null-ls").setup(opts)

      -- Optional: if you want a format-on-save that prefers null-ls when available.
      -- Delete this block if you handle formatting elsewhere (eg conform.nvim).
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("NullLsFormatOnSave", { clear = true }),
        callback = function(args)
          -- Only format if a null-ls client is attached to this buffer
          local has_null_ls = false
          for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
            if c.name == "null-ls" then
              has_null_ls = true
              break
            end
          end
          if not has_null_ls then
            return
          end

          vim.lsp.buf.format({
            bufnr = args.buf,
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end,
      })
    end,
  },
}
