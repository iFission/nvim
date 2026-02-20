return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true, -- installs missing parsers when you open that filetype
      ensure_installed = { "lua", "vim", "tsx", "javascript", "typescript", "kotlin", "java" },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
