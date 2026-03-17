return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    {
      "<leader>uC",
      function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end,
      desc = "Colorscheme with preview",
    },
  },
  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function restore_mode_close(prompt_bufnr)
      local alt_buf = vim.fn.bufnr("#")
      local pre_mode = alt_buf > 0 and vim.b[alt_buf].pre_picker_mode or nil
      local pre_buf = alt_buf > 0 and vim.b[alt_buf].pre_picker_buf or nil
      actions.close(prompt_bufnr)
      vim.schedule(function()
        if pre_mode and pre_buf and vim.api.nvim_get_current_buf() == pre_buf then
          if pre_mode:find("[vV\22]") then
            vim.cmd("normal! gv")
          elseif pre_mode == "i" then
            vim.cmd("startinsert")
          end
        end
      end)
    end

    local function diff_commit(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      local raw = entry and (entry.value or entry.sha or entry.hash or "")
      local sha = tostring(raw):match("%x%x%x%x%x%x%x+")
      if not sha then
        return
      end
      actions.close(prompt_bufnr)
      vim.schedule(function()
        vim.cmd(("CodeDiff %s"):format(sha))
      end)
    end

    local function diff_branch(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      local branch = entry and (entry.value or entry.name or "")
      branch = tostring(branch):gsub("^%*%s*", ""):gsub("^%s+", "")
      if branch == "" then
        return
      end
      local current = vim.fn.systemlist({ "git", "branch", "--show-current" })
      local base = (current and current[1] ~= "" and current[1]) or "HEAD"
      actions.close(prompt_bufnr)
      vim.schedule(function()
        vim.cmd(("CodeDiff %s...%s"):format(branch, base))
      end)
    end

    local commit_picker = {
      mappings = {
        i = { ["<CR>"] = diff_commit },
        n = { ["<CR>"] = diff_commit },
      },
    }

    require("telescope").setup({
      defaults = {
        dynamic_preview_title = true,
        results_title = false,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.64 },
          vertical = { mirror = true, preview_height = 0.64, prompt_position = "top" },
          flex = { flip_columns = 120 },
          width = 0.80,
          height = 0.81,
          preview_cutoff = 0,
        },
        mappings = {
          n = {
            ["<esc>"] = restore_mode_close,
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
            ["<C-q>"] = require("trouble.sources.telescope").open,
          },
          i = {
            ["<esc>"] = restore_mode_close,
            ["<S-Down>"] = actions.cycle_history_next,
            ["<S-Up>"] = actions.cycle_history_prev,
            ["<Tab>"] = function(prompt_bufnr)
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local prompt = current_picker:_get_prompt()
              actions.close(prompt_bufnr)
              Snacks.picker.smart({ pattern = prompt })
            end,
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
            ["<C-q>"] = require("trouble.sources.telescope").open,
          },
        },
      },
      pickers = {
        git_commits = commit_picker,
        git_branches = {
          mappings = {
            i = { ["<CR>"] = diff_branch },
            n = { ["<CR>"] = diff_branch },
          },
        },
      },
    })
  end,
}
