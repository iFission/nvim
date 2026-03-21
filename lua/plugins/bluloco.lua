return {
  "uloco/bluloco.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "rktjmp/lush.nvim" },
  init = function()
    -- override bluloco theme for dropbar
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "bluloco*",
      callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
        vim.api.nvim_set_hl(0, "WinBar", { fg = normal.fg, bg = normal.bg, bold = false })
        vim.api.nvim_set_hl(0, "WinBarNC", { fg = normal.fg, bg = normal.bg, bold = false })
      end,
    })
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    vim.api.nvim_set_hl(0, "WinBar", { fg = normal.fg, bg = normal.bg, bold = false })
    vim.api.nvim_set_hl(0, "WinBarNC", { fg = normal.fg, bg = normal.bg, bold = false })
  end,
  config = function()
    vim.cmd("colorscheme bluloco")
  end,
}
