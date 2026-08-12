return {
  "ChausseBenjamin/resizer.nvim",

  config = function()
    local res = require("resizer")

    res.setup({
      trigger = "<c-w>r",
      hi = { link = "@markup.strong" },
      keymaps = {
        ["q"] = res.quit,

        -- Coarse adjustments
        ["h"] = function()
          res.left(10)
        end,
        ["j"] = function()
          res.down(7)
        end,
        ["k"] = function()
          res.up(7)
        end,
        ["l"] = function()
          res.right(10)
        end,

        -- Fine adjustments
        ["H"] = function()
          res.left(1)
        end,
        ["J"] = function()
          res.down(1)
        end,
        ["K"] = function()
          res.up(1)
        end,
        ["L"] = function()
          res.right(1)
        end,
      },
    })
  end,
}
