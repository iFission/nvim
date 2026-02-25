return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,

    init = function()
      vim.g.navic_silence = true

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("NavicAttach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          if client.server_capabilities and client.server_capabilities.documentSymbolProvider then
            pcall(require, "nvim-navic")
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,

    opts = function()
      local kinds = {
        File = "󰈙 ",
        Module = "󰆧 ",
        Namespace = "󰅪 ",
        Package = "󰏗 ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = "󰜢 ",
        Field = "󰜢 ",
        Constructor = "󰆧 ",
        Enum = "󰒻 ",
        Interface = "󰕘 ",
        Function = "󰊕 ",
        Variable = "󰀫 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "󰨙 ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = "󰒻 ",
        Struct = "󰌗 ",
        Event = "󰉁 ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      }

      return {
        separator = " > ",
        highlight = false,
        depth_limit = 5,
        icons = kinds,
      }
    end,
  },
}
