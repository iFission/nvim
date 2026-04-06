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
      filter = function(notif)
        -- suppress codediff welcome_window cleanup bug
        if notif.msg and notif.msg:match("welcome_window") then
          return false
        end
        return true
      end,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = {
      enabled = true,
      formatters = { file = { truncate = "center" } },
      actions = {
        trouble_open = function(...)
          return require("trouble.sources.snacks").actions.trouble_open.action(...)
        end,

        diff_commit = function(picker, item)
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
            vim.cmd(("CodeDiff %s^ %s"):format(sha, sha))
          end)
        end,

        diff_file_commit = function(picker, item)
          local sha = item and (item.commit or item.hash or item.sha or item.value)
          if type(sha) ~= "string" then
            sha = item and item.text or ""
          end
          sha = sha:match("%x%x%x%x%x%x%x+")
          if not sha then
            return
          end
          picker:close()
          vim.defer_fn(function()
            local cfg = require("codediff.config")
            local prev_focus = cfg.options.explorer.initial_focus
            cfg.options.explorer.initial_focus = "modified"

            vim.cmd(("CodeDiff %s^ %s"):format(sha, sha))

            vim.defer_fn(function()
              cfg.options.explorer.initial_focus = prev_focus
            end, 200)
          end, 50)
        end,

        -- modified from diff_branch. diff_file_commit version not working
        diff_file_commit_with_head = function(picker, item)
          local function current_branch()
            local out = vim.fn.systemlist({ "git", "branch", "--show-current" })
            return (out and out[1] ~= "" and out[1]) or "HEAD"
          end

          local branch = item and (item.branch or item.name or item.text)
          if not branch then
            return
          end
          branch = branch:gsub("^%*%s*", ""):gsub("^%s+", "")

          local base = current_branch()
          picker:close()
          vim.defer_fn(function()
            local cfg = require("codediff.config")
            local prev_focus = cfg.options.explorer.initial_focus
            cfg.options.explorer.initial_focus = "modified"

            vim.cmd(("CodeDiff %s...%s"):format(branch, base))

            vim.defer_fn(function()
              cfg.options.explorer.initial_focus = prev_focus
            end, 200)
          end, 50)
        end,

        diff_branch = function(picker, item)
          local function current_branch()
            local out = vim.fn.systemlist({ "git", "branch", "--show-current" })
            return (out and out[1] ~= "" and out[1]) or "HEAD"
          end

          local branch = item and (item.branch or item.name or item.text)
          if not branch then
            return
          end
          branch = branch:gsub("^%*%s*", ""):gsub("^%s+", "")

          local base = current_branch()
          picker:close()
          vim.schedule(function()
            vim.cmd(("CodeDiff %s...%s"):format(branch, base))
          end)
        end,

        diff_head_file = function(picker, item)
          local file = item and (item.file or item.text)
          if not file then
            return
          end
          picker:close()
          vim.defer_fn(function()
            local cfg = require("codediff.config")
            local prev_focus = cfg.options.explorer.initial_focus
            cfg.options.explorer.initial_focus = "modified"

            vim.cmd("CodeDiff")

            vim.defer_fn(function()
              cfg.options.explorer.initial_focus = prev_focus
            end, 200)
          end, 50)
        end,
      },
      sources = {
        git_log = {
          confirm = "diff_commit",
        },
        git_log_file = {
          confirm = "diff_file_commit",
          win = {
            input = {
              keys = {
                ["<S-CR>"] = { "diff_file_commit_with_head", mode = { "n", "i" } },
              },
            },
          },
        },
        git_log_line = {
          confirm = "diff_file_commit",
        },
        git_branches = {
          confirm = "diff_branch",
          all = true,
        },
        git_status = {
          win = {
            input = {
              keys = {
                ["<S-CR>"] = { "diff_head_file", mode = { "n", "i" } },
              },
            },
          },
        },
        smart = {
          -- show path on preview title
          on_change = function(picker, item)
            if not (item and item.file) then
              return
            end
            vim.schedule(function()
              local cwd = picker:cwd()
              local path = vim.fn.fnamemodify(item.file, ":p")
              if cwd and path:find(cwd, 1, true) == 1 then
                path = path:sub(#cwd + 2)
              end
              picker.preview.win:set_title(path)
            end)
          end,
          actions = {
            switch_to_telescope_grep = function(picker)
              local pattern = picker.input.filter.pattern or picker.input.filter.search or ""
              picker:close()
              require("telescope").extensions.live_grep_args.live_grep_args({
                default_text = pattern,
              })
            end,
          },
          win = {
            input = {
              keys = {
                ["<Tab>"] = {
                  "switch_to_telescope_grep",
                  desc = "Switch to Telescope Grep",
                  mode = { "i", "n" },
                },
                ["<C-f>"] = { "toggle_ignored", mode = { "i", "n" } },
              },
            },
          },
        },
      },
      layout = function()
        if vim.o.columns < 120 then
          return {
            layout = {
              backdrop = false,
              box = "vertical",
              width = 0.8,
              height = 0.8,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = true, height = 0.69 },
            },
          }
        end
        return {
          layout = {
            backdrop = false,
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
        }
      end,

      win = {
        input = {
          keys = {
            ["<esc>"] = {
              function(picker)
                local alt_buf = vim.fn.bufnr("#")
                local pre_mode = alt_buf > 0 and vim.b[alt_buf].pre_picker_mode or nil
                local pre_buf = alt_buf > 0 and vim.b[alt_buf].pre_picker_buf or nil
                picker:close()
                vim.schedule(function()
                  if pre_mode and pre_buf and vim.api.nvim_get_current_buf() == pre_buf then
                    if pre_mode:find("[vV\22]") then
                      vim.cmd("normal! gv")
                    elseif pre_mode == "i" then
                      vim.cmd("startinsert")
                    end
                  end
                end)
              end,
              desc = "Close and restore mode",
              mode = { "n", "i" },
            },
            ["<Tab>"] = { "toggle_live", mode = { "i", "n" } },
            ["<S-J>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<S-K>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<S-L>"] = { "preview_scroll_right", mode = { "i", "n" } },
            ["<S-H>"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["<C-q>"] = { "trouble_open", mode = { "n", "i" } },
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
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

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
