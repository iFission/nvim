return {
  {
    "drybalka/tree-climber.nvim",
    event = "BufEnter",
    enabled = false,
    config = function()
      local keyopts = { noremap = true, silent = true }
      vim.keymap.set({ "n", "v", "o" }, "<S-Left>", require("tree-climber").goto_parent, keyopts)
      vim.keymap.set({ "n", "v", "o" }, "<S-Right>", require("tree-climber").goto_child, keyopts)
      vim.keymap.set({ "n", "v", "o" }, "<Down>", require("tree-climber").goto_next, keyopts)
      vim.keymap.set({ "n", "v", "o" }, "<Up>", require("tree-climber").goto_prev, keyopts)
      vim.keymap.set({ "v", "o" }, "in", require("tree-climber").select_node, keyopts)
      vim.keymap.set("n", "<c-k>", require("tree-climber").swap_prev, keyopts)
      vim.keymap.set("n", "<c-j>", require("tree-climber").swap_next, keyopts)
      vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)
    end,
  },
}
