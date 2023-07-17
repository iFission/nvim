return { {
  "kevinhwang91/nvim-hlslens",
  event = "BufEnter",
  init = function() require("hlslens").setup() end,
} }
