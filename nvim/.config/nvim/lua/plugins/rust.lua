return {
  -- Rustaceanvim - Modern Rust plugin (replaces rust-tools.nvim)
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Hover actions
          hover_actions = {
            auto_focus = false,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Optional: Add custom keybindings here
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('n', '<leader>ca', function()
              vim.cmd.RustLsp('codeAction')
            end, vim.tbl_extend('force', opts, { desc = 'Code action' }))
            vim.keymap.set('n', '<leader>dr', function()
              vim.cmd.RustLsp('debuggables')
            end, vim.tbl_extend('force', opts, { desc = 'Rust debuggables' }))
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = {
                allFeatures = true,
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },

  -- Optional: Crates.io integration for Cargo.toml
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
    end,
  },
}
