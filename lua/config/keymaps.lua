local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function with_mode(fn)
  return function(...)
    local buf = vim.api.nvim_get_current_buf()
    vim.b[buf].pre_picker_mode = vim.fn.mode()
    vim.b[buf].pre_picker_buf = buf
    fn(...)
  end
end

local function with_mode_cmd(cmd)
  return with_mode(function()
    vim.cmd(cmd)
  end)
end

-- nvim
map({ "n", "i", "v" }, "<c-q>", "<cmd>quitall!<cr>", { desc = "Quit", remap = true })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>bn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>sd", "<cmd>SessionDelete<cr>", { desc = "Session delete" })
map("n", "<leader>sd", "<cmd>SessionDelete<cr>", { desc = "Session delete" })

-- package
map("n", "<leader>ps", "<cmd>Lazy install<cr>", { desc = "Lazy" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>pl", "<cmd>LspInfo<cr>", { desc = "LSP" })
map("n", "<leader>pc", "<cmd>ConformInfo<cr>", { desc = "Conform" })
map("n", "<leader>pt", "<cmd>LintInfo<cr>", { desc = "Lint" })

-- git
map("n", "<leader>g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "<leader>g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "g4", "<cmd>Gitsign prev_hunk<cr>", { desc = "Prev hunk" })
map("n", "g3", "<cmd>Gitsign next_hunk<cr>", { desc = "Next hunk" })
map("n", "<leader>gf", "<cmd>CodeDiff file HEAD<cr>", { desc = "View diff" })
map("n", "<leader>gd", "<cmd>Gitsign reset_hunk<cr>", { desc = "Reset hunk" })
map("v", "<leader>gd", function()
  package.loaded.gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset hunk" })
map("n", "<leader>gD", "<cmd>Gitsign reset_buffer<cr>", { desc = "Reset buffer" })
map("n", "<leader>ga", "<cmd>Gitsign stage_hunk<cr>", { desc = "Stage hunk" })
map("v", "<leader>ga", function()
  package.loaded.gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage hunk" })
map("n", "<leader>gA", function()
  local gs = require("gitsigns")
  local hunks = gs.get_hunks()
  if hunks and #hunks > 0 then
    gs.stage_buffer()
  else
    gs.reset_buffer_index()
  end
end, { desc = "Stage/unstage buffer" })
map("n", "<leader>gu", "<cmd>Gitsign undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
map("n", "<leader>gp", "<cmd>Gitsign preview_hunk_inline<cr>", { desc = "Preview hunk" })
map("n", "<leader>ge", "<cmd>CodeDiff<cr>", { desc = "CodeDiff" })
map(
  "n",
  "<leader>gs",
  with_mode(function()
    Snacks.picker.git_status()
  end),
  { desc = "Git status" }
)
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

map(
  "n",
  "<leader>gb",
  with_mode(function()
    Snacks.picker.git_branches()
  end),
  { desc = "Branches" }
)
map("n", "<leader>gc", with_mode_cmd("AdvancedGitSearch search_log_content"), { desc = "Commits (repo)" })
map("n", "<leader>gC", with_mode_cmd("AdvancedGitSearch search_log_content_file"), { desc = "Commits (file)" })
map("n", "<leader>gr", with_mode_cmd("Telescope git_bcommits"), { desc = "Restore commit (file)" })
map("v", "<leader>gr", with_mode_cmd("Telescope git_bcommits_range"), { desc = "Restore commit (range)" })
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
map("n", "<leader>gm", "?https.*merge<CR>y$", { desc = "Copy merge request URL" })
map("n", "<leader>gy", "<cmd>GitBlameCopyFileURL<CR>", { desc = "Copy file URL" })

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
map("n", "<leader>gh", "<cmd>CodeDiff history<CR>", { desc = "CodeDiff history" })

-- file
map("n", "<leader>W", function()
  local password = vim.fn.inputsecret("sudo password: ")
  if password == "" then
    return
  end
  local tmp = vim.fn.tempname()
  vim.cmd("silent! write! " .. vim.fn.fnameescape(tmp))
  vim.fn.system(
    "echo "
      .. vim.fn.shellescape(password)
      .. " | sudo -S cp "
      .. vim.fn.shellescape(tmp)
      .. " "
      .. vim.fn.shellescape(vim.fn.expand("%:p"))
  )
  vim.fn.delete(tmp)
  vim.cmd("silent! edit!")
  vim.bo.readonly = false
  vim.bo.modified = false
end, { desc = "Sudo write" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><cmd>stopinsert<cr>", { desc = "Save file" })
map("n", "<leader><C-s>", "<cmd>noa w<cr>", { desc = "Save without formatting" })

-- find
map(
  { "n", "v" },
  "<leader>1",
  with_mode(function()
    Snacks.picker.resume()
  end),
  { desc = "Resume previous snacks search" }
)
map({ "n", "v" }, "<leader>2", with_mode_cmd("Telescope resume"), { desc = "Resume previous telescope search" })
map(
  { "n", "v" },
  "<leader>3",
  with_mode(function()
    require("telescope.builtin").commands()
  end),
  { desc = "Commands" }
)
map(
  { "n", "v" },
  "<leader>#",
  with_mode(function()
    Snacks.picker.keymaps()
  end),
  { desc = "Find keymaps" }
)
map("n", "<leader>4", with_mode_cmd("Telescope live_grep_args"), { desc = "Find word" })
map(
  "v",
  "<leader>4",
  with_mode(function()
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
  end),
  { desc = "Find word in selection" }
)
map(
  "n",
  "<leader>fsr",
  with_mode(function()
    Snacks.picker.resume()
  end),
  { desc = "Snacks resume" }
)
map(
  "n",
  "<leader>fp",
  with_mode(function()
    Snacks.picker()
  end),
  { desc = "Snacks picker" }
)
map(
  "n",
  "<leader><leader>",
  with_mode(function()
    Snacks.picker.smart({ hidden = true, ignored = false })
  end),
  { desc = "Find git files" }
)
map(
  "v",
  "<leader><leader>",
  with_mode(function()
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
  end),
  { desc = "Find word in selection" }
)
map(
  "n",
  "<leader>ff",
  with_mode(function()
    require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
  end),
  { desc = "Find files" }
)
map(
  "v",
  "<leader>ff",
  with_mode(function()
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
  end),
  { desc = "Find files" }
)
map(
  "n",
  "<leader>fF",
  with_mode(function()
    require("telescope.builtin").git_files()
  end),
  { desc = "Find git files" }
)
map("n", "<leader>ft", with_mode_cmd("Telescope"), { desc = "Telescope" })
map("n", "<leader>fh", with_mode_cmd("Telescope oldfiles"), { desc = "Find history" })
map("n", "<leader>fH", with_mode_cmd("Telescope help_tags"), { desc = "Find help" })
map("n", "<leader>0", with_mode_cmd("Telescope buffers"), { desc = "Buffers" })
map(
  "n",
  "<leader>fo",
  with_mode_cmd("Telescope file_browser path=%:p:h select_buffer=true"),
  { desc = "File browser", silent = true }
)
map(
  "n",
  ")",
  with_mode(function()
    require("telescope.builtin").buffers()
  end),
  { desc = "Find buffer", silent = true }
)
map("n", "<leader>fm", "<cmd> messages<cr>", { desc = "Find messages" })
map("n", "<leader>fM", with_mode_cmd("Telescope marks"), { desc = "Find marks" })
map(
  "n",
  "<leader>fk",
  with_mode(function()
    require("telescope.builtin").keymaps()
  end),
  { desc = "Find keymaps" }
)
map("n", "<leader>fn", function()
  require("noice").cmd("history")
end, { desc = "Find notifications" })
map(
  "n",
  "<leader>fj",
  with_mode(function()
    require("telescope.builtin").jumplist()
  end),
  { desc = "Find jumplist" }
)
map("n", "<leader>f/", with_mode_cmd("Telescope builtin"), { desc = "Find builtin" })

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
local function goto_trouble_or_diagnostic(direction)
  local ok, trouble = pcall(require, "trouble")
  if ok and require("trouble").is_open() then
    if direction == "prev" then
      trouble.prev({ skip_groups = true, jump = true })
    else
      trouble.next({ skip_groups = true, jump = true })
    end
  else
    if direction == "prev" then
      vim.diagnostic.goto_prev()
    else
      vim.diagnostic.goto_next()
    end
  end
end

map("n", "g1", function()
  goto_trouble_or_diagnostic("prev")
end, { desc = "Prev trouble" })
map("n", "g2", function()
  goto_trouble_or_diagnostic("next")
end, { desc = "Next trouble" })
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
map(
  "n",
  "gi",
  with_mode(function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end),
  { desc = "Goto Implementation" }
)
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename current symbol" })
map("n", "<leader>gn", function()
  require("nvim-navbuddy").open()
end, { desc = "Navbuddy" })

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
map(
  "n",
  "<leader>Df",
  with_mode(function()
    require("snacks").picker.smart({
      hidden = true,
      confirm = function(picker, item)
        picker:close()
        vim.schedule(function()
          local current = vim.api.nvim_buf_get_name(0)
          if current == "" or not item then
            return
          end
          vim.cmd(
            ("CodeDiff file %s %s"):format(
              vim.fn.fnameescape(item.file or item.path or item.value or ""),
              vim.fn.fnameescape(current)
            )
          )
        end)
      end,
    })
  end),
  { desc = "Compare with file" }
)

-- buffer
-- map("n", "<leader>b", { name = "Buffers" })
map("n", "Q", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "<leader>x", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "X", "<Cmd>b#<CR>", { desc = "Restore buffer" })
map("n", "<leader>X", "<Cmd>b#<CR>", { desc = "Restore buffer" })
map("n", "<leader>bx", "<Cmd>bd!<CR>", { desc = "Close buffer" })
map("n", "<leader>bd", "<Cmd>bd!<CR>", { desc = "Delete buffer" })
map("n", "<leader>bd", function()
  local file = vim.fn.expand("%")
  if file ~= "" then
    vim.fn.delete(file)
    vim.cmd("bd!")
  end
end, { desc = "Delete buffer" })
map("n", "<leader>bX", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Close buffers" })
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map({ "n", "x" }, "!", "<Cmd>lua require('bufferline').go_to(1, true)<CR>", { desc = "Go to buffer 1" })
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin buffer" })
map("n", "<leader>bj", "<Cmd>BufferLineMovePrev<CR>", { desc = "Buffer move prev" })
map("n", "<leader>bk", "<Cmd>BufferLineMoveNext<CR>", { desc = "Buffer move next" })
map("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close left tabs" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close right tabs" })
map("n", "<leader>bc", "<cmd>enew<cr><cmd>startinsert<cr>", { desc = "Create file" })
map("n", "<leader>br", function()
  Snacks.rename.rename_file()
end, { desc = "Rename file" })
map("n", "<leader>by", "<cmd>let @+=expand('%:p')<cr>", { desc = "Copy path" })

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
map({ "n", "x", "o" }, "<Up>", "{")
map({ "n", "x", "o" }, "<Down>", "}")

-- treewalker
map("n", "<S-Up>", ":Treewalker Up<cr>", { desc = "Treewalker Up" })
map("n", "<S-Down>", ":Treewalker Down<cr>", { desc = "MoTreewalker Down" })
map({ "n", "o" }, "<S-Left>", ":Treewalker Left<cr>", { desc = "Treewalker Left" })
map({ "n", "o" }, "<S-Right>", ":Treewalker Right<cr>", { desc = "Treewalker Right" })
map({ "v" }, "<S-Left>", ":Treewalker SwapUp<cr>", { desc = "Treewalker SwapUp" })
map({ "v" }, "<S-Right>", ":Treewalker SwapDown<cr>", { desc = "Treewalker SwapDown" })

-- move
map("v", "<S-Up>", ":MoveBlock(-1)<cr>", { desc = "Move line up" })
map("v", "<S-Down>", ":MoveBlock(1)<cr>", { desc = "Move line down" })
map("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

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
