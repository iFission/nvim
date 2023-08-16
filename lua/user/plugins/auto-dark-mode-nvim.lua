return {
  "f-person/auto-dark-mode.nvim",
  event = "VeryLazy",
  config = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd "colorscheme bluloco-dark"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      if vim.loop.os_uname().sysname == "Darwin" then
        vim.cmd "colorscheme bluloco-light"
      else
        vim.cmd "colorscheme bluloco-dark"
      end
    end,
  },
}
