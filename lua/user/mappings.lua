return {
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },

    ["<leader><c-q>"] = { "<cmd>quitall!<cr>", desc = "Quit all" },

    -- git
    ["<leader>g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["<leader>g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["g4"] = { "<cmd>Gitsign prev_hunk<cr>", desc = "Prev hunk" },
    ["g3"] = { "<cmd>Gitsign next_hunk<cr>", desc = "Next hunk" },
    ["<leader>gf"] = { "<cmd>Gitsign diffthis<cr>", desc = "View diff" },
    ["<leader>gd"] = { "<cmd>Gitsign reset_hunk<cr>", desc = "Reset hunk" },
    ["<leader>gD"] = { "<cmd>Gitsign reset_buffer<cr>", desc = "Reset buffer" },
    ["<leader>ga"] = { "<cmd>Gitsign stage_hunk<cr>", desc = "Stage hunk" },
    ["<leader>gA"] = { "<cmd>Gitsign stage_buffer<cr>", desc = "Stage buffer" },
    ["<leader>gs"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" },
    ["<leader>gS"] = false,
    ["<leader>gt"] = false,
    ["<leader>gr"] = false,
    ["<leader>gh"] = false,

    -- file
    ["<leader>W"] = { "<cmd>w !sudo tee %<cr>", desc = "Force write" },
    ["<leader><C-s>"] = { "<cmd>noa w<cr>", desc = "Save without formatting" },

    -- find
    ["<leader>fr"] = { "<cmd> Telescope resume<cr>", desc = "Resume previous search" },
    ["<leader>1"] = { "<cmd> Telescope resume<cr>", desc = "Resume previous search" },
    ["<leader>3"] = { function() require("telescope.builtin").commands() end, desc = "Commands" },
    ["<leader>#"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" },
    ["<leader>4"] = { "<cmd> Telescope live_grep<cr>", desc = "Find word under cursor" },
    ["<leader><leader>"] = {
      function()
        local function is_git_repo()
          local is_repo = vim.fn.system "git rev-parse --is-inside-work-tree"
          return vim.v.shell_error == 0
        end

        if is_git_repo() then
          require("telescope.builtin").git_files()
        else
          require("telescope.builtin").find_files { hidden = true, no_ignore = true }
        end
      end,
      desc = "Find git files",
    },
    ["<leader>ff"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find git files",
    },
    ["<leader>fh"] = { "<cmd> Telescope oldfiles<cr>", desc = "Find history" },
    ["<leader>fH"] = { "<cmd> Telescope help_tags<cr>", desc = "Find help" },
    ["<leader>9"] = { "<cmd> Navbuddy<cr>", desc = "Navigate symbols" },
    ["<leader>fo"] = {
      "<cmd> Telescope file_browser path=%:p:h select_buffer=true<cr>",
      desc = "File browser",
      silent = true,
    },
    ["<leader>0"] = { function() require("barbar.api").pick_buffer() end, desc = "Pick buffer", silent = true },
    [")"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffer", silent = true },
    ["<leader>fm"] = {
      function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end,
      desc = "Open mini.files (directory of current file)",
    },

    -- editing/intellisense
    ["gi"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover problems" },
    ["gc"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
    ["g2"] = { function() vim.diagnostic.goto_next() end, desc = "Next problem" },
    ["g1"] = { function() vim.diagnostic.goto_prev() end, desc = "Prev problem" },
    ["<leader>2"] = { function() require("telescope.builtin").lsp_definitions() end, desc = "Definition" },
    ["<leader>'"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
    ["<leader>,"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
    ["<leader>."] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
    ["<leader>o"] = { "<cmd>SymbolsOutline<cr>", desc = "Open symbols outline" },

    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<leader>tt"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },

    -- buffer
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>x"] = { "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    ["<leader>X"] = { "<Cmd>BufferRestore<CR>", desc = "Restore buffer" },
    ["H"] = { "<Cmd>BufferPrevious<CR>", desc = "Prev buffer" },
    ["L"] = { "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    ["<leader>b<"] = { "<Cmd>BufferMovePrevious<CR>", desc = "Buffer move prev" },
    ["<leader>b>"] = { "<Cmd>BufferMoveNext<CR>", desc = "Buffer move next" },
    ["<leader>c"] = { "<cmd>enew<cr>", desc = "New File" },
    ["<leader>C"] = false,

    -- diff
    ["<leader>d"] = {
      function()
        local ftype = vim.api.nvim_eval "&filetype"
        vim.cmd "vsplit"
        vim.cmd "enew"
        vim.cmd "normal! P"
        vim.cmd "setlocal buftype=nowrite"
        vim.cmd("set filetype=" .. ftype)
        vim.cmd "diffthis"
        vim.cmd [[execute "normal! \<C-w>h"]]
        vim.cmd "diffthis"
      end,
      desc = "Compare to clipboard",
    },

    -- window
    ["<c-w><up>"] = { "<Cmd>wincmd k<CR>", desc = "Focus up window" },
    ["<c-w><down>"] = { "<Cmd>wincmd j<CR>", desc = "Focus down window" },
    ["<c-w><left>"] = { "<Cmd>wincmd h<CR>", desc = "Focus left window" },
    ["<c-w><right>"] = { "<Cmd>wincmd l<CR>", desc = "Focus right window" },
    ["<c-w>'"] = { "<Cmd>wincmd v<CR>", desc = "Split vertical" },
    ['<c-w>"'] = { "<Cmd>wincmd s<CR>", desc = "Split horizontal" },
    ["<c-w>Q"] = { "<Cmd>wincmd =<CR>", desc = "Reset balance" },
    ["<c-w>F"] = { "<Cmd>wincmd =<CR>", desc = "Reset balance" },
    ["<c-w>f"] = { "<Cmd>wincmd |<CR><Cmd>wincmd _<CR>", desc = "Maximise" },
    ["<c-w>x"] = { "<Cmd>wincmd q<CR>", desc = "Close window" },
    ["<c-w>c"] = { "<Cmd>wincmd o<CR>", desc = "Close other windows" },
    ["<c-w>j"] = false,
    ["<c-w>k"] = false,
    ["<c-w>h"] = { "<Cmd>BufferPrevious<CR>", desc = "Prev buffer" },
    ["<c-w>l"] = { "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    ["<c-w><"] = false,
    ["<c-w>>"] = false,
    ["<c-w>+"] = false,
    ["<c-w>-"] = false,
    ["<c-w>="] = false,
    ["<c-w>L"] = { "<Cmd>wincmd ><CR>", desc = "Increase width" },
    ["<c-w>H"] = { "<Cmd>wincmd <<CR>", desc = "Decrease width" },
    ["<c-w>J"] = { "<Cmd>wincmd +<CR>", desc = "Increase height" },
    ["<c-w>K"] = { "<Cmd>wincmd -<CR>", desc = "Increase height" },

    -- move
    ["<S-Up>"] = { ":MoveLine(-1)<cr>", desc = "Move line up" },
    ["<S-Down>"] = { ":MoveLine(1)<cr>", desc = "Move line down" },
    ["<S-Left>"] = { ":MoveHChar(-1)<cr>", desc = "Move char left" },
    ["<S-Right>"] = { ":MoveHChar(1)<cr>", desc = "Move char right" },

    -- paste
    ["<C-v>"] = { "gP" },

    ["<cr>"] = { "ciw" },
  },
  i = {
    ["<C-q>"] = { "<cmd>qa!<cr>", desc = "Quit all" },
    -- move
    ["<S-Up>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" },
    ["<S-Down>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" },

    -- paste
    ["<C-v>"] = { "<C-O>:set noai<CR><C-r>*<C-O>:set ai<CR>" },
  },
  v = {
    ["<C-q>"] = { "<cmd>qa!<cr>", desc = "Quit all" },
    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    -- move
    ["<S-Up>"] = { ":MoveBlock(-1)<cr>", desc = "Move line up" },
    ["<S-Down>"] = { ":MoveBlock(1)<cr>", desc = "Move line down" },
    ["<S-Left>"] = { ":MoveHBlock(-1)<cr>", desc = "Move block left" },
    ["<S-Right>"] = { ":MoveHBlock(1)<cr>", desc = "Move block right" },

    -- paste
    ["<C-v>"] = { "P" },

    -- editing
    ["<leader>j"] = { "J", desc = "Join lines" },

    -- find
    ["<leader>ga"] = { "<cmd>'<,'>Gitsign stage_hunk<cr>", desc = "Stage hunk" },
    ["<leader>4"] = {
      function()
        function vim.getVisualSelection()
          vim.cmd 'noau normal! "vy"'
          local text = vim.fn.getreg "v"
          vim.fn.setreg("v", {})

          text = string.gsub(text, "\n", "")
          if #text > 0 then
            return text
          else
            return ""
          end
        end

        local text = vim.getVisualSelection()
        require("telescope.builtin").live_grep { default_text = text }
      end,
      desc = "Find word in selection",
    },

    -- diff
    ["<leader>d"] = {
      function()
        local ftype = vim.api.nvim_eval "&filetype"
        vim.cmd(string.format(
          [[
            execute "normal! \"xy"
            vsplit
            enew
            normal! P
            setlocal buftype=nowrite
            set filetype=%s
            diffthis
            execute "normal! \<C-w>\<C-w>"
            enew
            set filetype=%s
            normal! "xP
            diffthis
          ]],
          ftype,
          ftype
        ))
      end,
      desc = "Compare to clipboard",
    },
  },

  t = {
    -- terminal
    ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    ["<C-q>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
}
