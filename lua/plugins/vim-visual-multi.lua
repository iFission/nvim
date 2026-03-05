return {
  "mg979/vim-visual-multi",
  lazy = false,
  enabled = false,
  config = function()
    vim.g.VM_default_mappings = 0
    vim.api.nvim_set_keymap("n", "<C-n>", "<Plug>(VM-Find-Under)", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-m>", "<Plug>(VM-Add-Cursor-Down)", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gV", "<Plug>(VM-Reselect-Last)", { noremap = true, silent = true })
  end,
}
