return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { 'lua_ls', 'gopls', 'yamlls', 'dockerls', 'pyright' },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function()
      local capabilities           = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config.rust_analyzer = {
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        capabilities = capabilities,

        settings = {
          ["rust-analyzer"] = {
            diagnostics = { enable = false },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" }
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              buildScripts = {
                enable = false
              },
              target = nil,
              loadOutDirsFromCheck = false,
            },
            files = {
              watcher = "client"
            },

          },
        },
      }

      vim.lsp.config.yamlls        = {
        settings = {
          yaml = {
            schemas = {
              kubernetes = { "*.k8s.yaml", "k8s-*.yaml", "kube-*.yaml", "deployment.yaml", "service.yaml", "secret.yaml", "ingress.yaml", "cronjob.yaml" },
              ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] =
              "conf/**/*catalog*",
              ["http://json.schemastore.org/github-workflow"] =
              ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] =
              ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] =
              "kustomization.{yml,yaml}",
            },
            customTags = {
              "!Ref", "!Sub", "!GetAtt", "!Condition",
              "!FindInMap sequence",
            },
          }
        }
      }

      vim.lsp.config.gopls         = {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      vim.lsp.config.lua_ls        = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- Use LuaJIT for Neovim
            },
            diagnostics = {
              globals = { 'vim' }, -- Recognize the `vim` global
              enable = true,
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Make Neovim runtime files visible
            },
            telemetry = {
              enable = false, -- Disable telemetry
            },
          },
        },
      }

      vim.lsp.config.pyright       = {}

      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('yamlls')
      vim.lsp.enable('gopls')
      vim.lsp.enable('lua_ls')
    end
  }
}
