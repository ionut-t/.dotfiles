return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    'folke/which-key.nvim',
    -- JSON/YAML schemas for validation
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

        -- Navigation
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('gr', require('telescope.builtin').lsp_references, 'Goto references')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')
        map('gy', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')

        -- Documentation
        map('K', vim.lsp.buf.hover, 'Hover documentation')
        map('gK', vim.lsp.buf.signature_help, 'Signature help')

        -- Note: <leader>sd and <leader>sw handled by Telescope (see telescope.lua)
        -- LSP symbols accessible via Telescope's diagnostics and workspace symbol search

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method 'textDocument/codeAction' then
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
          map('<leader>cR', function()
            return ':IncRename ' .. vim.fn.expand '<cword>'
          end, 'Rename', 'n', { expr = true })
          map('<leader>cr', vim.lsp.buf.rename, 'Rename (LSP)')
          -- Format is handled by conform.nvim (<leader>cf in formatter.lua)
          map('<leader>cs', vim.lsp.buf.signature_help, 'Signature help')
          map('<leader>cd', vim.diagnostic.open_float, 'Line diagnostics')
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

        -- Note: Inlay hints toggle moved to snacks.nvim (<leader>uh)
        -- Snacks provides a global toggle for all buffers
      end,
    })

    -- Disable LSP reference highlighting globally by making it invisible
    -- This fixed the annoying highlight of strings (Angular inline templates, etc.)
    local function disable_lsp_highlight()
      vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = 'NONE', underline = false })
      vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = 'NONE', underline = false })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = 'NONE', underline = false })
    end

    -- Apply immediately
    disable_lsp_highlight()

    -- Reapply after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = disable_lsp_highlight,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    -- Enable semantic tokens for better syntax highlighting
    capabilities.textDocument.semanticTokens = {
      dynamicRegistration = false,
      requests = {
        full = { delta = true },
        range = true,
      },
      tokenTypes = {
        'namespace',
        'type',
        'class',
        'enum',
        'interface',
        'struct',
        'typeParameter',
        'parameter',
        'variable',
        'property',
        'enumMember',
        'event',
        'function',
        'method',
        'macro',
        'keyword',
        'modifier',
        'comment',
        'string',
        'number',
        'regexp',
        'operator',
      },
      tokenModifiers = {
        'declaration',
        'definition',
        'readonly',
        'static',
        'deprecated',
        'abstract',
        'async',
        'modification',
        'documentation',
        'defaultLibrary',
      },
      formats = { 'relative' },
      overlappingTokenSupport = false,
      multilineTokenSupport = false,
    }

    -- Enable file watching for better workspace handling
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- TypeScript/JavaScript handled by typescript-tools.nvim plugin
      -- See plugins/typescript.lua for configuration

      -- Python LSP servers (both run simultaneously)
      ruff = {
        -- Ruff LSP for fast linting and formatting
        init_options = {
          settings = {
            -- Ruff will handle linting and formatting
            -- Let pyright handle type checking
            lint = { enable = true },
            format = { enable = true },
          },
        },
      },
      pyright = {
        -- Pyright reads settings from pyrightconfig.json in project root
        -- No settings needed here - let pyrightconfig.json handle it
      },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      cssls = {},
      tailwindcss = {},
      sqlls = {},
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
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
            validate = true,
          },
        },
      },

      -- Zig Language Server
      zls = {},

      -- Markdown Language Server
      marksman = {},

      -- Docker Language Servers
      dockerls = {},
      docker_compose_language_service = {},

      -- Angular Language Server
      angularls = {
        filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
      },

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
        end,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                '${3rd}/luv/library',
              },
            },
            diagnostics = {
              disable = { 'missing-fields' },
              globals = { 'vim' },
            },
            format = {
              enable = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'prettier', -- ts/js/html/css/json/yaml/markdown formatter
      'stylua', -- lua formatter
      'shfmt', -- Shell formatter
      'checkmake', -- linter for Makefiles
      'ruff', -- Python linter and formatter
      'gofumpt', -- Go formatter (stricter version of gofmt)
      'goimports', -- Go imports formatter
      'sql-formatter', -- SQL formatter
      'golangci-lint', -- Go linter
      'sqlfluff', -- SQL linter
      'shellcheck', -- Shell script linter
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      automatic_installation = { exclude = { 'pylsp' } },
      handlers = {
        function(server_name)
          -- Skip formatters/linters that aren't LSP servers
          local non_lsp_tools = { 'stylua', 'prettier', 'eslint_d', 'gofumpt', 'goimports', 'shfmt' }
          for _, tool in ipairs(non_lsp_tools) do
            if server_name == tool then
              return -- Don't try to set up as LSP
            end
          end

          -- Skip pylsp - we use pyright instead
          if server_name == 'pylsp' then
            return
          end

          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Configure diagnostics for tiny-inline-diagnostic.nvim
    local diagnostic_config = {
      underline = false,
      virtual_text = false,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      float = {
        border = 'rounded',
        source = 'if_many', -- Show source if multiple sources provide diagnostics
        header = '',
        prefix = '',
      },
    }

    vim.diagnostic.config(diagnostic_config)

    -- Note: Diagnostic config persists automatically, no need for ModeChanged autocmd
  end,
}
