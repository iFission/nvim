return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- optional but referenced:
      "folke/noice.nvim",
      "mfussenegger/nvim-dap",
      "SmiteshP/nvim-navic",
    },
    opts = function()
      local function fg(name)
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
        if not ok or not hl or not hl.fg then
          return {}
        end
        return { fg = string.format("#%06x", hl.fg) }
      end

      local icons = {
        git = { added = "+", modified = "~", removed = "-" },
        diagnostics = {
          Error = "󰅚 ",
          Warn = "󰀪 ",
          Info = "󰋽 ",
          Hint = "󰌶 ",
        },
      }

      local function ts_lang()
        local ok, parser = pcall(vim.treesitter.get_parser, 0)
        if not ok or not parser then
          return ""
        end

        return "󰹩 " .. parser:lang()
      end

      local function lsp_clients()
        local ok_conform, conform = pcall(require, "conform")
        local formatter_names = {}
        if ok_conform then
          for _, f in ipairs(conform.list_formatters(0)) do
            table.insert(formatter_names, f.name)
          end
        end

        local ok_lint, lint = pcall(require, "lint")
        local linter_names = {}
        if ok_lint then
          for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
            table.insert(linter_names, name)
          end
        end

        local clients = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if
            not vim.tbl_contains(formatter_names, client.name)
            and not vim.tbl_contains(linter_names, client.name)
            and not vim.tbl_contains(clients, client.name)
          then
            table.insert(clients, client.name)
          end
        end
        if next(clients) then
          return " " .. table.concat(clients, " ")
        end
        return ""
      end

      local function lint_linters()
        local ok, lint = pcall(require, "lint")
        if not ok then
          return ""
        end
        local linters = lint.linters_by_ft[vim.bo.filetype] or {}
        local available = vim.tbl_filter(function(name)
          return lint.linters[name] ~= nil
        end, linters)
        if #available > 0 then
          return "󰛓 " .. table.concat(available, " ")
        end
        return ""
      end

      local function conform_formatters()
        local ok, conform = pcall(require, "conform")
        if not ok then
          return ""
        end
        local names = {}
        for _, f in ipairs(conform.list_formatters(0)) do
          if not vim.tbl_contains(names, f.name) then
            table.insert(names, f.name)
          end
        end
        if next(names) then
          return " " .. table.concat(names, " ")
        end
        return ""
      end

      local function dap_clients()
        local ok, dap = pcall(require, "dap")
        if not ok then
          return ""
        end
        local ft = vim.bo.filetype
        local configs = dap.configurations[ft] or {}
        local types = {}
        for _, config in ipairs(configs) do
          if not vim.tbl_contains(types, config.type) then
            table.insert(types, config.type)
          end
        end
        if #types == 0 then
          return ""
        end
        return " " .. table.concat(types, " ")
      end

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { "branch" },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = false, separator = "", padding = { left = 2, right = 0 } },
            { ts_lang, padding = { left = 2, right = 0 } },
            { lsp_clients, padding = { left = 2, right = 0 } },
            { lint_linters, padding = { left = 2, right = 0 } },
            { conform_formatters, padding = { left = 2, right = 0 } },
            { dap_clients, padding = { left = 2, right = 0 } },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = fg("Constant"),
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = fg("Debug"),
            },
            {
              function()
                return require("lazy.status").updates()
              end,
              cond = function()
                return require("lazy.status").has_updates()
              end,
              color = fg("Special"),
            },
          },
          lualine_y = {
            { "location" },
            { "filesize" },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        winbar = {
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
        },
        inactive_winbar = {
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
