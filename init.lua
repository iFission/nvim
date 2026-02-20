vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.opt.diffopt:append({
  "internal",
  "filler",
  "vertical",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
  "context:10",
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    vim.opt_local.diffopt:append("linematch:80")
  end,
})

vim.cmd("source ~/.vimrc")
