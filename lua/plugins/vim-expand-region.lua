return {
  {
    "terryma/vim-expand-region",
    event = "VeryLazy",
    dependencies = { "chrisgrieser/nvim-various-textobjs" },
    keys = {
      { "'", mode = { "x" }, "<Plug>(expand_region_expand)", desc = "Expand selection" },
      { '"', mode = { "x" }, "<Plug>(expand_region_shrink)", desc = "Shrink selection" },
    },
    init = function()
      vim.cmd([[
            let g:expand_region_text_objects = {
                    \ 'iw'  :0,
                    \ 'iW'  :0,
                    \ 'i"'  :0,
                    \ 'i''' :0,
                    \ 'i]'  :1,
                    \ 'ib'  :1,
                    \ 'iB'  :1,
                    \ 'il'  :1,
                    \ 'ii'  :1,
                    \ 'ip'  :0,
                    \ 'ie'  :0,
                    \ }
            ]])
    end,
  },
}
