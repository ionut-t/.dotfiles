return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js/html/css/json/yaml/markdown formatter
        'stylua', -- lua formatter
        -- Note: eslint_d removed due to high memory usage
        -- typescript-tools.nvim provides linting for TS/JS
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'gofumpt', -- Go formatter (stricter version of gofmt)
        'goimports', -- Go imports formatter
        'sql-formatter', -- SQL formatter
      },
      automatic_installation = true,
    }

    local sources = {
      -- Diagnostics/Linters
      diagnostics.checkmake,
      -- eslint_d removed - using typescript-tools.nvim for TS/JS linting

      -- Formatters
      -- TypeScript/JavaScript/React/Vue/Angular
      formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'css',
          'scss',
          'less',
          'html',
          'htmlangular', -- Angular component templates
          'json',
          'jsonc',
          'yaml',
          'markdown',
          'markdown.mdx',
          'graphql',
          'handlebars',
        },
      },

      -- Lua
      formatting.stylua,

      -- Go
      formatting.gofumpt,
      formatting.goimports,

      -- Shell
      formatting.shfmt.with { args = { '-i', '4' } },

      -- SQL
      formatting.sql_formatter,

      -- Terraform
      formatting.terraform_fmt,

      -- Python (ruff handles both linting and formatting)
      -- Configured to respect project's ruff.toml or pyproject.toml
      require('none-ls.formatting.ruff').with({
        cwd = function()
          return vim.fn.getcwd()
        end,
      }),
      require('none-ls.formatting.ruff_format').with({
        cwd = function()
          return vim.fn.getcwd()
        end,
      }),
    }

    -- Global variable to track format-on-save state
    -- Toggled via snacks.nvim: <leader>uf
    vim.g.format_on_save_enabled = true

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- Only format if globally enabled
              if vim.g.format_on_save_enabled then
                vim.lsp.buf.format { async = false }
              end
            end,
          })
        end
      end,
    }
  end,
}
