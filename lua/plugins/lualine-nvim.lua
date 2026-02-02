return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons

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
            {
              function()
                return "󰹩 "
                  .. require("vim.treesitter.highlighter").active[vim.api.nvim_get_current_buf()].tree._lang
              end,
              padding = { left = 2, right = 0 },
            },
            {
              function()
                local clients = {}
                for _, client in ipairs(vim.lsp.get_active_clients()) do
                  if client.name ~= "null-ls" and not vim.tbl_contains(clients, client.name) then
                    table.insert(clients, client.name)
                  end
                end
                if next(clients) then
                  return " " .. table.concat(clients, " ")
                else
                  return ""
                end
              end,
              padding = { left = 2, right = 0 },
            },
            {
              function()
                local clients = {}
                local ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")
                for _, client in ipairs(require("null-ls.sources").get_all()) do
                  if
                    require("null-ls.sources").is_available(client, ft) and not vim.tbl_contains(clients, client.name)
                  then
                    table.insert(clients, client.name)
                  end
                end
                if next(clients) then
                  return "󰟢 " .. table.concat(clients, " ")
                else
                  return ""
                end
              end,
              padding = { left = 2, right = 0 },
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = {fg = Snacks.util.color("Statement")}
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = {fg = Snacks.util.color("Constant")}
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = {fg = Snacks.util.color("Debug")}
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = Snacks.util.color("Special") },
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
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
        },
        inactive_winbar = {
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
