return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = project_root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },

    deactivate = function()
      vim.cmd("Neotree close")
    end,

    init = function()
      -- Helper: git root if available, else CWD.
      -- Global so key callbacks can call it without extra requires.
      function _G.project_root()
        local cwd = vim.uv.cwd()
        local out = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
        if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
          return out[1]
        end
        return cwd
      end

      -- Helper: open path with OS default app (replaces lazy.util.open(..., {system=true}))
      local function system_open(path)
        local p = vim.fn.fnamemodify(path, ":p")
        if vim.fn.has("mac") == 1 then
          vim.fn.jobstart({ "open", p }, { detach = true })
        elseif vim.fn.has("win32") == 1 then
          vim.fn.jobstart({ "cmd.exe", "/c", "start", "", p }, { detach = true })
        else
          vim.fn.jobstart({ "xdg-open", p }, { detach = true })
        end
      end
      _G._neotree_system_open = system_open

      -- Lazy-load when starting nvim with a directory argument (cwd not ready otherwise)
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          end
          local arg0 = vim.fn.argv(0)
          if arg0 == "" then
            return
          end
          local stats = vim.uv.fs_stat(arg0)
          if stats and stats.type == "directory" then
            require("neo-tree")
          end
        end,
      })
    end,

    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },

      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },

      window = {
        position = "left",
        width = 70,
        mappings = {
          -- from your newer config
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              _G._neotree_system_open(state.tree:get_node().path)
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },

          -- from your older config
          c = {
            "add",
            config = { show_path = "relative" }, -- "none", "relative", "absolute"
          },
          C = {
            "add_directory",
            config = { show_path = "relative" },
          },
        },
      },

      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },

      event_handlers = {
        {
          event = "file_added",
          handler = function(file_path)
            vim.cmd("edit " .. vim.fn.fnameescape(file_path))
            vim.defer_fn(function()
              require("neo-tree.command").execute({ action = "close" })
            end, 100)
          end,
        },
        {
          event = "file_opened",
          handler = function(_file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },

    config = function(_, opts)
      -- Optional: Snacks rename integration, only if installed
      local ok_snacks, Snacks = pcall(require, "snacks")
      if ok_snacks and Snacks.rename and Snacks.rename.on_rename_file then
        local function on_move(data)
          Snacks.rename.on_rename_file(data.source, data.destination)
        end
        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
          { event = events.FILE_MOVED, handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
        })
      end

      require("neo-tree").setup(opts)

      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
