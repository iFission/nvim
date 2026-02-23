return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "kkharji/sqlite.lua", module = "sqlite" },
  },
  config = function()
    require("neoclip").setup({
      enable_persistent_history = true,
      default_register = "unnamed,unnamedplus",
      keys = {
        telescope = {
          i = {
            select = {},
            paste = "<c-b>",
            paste_behind = "<cr>",
            replay = "<c-q>", -- replay a macro
            delete = "<c-d>", -- delete an entry
            edit = "<c-e>", -- edit an entry
            custom = {},
          },
          n = {
            select = "<cr>",
            paste = "p",
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = "P",
            replay = "q",
            delete = "d",
            edit = "e",
            custom = {},
          },
        },
      },
    })
    require("telescope").load_extension("neoclip")
    vim.keymap.set({ "n", "x" }, "<leader>8", "<cmd>Telescope neoclip<cr>")
    vim.keymap.set({ "i", "x" }, "<c-w>8", "<cmd>Telescope neoclip<cr>")
  end,
}
