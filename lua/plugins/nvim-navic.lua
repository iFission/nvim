return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = function()
      Snacks.util.lsp.on({ method = "textDocument/documentSymbol" }, function(buffer, client)
        require("nvim-navic").attach(client, buffer)
      end)
      return {
        separator = " > ",
        highlight = false,
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds,
      }
    end,
  },
}
