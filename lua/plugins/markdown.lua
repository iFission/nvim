return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>up",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
    opts = {
      pipe_table = { enabled = false }, -- pipetable owns tables
      win_options = { concealcursor = { rendered = "nvic" } }, -- keep pipetable's active row rendered
    },
  },
  {
    "dominic-righthere/markdown-pipetable.nvim",
    ft = "markdown",
    config = function()
      require("pipetable").setup({ column = { min_width = 3, max_width = 400, padding = 1 } })
    end,
  },
}
