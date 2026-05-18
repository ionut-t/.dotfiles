return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { auto_focus = false },
        },
        server = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('n', '<leader>ca', function()
              vim.cmd.RustLsp 'codeAction'
            end, vim.tbl_extend('force', opts, { desc = 'Code action' }))
          end,
          default_settings = {
            ['rust-analyzer'] = {
              check = { allTargets = true },
              cargo = {
                allFeatures = true,
                allTargets = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = {
                allFeatures = true,
                allTargets = true,
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = { enable = true },
            },
          },
        },
        dap = { adapter = false },
      }
    end,
  },

  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup {
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
  },
}
