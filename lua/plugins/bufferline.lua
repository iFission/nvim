return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },

    opts = function()
      local bufferline = require("bufferline")

      -- Optional Snacks integration. Fallback to builtin delete.
      local ok_snacks, Snacks = pcall(require, "snacks")
      local function bufdelete(n)
        if ok_snacks and Snacks.bufdelete then
          Snacks.bufdelete(n)
        else
          pcall(vim.api.nvim_buf_delete, n, { force = false })
        end
      end

      local diag_icons = { Error = "E:", Warn = "W:" }

      local ok_devicons, devicons = pcall(require, "nvim-web-devicons")

      return {
        options = {
          -- from newer config
          close_command = function(n)
            bufdelete(n)
          end,
          right_mouse_command = function(n)
            bufdelete(n)
          end,
          diagnostics = "nvim_lsp",

          diagnostics_indicator = function(_, _, diag)
            local ret = (diag.error and (diag_icons.Error .. diag.error .. " ") or "")
              .. (diag.warning and (diag_icons.Warn .. diag.warning) or "")
            return vim.trim(ret)
          end,

          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
            { filetype = "snacks_layout_box" },
          },

          get_element_icon = function(el)
            if ok_devicons then
              local icon, hl = devicons.get_icon_by_filetype(el.filetype, { default = true })
              return icon, hl
            end
          end,

          -- from your older config
          style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold,
          },
          show_close_icon = false,
          show_buffer_close_icons = false,

          -- choose one (your older config had true, newer had false)
          always_show_bufferline = true,

          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with({ icon = " " }),
            },
          },
        },
      }
    end,

    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            if vim.fn.exists(":BufferLineRefresh") == 2 then
              pcall(vim.cmd, "BufferLineRefresh")
            end
          end)
        end,
      })
    end,
  },
}
