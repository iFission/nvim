return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump {
          search = {
            mode = function(str) return "\\<" .. str end,
          },
        }
      end,
      desc = "Flash",
    },
    {
      "<leader>s",
      mode = { "n", "o", "x" },
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    {
      "R",
      mode = { "o", "x" },
      function() require("flash").treesitter_search() end,
      desc = "Treesitter Search",
    },
    {
      "<leader>fs",
      mode = { "n", "x", "o" },
      function() require("flash").jump { continue = true } end,
      desc = "Flash continue",
    },
    {
      "<c-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc = "Toggle Flash Search",
    },
  },
}
