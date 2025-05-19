return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },
  -- gruvbox-material
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.cmd.colorscheme "gruvbox-material"
    end

  },
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function()
      -- require("catppuccin").setup({
      --   style = "mocha",
      --   vim.cmd.colorscheme "catppuccin"
      -- })
    end
  },
}
