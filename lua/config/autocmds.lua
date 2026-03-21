vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

-- disable readonly warning
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.bo.readonly = false
  end,
})

-- close lazynvim with esc
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  callback = function()
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = true })
  end,
})
