return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 30,
      mappings = {
        c = {
          "add",
          config = {
            show_path = "relative", -- "none", "relative", "absolute"
          },
        },
        C = {
          "add_directory",
          config = {
            show_path = "relative", -- "none", "relative", "absolute"
          },
        },
      },
    },
  },
}
