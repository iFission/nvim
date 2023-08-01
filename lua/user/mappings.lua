return {
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },

    -- git
    ["<leader>g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["<leader>g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["<leader>gf"] = { "<cmd>Gitsign diffthis<cr>", desc = "View diff" },
    ["<leader>gd"] = { "<cmd>Gitsign reset_hunk<cr>", desc = "Reset hunk" },
    ["<leader>gD"] = { "<cmd>Gitsign reset_buffer<cr>", desc = "Reset buffer" },
    ["<leader>ga"] = { "<cmd>Gitsign stage_hunk<cr>", desc = "Stage hunk" },
    ["<leader>gA"] = { "<cmd>Gitsign stage_buffer<cr>", desc = "Stage buffer" },
    ["<leader>gs"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" },
    ["<leader>gS"] = false,
    ["<leader>gt"] = false,
    ["<leader>gr"] = false,
    ["<leader>gh"] = false,

    -- find
    ["<leader>fr"] = { "<cmd> Telescope resume<cr>", desc = "Resume previous search" },
    ["<leader>1"] = { "<cmd> Telescope resume<cr>", desc = "Resume previous search" },
    ["<leader>4"] = { "<cmd> Telescope live_grep<cr>", desc = "Find word under cursor" },
    ["<leader><leader>"] = { "<cmd> Telescope git_files<cr>", desc = "Find git files" },
    ["<leader>ff"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find git files",
    },
    ["<leader>fh"] = { "<cmd> Telescope oldfiles<cr>", desc = "Find history" },
    ["<leader>fH"] = { "<cmd> Telescope help_tags<cr>", desc = "Find help" },
    ["<leader>9"] = { "<cmd> Navbuddy<cr>", desc = "Navigate symbols" },
    ["<leader>fo"] = {
      "<cmd> Telescope file_browser path=%:p:h select_buffer=true<cr>",
      desc = "File browser",
      silent = true,
    },
    ["<leader>0"] = { function() require("barbar.api").pick_buffer() end, desc = "Pick buffer", silent = true },
    [")"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffer", silent = true },

    -- editing/intellisense
    ["gi"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover problems" },
    ["gc"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
    ["g2"] = { function() vim.diagnostic.goto_next() end, desc = "Next problem" },
    ["g1"] = { function() vim.diagnostic.goto_prev() end, desc = "Prev problem" },
    ["<leader>2"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Definition" },
    ["<leader>3"] = { function() require("telescope.builtin").commands() end, desc = "Commands" },
    ["<leader>'"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["<leader>,"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
    ["<leader>."] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },

    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<leader>tt"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },

    -- buffer
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>x"] = { "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    ["<leader>X"] = { "<Cmd>BufferRestore<CR>", desc = "Restore buffer" },
    ["H"] = { "<Cmd>BufferPrevious<CR>", desc = "Prev buffer" },
    ["L"] = { "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    ["<leader>b<"] = { "<Cmd>BufferMovePrevious<CR>", desc = "Buffer move prev" },
    ["<leader>b>"] = { "<Cmd>BufferMoveNext<CR>", desc = "Buffer move next" },

    -- move
    ["<S-Up>"] = { "<Cmd>:m .-2<CR>==", desc = "Move line up" },
    ["<S-Down>"] = { "<Cmd>:m .+1<CR>==", desc = "Move line down" },

    -- paste
    ["<C-v>"] = { "gP" },
  },
  i = {
    -- move
    ["<S-Up>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" },
    ["<S-Down>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" },

    -- paste
    ["<C-v>"] = { "<C-r>*" },
  },
  v = {
    ["<C-q>"] = { "<cmd>qa!<cr>", desc = "Quit all" },
    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    -- move
    ["<S-Up>"] = { ":m '<-2<CR>gv=gv", desc = "Move line up" },
    ["<S-Down>"] = { ":m '>+1<CR>gv=gv", desc = "Move line down" },

    -- paste
    ["<C-v>"] = { "P" },

    -- find
    ["<leader>4"] = {
      function()
        function vim.getVisualSelection()
          vim.cmd 'noau normal! "vy"'
          local text = vim.fn.getreg "v"
          vim.fn.setreg("v", {})

          text = string.gsub(text, "\n", "")
          if #text > 0 then
            return text
          else
            return ""
          end
        end

        local text = vim.getVisualSelection()
        require("telescope.builtin").live_grep { default_text = text }
      end,
      desc = "Find word in selection",
    },
  },
  t = {
    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<C-q>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
