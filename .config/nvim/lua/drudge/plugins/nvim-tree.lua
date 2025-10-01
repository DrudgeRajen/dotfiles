return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = false,
          },
        },
      },

      ui = {
        confirm = {
          remove = true,
          trash = false,
        },
      },
    })
    vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
  end,
  lazy = true,
  keys = {
    { "<leader>pv", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },
}
