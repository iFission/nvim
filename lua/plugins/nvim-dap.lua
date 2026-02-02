return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "nvim-neotest/nvim-nio" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },
      { "Weissle/persistent-breakpoints.nvim" },
    },
  -- stylua: ignore
  keys = {
    { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
    { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
    { "<leader>dC", function() require('persistent-breakpoints.api').set_conditional_breakpoint() end, desc = "Conditional Breakpoint", },
    { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
    { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
    { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
    { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
    { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
    { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
    { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
    { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
    { "<leader>dt", function() require('persistent-breakpoints.api').toggle_breakpoint() end, desc = "Toggle Breakpoint", },
    { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
    { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
  },
    opts = {
      setup = {},
    },
    config = function(plugin, opts)
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- set up debugger
      for k, _ in pairs(opts.setup) do
        opts.setup[k](plugin, opts)
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        vscode_js_debug = function()
          for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }) do
            require("dap").adapters[adapter] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "node",
                args = {
                  "${port}",
                },
              },
            }
          end

          for _, language in ipairs({ "typescript", "javascript" }) do
            require("dap").configurations[language] = {
              {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
              },
              {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
              {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                webRoot = "${workspaceFolder}",
              },
              {
                type = "pwa-chrome",
                name = "Launch Chrome",
                request = "launch",
                url = "http://localhost:3000", -- This is for Vite. Change it to the framework you use
                webRoot = "${workspaceFolder}",
                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
              },
              {
                name = "Debug CRA Tests",
                type = "pwa-node",
                trace = true,
                request = "launch",
                runtimeExecutable = "${workspaceFolder}/node_modules/.bin/react-scripts",
                args = { "test", "--runInBand", "--no-cache", "--watchAll=false", "${file}" },
                cwd = "${workspaceFolder}",
                protocol = "inspector",
                console = "integratedTerminal",
                env = {
                  CI = "true",
                },
                disableOptimisticBPs = true,
              },
            }
          end

          for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
            require("dap").configurations[language] = {
              {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                webRoot = "${workspaceFolder}",
              },
              {
                type = "pwa-chrome",
                name = "Launch Chrome",
                request = "launch",
                url = "http://localhost:3000", -- This is for Vite. Change it to the framework you use
                webRoot = "${workspaceFolder}",
                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
              },
              {
                name = "Debug CRA Tests",
                type = "pwa-node",
                trace = true,
                request = "launch",
                runtimeExecutable = "${workspaceFolder}/node_modules/.bin/react-scripts",
                args = { "test", "--runInBand", "--no-cache", "--watchAll=false", "${file}" },
                cwd = "${workspaceFolder}",
                protocol = "inspector",
                console = "integratedTerminal",
                env = {
                  CI = "true",
                },
                disableOptimisticBPs = true,
              },
            }
          end
        end,
      },
    },
  },
}
