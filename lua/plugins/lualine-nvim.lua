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
        diagnostics = { Error = "E ", Warn = "W ", Info = "I ", Hint = "H " },
      }

      local function ts_lang()
        local ok, highlighter = pcall(function()
          return require("vim.treesitter.highlighter").active[vim.api.nvim_get_current_buf()]
        end)
        if not ok or not highlighter or not highlighter.tree or not highlighter.tree._lang then
          return ""
        end
        return "󰹩 " .. highlighter.tree._lang
      end

      local function lsp_clients()
        local clients = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if client.name ~= "null-ls" and not vim.tbl_contains(clients, client.name) then
            table.insert(clients, client.name)
          end
        end
        if next(clients) then
          return " " .. table.concat(clients, " ")
        end
        return ""
      end

      local function nullls_sources()
        local ok_sources, sources = pcall(require, "null-ls.sources")
        if not ok_sources then
          return ""
        end

        local ft = vim.bo.filetype
        local names = {}
        for _, src in ipairs(sources.get_all() or {}) do
          if sources.is_available(src, ft) and not vim.tbl_contains(names, src.name) then
            table.insert(names, src.name)
          end
        end
        if next(names) then
          return "󰟢 " .. table.concat(names, " ")
        end
        return ""
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
            { nullls_sources, padding = { left = 2, right = 0 } },
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
