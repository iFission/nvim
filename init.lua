vim.cmd("source ~/.vimrc")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = function()
      return vim.split(vim.fn.getreg('"'), "\n")
    end,
    ["*"] = function()
      return vim.split(vim.fn.getreg('"'), "\n")
    end,
  },
}

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
