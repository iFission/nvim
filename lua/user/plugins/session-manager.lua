return {
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = require("session_manager").setup {
      autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
    },
  },
}
