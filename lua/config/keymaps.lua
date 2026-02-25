local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- nvim
map({ "n", "i", "v" }, "<c-q>", "<cmd>quitall!<cr>", { desc = "Quit", remap = true })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>bn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>sd", "<cmd>SessionDelete<cr>", { desc = "Session delete" })

-- package
map("n", "<leader>ps", "<cmd>Lazy install<cr>", { desc = "Lazy" })
map("n", "<leader>pe", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>pn", "<cmd>LspInfo<cr>", { desc = "LSP" })
map("n", "<leader>pl", "<cmd>NullLsInfo<cr>", { desc = "Null-ls" })

-- git
map("n", "<leader>g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "<leader>g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "<leader>gf", "<cmd>Gitsign diffthis<cr>", { desc = "View diff" })
map("n", "<leader>gd", "<cmd>Gitsign reset_hunk<cr>", { desc = "Reset hunk" })
map("v", "<leader>gd", function()
  package.loaded.gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset hunk" })
map("n", "<leader>gD", "<cmd>Gitsign reset_buffer<cr>", { desc = "Reset buffer" })
map("n", "<leader>ga", "<cmd>Gitsign stage_hunk<cr>", { desc = "Stage hunk" })
map("v", "<leader>ga", function()
  package.loaded.gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage hunk" })
map("n", "<leader>gA", "<cmd>Gitsign stage_buffer<cr>", { desc = "Stage buffer" })
map("n", "<leader>gu", "<cmd>Gitsign undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
map("n", "<leader>gp", "<cmd>Gitsign preview_hunk_inline<cr>", { desc = "Preview hunk" })
map("n", "<leader>gs", function()
  Snacks.picker.git_status()
end, { desc = "Git status" })
map("n", "<leader>gS", function()
  local gs = require("gitsigns")
  local cfg = require("gitsigns.config").config
  local enable = not cfg.word_diff -- if word_diff is off -> turn the bundle on

  gs.toggle_deleted(enable)
  gs.toggle_linehl(enable)
  gs.toggle_numhl(enable)
  gs.toggle_word_diff(enable)

  vim.notify("Gitsigns view " .. (enable and "ON" or "OFF"))
end, { desc = "Toggle gitsigns view (deleted/linehl/numhl/word_diff)" })

map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Branches" })
map("n", "<leader>gB", "<cmd>AdvancedGitSearch diff_branch_file<CR>", { desc = "Branches" })
map("n", "<leader>gc", function()
  Snacks.picker.git_log()
end, { desc = "Commits (repo)" })
map("n", "<leader>gC", "<cmd>AdvancedGitSearch search_log_content_file<CR>", { desc = "Commits (file)" })
map("n", "<leader>gr", "<cmd>Telescope git_bcommits<CR>", { desc = "Restore commit (file)" })
map("v", "<leader>gr", "<cmd>Telescope git_bcommits_range<CR>", { desc = "Restore commit (range)" })
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
map("n", "<leader>gm", "?https.*merge<CR>y$", { desc = "Copy merge request URL" })
map("n", "<leader>gu", "<cmd>GitBlameCopyFileURL<CR>", { desc = "Copy file URL" })

map("n", "<leader>gl", function()
  require("gitsigns").blame_line()
end, { desc = "Blame" })
map("n", "<leader>gL", function()
  Snacks.git.blame_line()
end, { desc = "Blame (full)" })
map("n", "<leader>gg", function()
  Snacks.terminal.toggle({ "lazygit" })
end, { desc = "Lazygit" })
map("n", "<leader>gl", function()
  Snacks.terminal.toggle({ "gitui" })
end, { desc = "Gitui" })

-- file
map("n", "<leader>W", "<cmd>w !sudo tee %<cr>", { desc = "Force write" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><cmd>stopinsert<cr>", { desc = "Save file" })
map("n", "<leader><C-s>", "<cmd>noa w<cr>", { desc = "Save without formatting" })

-- find
map({ "n", "v" }, "<leader>1", function()
  Snacks.picker.resume()
end, { desc = "Resume previous search" })
map({ "n", "v" }, "<leader><S-1>", "<cmd> Telescope resume<cr>", { desc = "Resume previous search" })
map({ "n", "v" }, "<leader>3", function()
  require("telescope.builtin").commands()
end, { desc = "Commands" })
map({ "n", "v" }, "<leader>#", function()
  Snacks.picker.keymaps()
end, { desc = "Find keymaps" })
map("n", "<leader>4", "<cmd> Telescope live_grep_args<cr>", { desc = "Find word" })
map("v", "<leader>4", function()
  function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end

  local text = vim.getVisualSelection()
  require("telescope").extensions.live_grep_args.live_grep_args({ default_text = text })
end, { desc = "Find word in selection" })
map("n", "<leader>fsr", function()
  Snacks.picker.resume()
end, { desc = "Snacks resume" })
map("n", "<leader>fp", function()
  Snacks.picker()
end, { desc = "Snacks picker" })
map("n", "<leader><leader>", function()
  Snacks.picker.smart({ hidden = true, ignored = false })
end, { desc = "Find git files" })
map("v", "<leader><leader>", function()
  function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end

  local text = vim.getVisualSelection()
  require("telescope").extensions.live_grep_args.live_grep_args({ default_text = text })
end, { desc = "Find word in selection" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find files" })
map("v", "<leader>ff", function()
  function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end

  local text = vim.getVisualSelection()

  require("telescope.builtin").find_files({ hidden = true, no_ignore = true, default_text = text })
end, { desc = "Find files" })
map("n", "<leader>fF", function()
  require("telescope.builtin").git_files()
end, { desc = "Find git files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep<cr>", { desc = "Find word" })
map("n", "<leader>fW", "<cmd> Telescope grep_string<cr>", { desc = "Find word (fuzzy)" })
map("n", "<leader>fh", "<cmd> Telescope oldfiles<cr>", { desc = "Find history" })
map("n", "<leader>fH", "<cmd> Telescope help_tags<cr>", { desc = "Find help" })
map("n", "<leader>0", "<cmd> Telescope buffers<cr>", { desc = "Buffers" })
map(
  "n",
  "<leader>fo",
  "<cmd> Telescope file_browser path=%:p:h select_buffer=true<cr>",
  { desc = "File browser", silent = true }
)
map("n", ")", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffer", silent = true })
map("n", "<leader>fm", "<cmd> Telescope marks<cr>", { desc = "Find marks" })
map("n", "<leader>fk", function()
  require("telescope.builtin").keymaps()
end, { desc = "Find keymaps" })
map("n", "<leader>fn", function()
  require("noice").cmd("history")
end, { desc = "Find notifications" })
map("n", "<leader>fj", function()
  require("telescope.builtin").jumplist()
end, { desc = "Find jumplist" })
map("n", "<leader>f/", "<cmd> Telescope builtin<cr>", { desc = "Find builtin" })

-- editing/intellisense/code
map("n", "gi", function()
  vim.lsp.buf.hover()
end, { desc = "Hover symbol details" })
map("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Hover problems" })
map("n", "gc", require("actions-preview").code_actions, { desc = "Code action" })
map("n", "gC", function()
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source",
      },
      diagnostics = {},
    },
  })
end, { desc = "Source action" })
map("n", "g1", function()
  vim.diagnostic.goto_prev()
end, { desc = "Prev problem" })
map("n", "g2", function()
  vim.diagnostic.goto_next()
end, { desc = "Next problem" })
map("n", "<leader>o", "<cmd>SymbolsOutline<cr>", { desc = "Open symbols outline" })
map("n", "<leader>2", function()
  require("telescope.builtin").lsp_definitions()
end, { desc = "Definition" })
map("n", "<leader>'", function()
  vim.lsp.buf.hover()
end, { desc = "Hover symbol details" })
map("n", "<leader>,", function()
  vim.diagnostic.open_float()
end, { desc = "Hover diagnostics" })
map("n", "<leader>.", require("actions-preview").code_actions, { desc = "Code action" })
map("n", "<leader>>", function()
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source",
      },
      diagnostics = {},
    },
  })
end, { desc = "Source action" })
map("n", "gi", function()
  require("telescope.builtin").lsp_implementations({ reuse_win = true })
end, { desc = "Goto Implementation" })
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename current symbol" })
map("i", "<esc><esc>", "<c-o>")

-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Toggle comment line" })
map(
  "v",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment for selection" }
)

-- terminal
map({ "n", "v", "t" }, "<C-t>", "<Cmd>lua Snacks.terminal.toggle()<CR>", { desc = "Toggle terminal" })

-- diff
map("n", "<leader>Dc", function()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd("vsplit")
  vim.cmd("enew")
  vim.cmd("normal! P")
  vim.cmd("setlocal buftype=nowrite")
  vim.cmd("set filetype=" .. ftype)
  vim.cmd("diffthis")
  vim.cmd([[execute "normal! \<C-w>h"]])
  vim.cmd("diffthis")
end, { desc = "Compare with clipboard" })
map("v", "<leader>Dc", function()
  local ftype = vim.api.nvim_eval("&filetype")
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
end, { desc = "Compare with clipboard" })
map("n", "<leader>Df", function()
  require("telescope").extensions.diff.diff_current({ hidden = true })
end, { desc = "Compare with file" })

-- buffer
-- map("n", "<leader>b", { name = "Buffers" })
map("n", "Q", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "<leader>x", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "X", "<Cmd>b#<CR>", { desc = "Restore buffer" })
map("n", "<leader>X", "<Cmd>b#<CR>", { desc = "Restore buffer" })
map("n", "<leader>bx", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "<leader>bX", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Close buffers" })
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map({ "n", "x", "i" }, "!", "<Cmd>lua require('bufferline').go_to(1, true)<CR>", { desc = "Go to buffer 1" })
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin buffer" })
map("n", "<leader>bj", "<Cmd>BufferLineMovePrev<CR>", { desc = "Buffer move prev" })
map("n", "<leader>bk", "<Cmd>BufferLineMoveNext<CR>", { desc = "Buffer move next" })
map("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close left tabs" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close right tabs" })
map("n", "<leader>bc", "<cmd>enew<cr>", { desc = "Create file" })
map("n", "<leader>br", function()
  Snacks.rename.rename_file()
end, { desc = "Rename file" })

-- window
map({ "n", "x", "i" }, "<c-w>1", "<Cmd>lua require('bufferline').go_to(1, true)<CR>", { desc = "Go to buffer 1" })
map({ "n", "x", "i" }, "<c-w><up>", "<Cmd>wincmd k<CR>", { desc = "Focus up window" })
map({ "n", "x", "i" }, "<c-w><down>", "<Cmd>wincmd j<CR>", { desc = "Focus down window" })
map({ "n", "x", "i" }, "<c-w><left>", "<Cmd>wincmd h<CR>", { desc = "Focus left window" })
map({ "n", "x", "i" }, "<c-w><right>", "<Cmd>wincmd l<CR>", { desc = "Focus right window" })
map({ "n", "x", "i" }, "<c-w><c-m><up>", "<Cmd>wincmd K<CR>", { desc = "Move up window" })
map({ "n", "x", "i" }, "<c-w><c-m><down>", "<Cmd>wincmd J<CR>", { desc = "Move down window" })
map({ "n", "x", "i" }, "<c-w><c-m><left>", "<Cmd>wincmd H<CR>", { desc = "Move left window" })
map({ "n", "x", "i" }, "<c-w><c-m><right>", "<Cmd>wincmd L<CR>", { desc = "Move right window" })
map({ "n", "x", "i" }, "<c-w>'", "<Cmd>wincmd v<CR>", { desc = "Split vertical" })
map({ "n", "x", "i" }, '<c-w>"', "<Cmd>wincmd s<CR>", { desc = "Split horizontal" })
map({ "n", "x", "i" }, "<c-w>Q", "<Cmd>wincmd =<CR>", { desc = "Reset balance" })
map({ "n", "x", "i" }, "<c-w>F", "<Cmd>wincmd =<CR>", { desc = "Reset balance" })
map({ "n", "x", "i" }, "<c-w>f", "<Cmd>wincmd |<CR><Cmd>wincmd _<CR>", { desc = "Maximise" })
map({ "n", "x", "i" }, "<c-w>x", "<Cmd>wincmd q<CR>", { desc = "Close window" })
map({ "n", "x", "i" }, "<c-w>X", "<Cmd>wincmd o<CR>", { desc = "Close other windows" })
map({ "n", "x", "i" }, "<c-w>c", "<Cmd>wincmd q<CR>", { desc = "Close window" })
map({ "n", "x", "i" }, "<c-w>C", "<Cmd>wincmd o<CR>", { desc = "Close other windows" })
map({ "n", "x", "i" }, "<c-w>>", "<Cmd>wincmd r<CR>", { desc = "Rotate" })
map({ "n", "x", "i" }, "<c-w><", "<Cmd>wincmd R<CR>", { desc = "Rotate" })
map({ "n", "x", "i" }, "<c-w>k", "<Cmd>wincmd K<CR>", { desc = "Horizontal" })
map({ "n", "x", "i" }, "<c-w><c-v>", "<Cmd>wincmd H<CR>", { desc = "Vertical" })
map({ "n", "x", "i" }, "<c-w>h", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map({ "n", "x", "i" }, "<c-w>l", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<c-w>j", "<Cmd>BufferLineMovePrev<CR>", { desc = "Buffer move prev" })
map("n", "<c-w>k", "<Cmd>BufferLineMoveNext<CR>", { desc = "Buffer move next" })
map("n", "<c-w>tx", "<Cmd>tabclose<CR>", { desc = "Tab close" })
map("n", "<c-w>th", "<Cmd>tabprevious<CR>", { desc = "Tab previous" })
map("n", "<c-w>tl", "<Cmd>tabnext<CR>", { desc = "Tab next" })
map(
  { "n", "x", "i" },
  "<c-w>L",
  "<Cmd>wincmd ><CR><Cmd>wincmd ><CR><Cmd>wincmd ><CR><Cmd>wincmd ><CR>",
  { desc = "Increase width" }
)
map(
  { "n", "x", "i" },
  "<c-w>H",
  "<Cmd>wincmd <<CR><Cmd>wincmd <<CR><Cmd>wincmd <<CR><Cmd>wincmd <<CR>",
  { desc = "Decrease width" }
)
map(
  { "n", "x", "i" },
  "<c-w>J",
  "<Cmd>wincmd +<CR><Cmd>wincmd +<CR><Cmd>wincmd +<CR><Cmd>wincmd +<CR>",
  { desc = "Increase height" }
)
map(
  { "n", "x", "i" },
  "<c-w>K",
  "<Cmd>wincmd -<CR><Cmd>wincmd -<CR><Cmd>wincmd -<CR><Cmd>wincmd -<CR>",
  { desc = "Increase height" }
)

-- arrow
map({ "n", "x" }, "<Up>", "{")
map({ "n", "x" }, "<Down>", "}")

-- move
map("n", "<S-Up>", ":MoveLine(-1)<cr>", { desc = "Move line up" })
map("n", "<S-Down>", ":MoveLine(1)<cr>", { desc = "Move line down" })
map("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("n", "<S-Left>", ":MoveHChar(-1)<cr>", { desc = "Move char left" })
map("n", "<S-Right>", ":MoveHChar(1)<cr>", { desc = "Move char right" })

map("v", "<S-Up>", ":MoveBlock(-1)<cr>", { desc = "Move line up" })
map("v", "<S-Down>", ":MoveBlock(1)<cr>", { desc = "Move line down" })
map("v", "<S-Left>", ":MoveHBlock(-1)<cr>", { desc = "Move block left" })
map("v", "<S-Right>", ":MoveHBlock(1)<cr>", { desc = "Move block right" })

-- paste
map("n", "<C-v>", "gP")
map("i", "<C-v>", "<C-O>:set noai<CR><C-r>*<C-O>:set ai<CR>")
map("v", "<C-v>", "P")
map("c", "<C-v>", "<C-r>")

-- editing
map("n", "<bs>", "X")
map("n", "<del>", "x")
-- map("n", "<cr>", "ciw")
map("v", "<leader>j", "J", { desc = "Join lines" })
