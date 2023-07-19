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
    ["<leader>fh"] = { "<cmd> Telescope oldfiles<cr>", desc = "Find history" },
    ["<leader>fH"] = { "<cmd> Telescope help_tags<cr>", desc = "Find help" },

    -- editing/intellisense
    ["gi"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["gp"] = { function() vim.diagnostic.open_float() end, desc = "Hover problems" },
    ["g2"] = { function() vim.diagnostic.goto_next() end, desc = "Next problem" },
    ["g1"] = { function() vim.diagnostic.goto_prev() end, desc = "Prev problem" },
    ["<leader>2"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Definition" },
    ["<leader>3"] = { function() require("telescope.builtin").commands() end, desc = "Commands" },

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
  },
  t = {
    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
