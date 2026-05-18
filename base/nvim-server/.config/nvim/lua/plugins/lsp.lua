return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'folke/which-key.nvim',
    'b0o/schemastore.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode, opts)
          mode = mode or 'n'
          opts = opts or {}
          opts.buffer = event.buf
          opts.desc = 'LSP: ' .. desc
          vim.keymap.set(mode, keys, func, opts)
        end

        map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('gr', require('telescope.builtin').lsp_references, 'Goto references')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')
        map('gy', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')
        map('K', vim.lsp.buf.hover, 'Hover documentation')
        map('gK', vim.lsp.buf.signature_help, 'Signature help')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.supports_method 'textDocument/inlayHint' then
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end

        if client and client.supports_method 'textDocument/codeAction' then
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
          map('<leader>cR', function()
            return ':IncRename ' .. vim.fn.expand '<cword>'
          end, 'Rename', 'n', { expr = true })
          map('<leader>cr', vim.lsp.buf.rename, 'Rename (LSP)')
          map('<leader>cs', vim.lsp.buf.signature_help, 'Signature help')
          map('<leader>cd', vim.diagnostic.open_float, 'Line diagnostics')
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    local function disable_lsp_highlight()
      vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = 'NONE', underline = false })
      vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = 'NONE', underline = false })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = 'NONE', underline = false })
    end
    disable_lsp_highlight()
    vim.api.nvim_create_autocmd('ColorScheme', { callback = disable_lsp_highlight })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    capabilities.textDocument.semanticTokens = {
      dynamicRegistration = false,
      requests = { full = { delta = true }, range = true },
      tokenTypes = {
        'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter',
        'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method',
        'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator',
      },
      tokenModifiers = {
        'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract',
        'async', 'modification', 'documentation', 'defaultLibrary',
      },
      formats = { 'relative' },
      overlappingTokenSupport = false,
      multilineTokenSupport = false,
    }
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local servers = {
      -- Go (rust_analyzer handled by rustaceanvim, tsserver by typescript-tools.nvim)
      gopls = {
        settings = {
          gopls = {
            analyses = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
              unusedvariable = true,
              simplifycompositelit = true,
              simplifyrange = true,
              simplifyslice = true,
              infertypeargs = true,
            },
            staticcheck = true,
            gofumpt = true,
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            semanticTokens = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-node_modules' },
            ['local'] = '',
            allowImplicitNetworkAccess = true,
          },
        },
      },

      -- Python
      ruff = {
        init_options = {
          settings = {
            lint = { enable = true },
            format = { enable = true },
          },
        },
      },
      pyright = {},

      -- Config files
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = '' },
            schemas = require('schemastore').yaml.schemas(),
            validate = true,
          },
        },
      },

      -- Markdown
      marksman = {},

      -- Lua (for editing nvim config)
      lua_ls = {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, '$XDG_DATA_HOME/nvim/lazy' },
            },
          })
        end,
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' },
            },
            diagnostics = {
              disable = { 'missing-fields' },
              globals = { 'vim' },
            },
            format = { enable = false },
            telemetry = { enable = false },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'prettier',
      'stylua',
      'shfmt',
      'checkmake',
      'ruff',
      'gofumpt',
      'goimports',
      'sql-formatter',
      'golangci-lint',
      'sqlfluff',
      'shellcheck',
      'taplo',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      automatic_installation = { exclude = { 'pylsp', 'rust_analyzer' } },
      handlers = {
        function(server_name)
          local non_lsp_tools = { 'stylua', 'prettier', 'eslint_d', 'gofumpt', 'goimports', 'shfmt' }
          for _, tool in ipairs(non_lsp_tools) do
            if server_name == tool then return end
          end
          if server_name == 'pylsp' then return end

          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    vim.diagnostic.config {
      underline = false,
      virtual_text = false,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
      },
    }
  end,
}
