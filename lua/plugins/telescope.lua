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
    local cycle = require("telescope.cycle")(require("telescope.builtin").git_files, function(opts)
      require("telescope.builtin").find_files(vim.tbl_extend("force", opts or {}, { hidden = true, no_ignore = true }))
    end, require("telescope").extensions.live_grep_args.live_grep_args)
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        dynamic_preview_title = true,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.6 },
          vertical = { mirror = true, preview_height = 0.6, prompt_position = "top" },
          flex = { flip_columns = 120 },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 0,
        },
        mappings = {
          n = {
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
            ["<C-q>"] = require("trouble.sources.telescope").open,
          },
          i = {
            ["<esc>"] = actions.close,
            ["<leader><Space>"] = function()
              cycle.next()
            end,
            ["<S-Down>"] = actions.cycle_history_next,
            ["<S-Up>"] = actions.cycle_history_prev,
            ["<Tab>"] = function()
              cycle.next()
            end,
            ["<S-Tab>"] = function()
              cycle.previous()
            end,
            ["<S-J>"] = actions.preview_scrolling_down,
            ["<S-K>"] = actions.preview_scrolling_up,
            ["<S-L>"] = actions.preview_scrolling_right,
            ["<S-H>"] = actions.preview_scrolling_left,
            ["<C-q>"] = require("trouble.sources.telescope").open,
          },
        },
      },
    })
  end,
}
