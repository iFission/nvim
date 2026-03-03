return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = function()
      local ok, TS = pcall(require, "nvim-treesitter")
      if not ok or not TS.update then
        vim.schedule(function()
          vim.notify(
            "Please restart Neovim, then run :TSUpdate (nvim-treesitter main branch not ready yet)",
            vim.log.levels.ERROR,
            { title = "Treesitter" }
          )
        end)
        return
      end
      TS.update(nil, { summary = true })
    end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall", "TSInstallSync", "TSUpdateSync" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "helm",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "java",
        "kotlin",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },

    config = function(_, opts)
      local TS = require("nvim-treesitter")

      if type(opts.ensure_installed) ~= "table" then
        vim.notify("nvim-treesitter opts.ensure_installed must be a table", vim.log.levels.ERROR, {
          title = "Treesitter",
        })
        return
      end

      TS.setup(opts)

      local installed = {}
      if TS.get_installed then
        for _, lang in ipairs(TS.get_installed() or {}) do
          installed[lang] = true
        end
      end

      local missing = {}
      for _, lang in ipairs(opts.ensure_installed or {}) do
        if not installed[lang] then
          table.insert(missing, lang)
        end
      end

      if #missing > 0 and TS.install then
        vim.schedule(function()
          vim.notify(
            ("Installing Treesitter parsers: %s"):format(table.concat(missing, ", ")),
            vim.log.levels.INFO,
            { title = "Treesitter" }
          )

          local ok_install, installer = pcall(TS.install, missing, { summary = true })
          if ok_install and installer and installer.await then
            installer:await(function()
              vim.schedule(function()
                vim.notify("Treesitter parser install complete", vim.log.levels.INFO, { title = "Treesitter" })
              end)
            end)
          elseif not ok_install then
            vim.schedule(function()
              vim.notify("Treesitter parser install failed", vim.log.levels.ERROR, { title = "Treesitter" })
            end)
          end
        end)
      end
    end,
  },
}
