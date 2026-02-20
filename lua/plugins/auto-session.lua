return {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      -- suppress Neovim intro text (blank start page)
      vim.opt.shortmess:append("I")

      local function list_regular_files(cwd)
        local files = {}
        local fs = vim.uv or vim.loop
        local handle = fs.fs_scandir(cwd)
        if not handle then
          return files
        end

        while true do
          local name, t = fs.fs_scandir_next(handle)
          if not name then
            break
          end
          if t == "file" then
            -- ignore dotfiles; remove this if you want to count them
            if name:sub(1, 1) ~= "." then
              table.insert(files, cwd .. "/" .. name)
            end
          end
        end
        return files
      end

      local function open_neotree(cwd)
        -- defer to avoid racing plugin loading/UI
        vim.schedule(function()
          pcall(vim.cmd, "Neotree close")
          pcall(vim.cmd, "Neotree filesystem reveal left")
        end)
      end

      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

        no_restore_cmds = {
          function()
            -- If started with file args, don't touch anything.
            if vim.fn.argc() > 0 then
              return
            end

            -- Only act if current buffer is truly empty.
            local buf = vim.api.nvim_get_current_buf()
            if vim.api.nvim_buf_get_name(buf) ~= "" then
              return
            end
            if vim.bo[buf].buftype ~= "" then
              return
            end
            if vim.bo[buf].filetype ~= "" then
              return
            end
            if vim.api.nvim_buf_line_count(buf) > 1 or vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= "" then
              return
            end

            local cwd = vim.fn.getcwd()

            -- 1) README.md
            local readme_path = cwd .. "/README.md"
            if vim.fn.filereadable(readme_path) == 1 then
              vim.schedule(function()
                vim.notify("No sessions, opening README", vim.log.levels.INFO)
              end)
              vim.cmd.edit(vim.fn.fnameescape(readme_path))
              return
            end

            -- 2) Exactly one regular file in cwd (plus any folders)
            local files = list_regular_files(cwd)
            if #files == 1 then
              local only_file = files[1]
              vim.schedule(function()
                vim.notify("Opening " .. vim.fn.fnamemodify(only_file, ":t"), vim.log.levels.INFO)
              end)
              vim.cmd.edit(vim.fn.fnameescape(only_file))
              return
            end

            -- 3) Otherwise open Neo-tree
            open_neotree(cwd)
          end,
        },
      })
    end,
  },
}
