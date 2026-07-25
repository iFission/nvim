return {
  {
    "WantDead/theme-sync.nvim",
    lazy = false,
    cond = function()
      local uv = vim.uv or vim.loop
      local is_root = uv.getuid and uv.getuid() == 0

      local is_ssh = vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

      local is_zellij = vim.env.ZELLIJ ~= nil

      return not is_root and (is_zellij or not is_ssh)
    end,
    opts = {
      dark = "bluloco-dark",
      light = "bluloco-light",
      poll_interval = 1000,
    },
  },
}
