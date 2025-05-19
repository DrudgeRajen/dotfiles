return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-frecency.nvim", {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make', -- Ensure you build the native extension
  },
  },


  config = function()
    local actions = require("telescope.actions")
    require("telescope")
        .setup({
          defaults = {
            mappings = {

              i = {
                ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist
              },
            },
            vimgrep_arguments = {
              "rg",
              "--follow",        -- Follow symbolic links
              "--hidden",        -- Search for hidden files
              "--no-heading",    -- Don't group matches by each file
              "--with-filename", -- Print the file path with the matched lines
              "--line-number",   -- Show line numbers
              "--column",        -- Show column numbers
              "--smart-case",    -- Smart case search

              -- Exclude some patterns from search
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/.vscode/*",
              "--glob=!**/Cargo.lock",
            },
            -- General Telescope configuration
            prompt_prefix = '🔍 ',
            selection_caret = '❯ ',
            sorting_strategy = 'ascending',
            layout_config = {
              prompt_position = 'top',
            },
          },
          pickers = {
            find_files = {
              theme = "dropdown",
              hidden = true,
              -- needed to exclude some files & dirs from general search
              -- when not included or specified in .gitignore
              find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob=!**/.git/*",
                "--glob=!**/.idea/*",
                "--glob=!**/.vscode/*",
                "--glob=!**/Cargo.lock",
              },
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,                   -- Enable fuzzy matching
              override_generic_sorter = true, -- Use fzf for general sorters
              override_file_sorter = true,    -- Use fzf for file sorting
              case_mode = 'smart_case',       -- Smart case for matching
            },
          },
        })

    -- Load the fzf extension
    require('telescope').load_extension('fzf')

    require("telescope").load_extension("frecency")

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>pf', function()
      builtin.find_files({ previewer = false })
    end, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)
    vim.keymap.set('n', '<leader>uC', builtin.colorscheme, { desc = "List available colorscheme" })


    vim.keymap.set('n', '<leader>fr', function()
      require('telescope').extensions.frecency.frecency({ workspace = 'CWD', theme = "ivy" })
      builtin.find_files({ previewer = false })
    end, { desc = 'Telescope Frecency (CWD)' })
  end
}
