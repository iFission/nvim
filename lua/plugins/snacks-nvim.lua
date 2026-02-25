return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    indent = {
      enabled = true,
      char = "▏",
      animate = { enabled = false },
      scope = {
        char = "▏",
        underline = true,
        -- only_current = true,
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = {
      enabled = true,
      formatters = { file = { truncate = "center" } },
      actions = {
        diffview_commit = function(picker, item)
          local sha = item and (item.commit or item.hash or item.sha or item.value)
          if type(sha) ~= "string" then
            sha = item and item.text or ""
          end
          sha = sha:match("%x%x%x%x%x%x%x+")
          if not sha then
            return
          end

          picker:close()
          vim.schedule(function()
            -- show changes introduced by that commit
            vim.cmd(("DiffviewOpen %s^..%s"):format(sha, sha))
          end)
        end,
      },

      -- and add this
      sources = {
        git_log = {
          win = {
            input = {
              keys = {
                ["<CR>"] = { "diffview_commit", mode = { "i", "n" } },
              },
            },
            list = {
              keys = {
                ["<CR>"] = "diffview_commit",
              },
            },
          },
        },
      },
      layout = {
        layout = {
          box = "horizontal",
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = "vertical",
            border = true,
            title = "{title} {live} {flags}",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
          },
          { win = "preview", title = "{preview}", border = true, width = 0.65 },
        },
      },
      win = {
        input = {
          keys = {
            ["<esc>"] = { "close", mode = { "n", "i" } },
            ["<Tab>"] = { "toggle_live", mode = { "i", "n" } },
            ["<S-J>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<S-K>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<S-L>"] = { "preview_scroll_right", mode = { "i", "n" } },
            ["<S-H>"] = { "preview_scroll_left", mode = { "i", "n" } },
          },
        },
      },
    },
    scroll = { enabled = false },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {},
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}
