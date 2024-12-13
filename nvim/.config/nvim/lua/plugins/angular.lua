return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Get the current workspace path
    local get_node_modules = function(root_dir)
      return root_dir .. '/node_modules'
    end

    lspconfig.angularls.setup {
      capabilities = capabilities,
      filetypes = {
        'typescript',
        'html',
        'typescriptreact',
        'typescript.tsx',
      },
      root_dir = lspconfig.util.root_pattern('angular.json', 'project.json'),
      -- Properly configure the Angular Language Server command
      on_new_config = function(new_config, new_root_dir)
        local node_modules = get_node_modules(new_root_dir)
        new_config.cmd = {
          'ngserver',
          '--stdio',
          '--tsProbeLocations',
          node_modules,
          '--ngProbeLocations',
          node_modules,
        }
      end,
      settings = {
        angular = {
          validateTemplates = true,
          trace = {
            server = 'messages',
          },
          analyzeTemplates = true,
          format = {
            enable = true,
            indentSize = 2,
            tabSize = 2,
            insertSpaces = true,
          },
          autoImportOnFileOpen = true,
          suggestionActions = {
            enable = true,
          },
          completion = {
            enableSuggestions = true,
          },
        },
      },
      on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      end,
    }
  end,
}
