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
