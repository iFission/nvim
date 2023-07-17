-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

    ["<leader>g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["<leader>g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["<leader>gf"] = { "<cmd>Gitsign diffthis<cr>", desc = "View diff" },
    ["<leader>gd"] = { "<cmd>Gitsign reset_hunk<cr>", desc = "Reset hunk" },
    ["<leader>gD"] = { "<cmd>Gitsign reset_buffer<cr>", desc = "Reset buffer" },
    ["<leader>ga"] = { "<cmd>Gitsign stage_hunk<cr>", desc = "Stage hunk" },
    ["<leader>gA"] = { "<cmd>Gitsign stage_buffer<cr>", desc = "Stage buffer" },
    ["<leader>fr"] = { "<cmd> Telescope resume<cr>", desc = "Resume previous search" },
    ["<leader>fh"] = { "<cmd> Telescope oldfiles<cr>", desc = "Find history" },
    ["<leader>fH"] = { "<cmd> Telescope help_tags<cr>", desc = "Find help" },
    ["<leader>x"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" },
    ["gi"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["gp"] = { function() vim.diagnostic.open_float() end, desc = "Hover problems" },
    ["g2"] = { function() vim.diagnostic.goto_next() end, desc = "Next problem" },
    ["g1"] = { function() vim.diagnostic.goto_prev() end, desc = "Prev problem" },
    ["H"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Prev buffer",
    },
    ["L"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Prev buffer",
    },
    ["<leader>2"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Definition" },
    ["<leader>3"] = { function() require("telescope.builtin").commands() end, desc = "Commands" },
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<leader>tt"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
  },
  t = {
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
