return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- snippets (needed for snippet_forward behavior)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- optional: if you actually use lazydev source
      -- { "folke/lazydev.nvim", ft = "lua" },
    },

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")

      local auto_select = false -- set to false if you want explicit selection

      local kind_icons = {
        Text = "󰉿 ",
        Method = "󰆧 ",
        Function = "󰊕 ",
        Constructor = " ",
        Field = "󰜢 ",
        Variable = "󰀫 ",
        Class = "󰠱 ",
        Interface = " ",
        Module = " ",
        Property = "󰜢 ",
        Unit = "󰑭 ",
        Value = "󰎠 ",
        Enum = " ",
        Keyword = "󰌋 ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈙 ",
        Reference = "󰈇 ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = "󰙅 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      }

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then
          return false
        end
        local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        return text:sub(col, col):match("%s") == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),

          ["<CR>"] = cmp.mapping.confirm({ select = auto_select }),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = auto_select }),

          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          -- { name = "lazydev" }, -- enable only if you installed lazydev.nvim
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),

        formatting = {
          format = function(entry, item)
            local icon = kind_icons[item.kind]
            if icon then
              item.kind = icon .. item.kind
            end

            local widths = {
              abbr = (vim.g.cmp_widths and vim.g.cmp_widths.abbr) or 40,
              menu = (vim.g.cmp_widths and vim.g.cmp_widths.menu) or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },

        experimental = {
          ghost_text = vim.g.ai_cmp and { hl_group = "CmpGhostText" } or false,
        },

        sorting = defaults.sorting,
      }
    end,
  },
}
