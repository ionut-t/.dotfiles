# Neovim Configuration Improvement Recommendations

**Generated**: 2025-10-30
**Configuration Path**: `/Users/ionut-traistaru/.dotfiles/nvim/.config/nvim/`

---

## Table of Contents

1. [Immediate Fixes](#immediate-fixes-do-now)
2. [High Priority](#high-priority-this-week)
3. [Medium Priority](#medium-priority-this-month)
4. [Nice to Have](#nice-to-have-lower-priority)
5. [Performance Optimizations](#performance-optimizations)
6. [Language-Specific Enhancements](#language-specific-enhancements)
7. [File-Specific Issues](#file-specific-issues)
8. [Implementation Checklist](#implementation-checklist)

---

## 🔴 Immediate Fixes (Do Now)

### 1. Lualine Theme Mismatch
**Issue**: Editor uses Catppuccin Mocha but lualine uses Nord theme
**File**: `lua/plugins/lualine.lua:43`
**Fix**:
```lua
theme = 'catppuccin', -- Changed from 'nord'
```
**Priority**: HIGH - Visual inconsistency
**Effort**: 2 minutes

---

### 2. Duplicate Option Settings
**Issue**: Settings duplicated between `options.lua` and `keymaps.lua`
**Files**:
- `lua/core/options.lua`
- `lua/core/keymaps.lua`

**Duplicates Found**:
- `scrolloff`: Set to 4 in options.lua, 10 in keymaps.lua
- `clipboard`: Set in both files
- `cursorline`: Set in both files
- `number`, `relativenumber`: Set in both files

**Fix**: Remove all option settings from `keymaps.lua`, keep only in `options.lua`
**Exception**: Keep scheduled clipboard setting in keymaps.lua (better for startup)
**Priority**: HIGH - Potential configuration conflicts
**Effort**: 5 minutes

---

### 3. Missing Hover Documentation Keymap
**Issue**: No `K` keymap for LSP hover (standard convention)
**File**: `lua/plugins/lsp.lua` (in LspAttach callback)
**Fix**:
```lua
map('K', vim.lsp.buf.hover, 'Hover Documentation')
```
**Priority**: HIGH - Missing essential LSP feature
**Effort**: 1 minute

---

### 4. JSON/YAML Schema Validation Missing
**Issue**: No schema validation for package.json, tsconfig.json, docker-compose.yml, etc.
**File**: `lua/plugins/lsp.lua`

**Fix**:
1. Add dependency to lsp.lua:
```lua
dependencies = {
  'b0o/schemastore.nvim', -- JSON/YAML schemas
  -- ... other dependencies
}
```

2. Update jsonls configuration:
```lua
jsonls = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
},
```

3. Update yamlls configuration:
```lua
yamlls = {
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
    },
  },
},
```

**Priority**: HIGH - Critical for TypeScript/Angular development
**Effort**: 10 minutes

---

### 5. Fix scrolloff Conflict
**Issue**: `scrolloff` set to different values in two files
**Files**: `lua/core/options.lua`, `lua/core/keymaps.lua`
**Fix**: Choose one value (recommend 10), remove from other file
**Priority**: MEDIUM
**Effort**: 1 minute

---

## 🟠 High Priority (This Week)

### 6. Session Management
**Issue**: No session persistence across Neovim restarts
**Benefit**: Restore workspace (buffers, windows, tabs) per project

**Implementation**: Create `lua/plugins/session.lua`
```lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  },
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore Session',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore Last Session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.session'` to lazy.setup
**Priority**: HIGH
**Effort**: 15 minutes

---

### 7. Advanced Refactoring Tools
**Issue**: No dedicated refactoring for TypeScript/JavaScript/Go
**Missing**: Extract function, inline variable, extract to file, etc.

**Implementation**: Create `lua/plugins/refactoring.lua`
```lua
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {}

    -- Keymaps
    vim.keymap.set('x', '<leader>re', function()
      require('refactoring').refactor 'Extract Function'
    end, { desc = '[R]efactor [E]xtract Function' })

    vim.keymap.set('x', '<leader>rf', function()
      require('refactoring').refactor 'Extract Function To File'
    end, { desc = '[R]efactor Extract Function to [F]ile' })

    vim.keymap.set('x', '<leader>rv', function()
      require('refactoring').refactor 'Extract Variable'
    end, { desc = '[R]efactor Extract [V]ariable' })

    vim.keymap.set('n', '<leader>rI', function()
      require('refactoring').refactor 'Inline Function'
    end, { desc = '[R]efactor [I]nline Function' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
      require('refactoring').refactor 'Inline Variable'
    end, { desc = '[R]efactor [I]nline Variable' })

    vim.keymap.set('n', '<leader>rb', function()
      require('refactoring').refactor 'Extract Block'
    end, { desc = '[R]efactor Extract [B]lock' })

    vim.keymap.set('n', '<leader>rbf', function()
      require('refactoring').refactor 'Extract Block To File'
    end, { desc = '[R]efactor Extract [B]lock to [F]ile' })
  end,
}
```

**Add to**: `init.lua` - Add `require 'plugins.refactoring'` to lazy.setup
**Priority**: HIGH - Essential for large codebases
**Effort**: 20 minutes

---

### 8. Enhanced Git Workflow
**Issue**: Limited git integration beyond gitsigns and fugitive

**Implementation**: Create `lua/plugins/git-enhanced.lua`
```lua
return {
  {
    -- Better diff viewing and merge conflict resolution
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff View' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it File [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it Project [H]istory' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = '[G]it Diff [C]lose' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = 'diff2_horizontal' },
        merge_tool = { layout = 'diff3_horizontal' },
      },
    },
  },
  {
    -- Magit-like git interface
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = '[G]it Neo[g]it' },
      { '<leader>gC', '<cmd>Neogit commit<cr>', desc = '[G]it [C]ommit' },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.git-enhanced'` to lazy.setup
**Priority**: HIGH - Better for reviewing changes and resolving conflicts
**Effort**: 20 minutes

---

### 9. Debugging for TypeScript and Go
**Issue**: DAP only configured for Python

**Implementation**: Create `lua/plugins/dap-multi.lua`
```lua
return {
  {
    -- TypeScript/JavaScript debugging
    'mxsdev/nvim-dap-vscode-js',
    dependencies = {
      'mfussenegger/nvim-dap',
      {
        'microsoft/vscode-js-debug',
        build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
      },
    },
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      local dap = require 'dap'
      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome',
            url = 'http://localhost:4200', -- Angular default port
            webRoot = '${workspaceFolder}',
          },
        }
      end
    end,
  },
  {
    -- Go debugging
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'go',
    config = function()
      require('dap-go').setup {
        dap_configurations = {
          {
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        delve = {
          path = 'dlv',
          initialize_timeout_sec = 20,
          port = '${port}',
          args = {},
        },
      }
    end,
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.dap-multi'` to lazy.setup
**Note**: May conflict with existing go.nvim dap config, test carefully
**Priority**: HIGH
**Effort**: 30 minutes

---

### 10. Testing Support for TypeScript and Go
**Issue**: Neotest only has Python adapter

**Implementation**: Create `lua/plugins/testing.lua`
```lua
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    -- Test adapters
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-go',
  },
  keys = {
    { '<leader>tn', '<cmd>lua require("neotest").run.run()<cr>', desc = '[T]est [N]earest' },
    { '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', desc = '[T]est [F]ile' },
    { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', desc = '[T]est [S]ummary' },
    { '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', desc = '[T]est [O]utput' },
    { '<leader>tO', '<cmd>lua require("neotest").output_panel.toggle()<cr>', desc = '[T]est [O]utput Panel' },
    { '<leader>td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>', desc = '[T]est [D]ebug' },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
        },
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
        },
      },
      quickfix = {
        enabled = true,
        open = false,
      },
    }
  end,
}
```

**Replace**: Move neotest config from `python.lua` to this new file
**Add to**: `init.lua` - Add `require 'plugins.testing'` to lazy.setup
**Priority**: HIGH
**Effort**: 25 minutes

---

## 🟡 Medium Priority (This Month)

### 11. Enhanced Text Objects
**Issue**: No treesitter text objects for smart selections
**Benefit**: Select function (`vaf`), parameter (`vip`), class (`vac`)

**Implementation**: Update `lua/plugins/treesitter.lua`
```lua
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Add this
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    -- ... existing config ...

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
}
```

**Priority**: MEDIUM - Very useful for code manipulation
**Effort**: 15 minutes

---

### 12. Better Terminal Integration
**Issue**: Basic terminal support, no advanced features

**Implementation**: Create `lua/plugins/terminal.lua`
```lua
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal', mode = { 'n', 't' } },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal [F]loat' },
    { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]erminal [H]orizontal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = '[T]erminal [V]ertical' },
  },
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved',
      winblend = 0,
    },
  },
}
```

**Note**: Will replace/enhance existing terminal keymaps in keymaps.lua
**Add to**: `init.lua` - Add `require 'plugins.terminal'` to lazy.setup
**Priority**: MEDIUM
**Effort**: 20 minutes

---

### 13. Project-Wide Search & Replace
**Issue**: No visual search/replace interface

**Implementation**: Create `lua/plugins/search.lua`
```lua
return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>sr',
      function()
        require('spectre').open()
      end,
      desc = '[S]earch and [R]eplace',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sp',
      function()
        require('spectre').open_file_search()
      end,
      desc = '[S]earch in current file',
    },
  },
  opts = {
    open_cmd = 'vnew',
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.search'` to lazy.setup
**Priority**: MEDIUM - Very useful for large refactorings
**Effort**: 15 minutes

---

### 14. Enhanced Notifications
**Issue**: Using basic vim.notify

**Implementation**: Update `lua/plugins/misc.lua`
```lua
{
  'rcarriga/nvim-notify',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'Dismiss all Notifications',
    },
  },
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  config = function(_, opts)
    require('notify').setup(opts)
    vim.notify = require 'notify'
  end,
},
```

**Priority**: MEDIUM - Better UX
**Effort**: 10 minutes

---

### 15. Better TypeScript Performance
**Issue**: Using basic ts_ls

**Implementation**: Create `lua/plugins/typescript.lua`
```lua
return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      -- Disable formatting (prettier handles this)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
    },
  },
}
```

**Note**: If using this, remove `ts_ls` from lsp.lua servers table
**Add to**: `init.lua` - Add `require 'plugins.typescript'` to lazy.setup
**Priority**: MEDIUM - Performance boost for TS development
**Effort**: 20 minutes

---

### 16. Visual Scrollbar
**Issue**: No overview of file structure

**Implementation**: Update `lua/plugins/misc.lua`
```lua
{
  'petertriho/nvim-scrollbar',
  event = 'BufReadPost',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'kevinhwang91/nvim-hlslens', -- Search result indicators
  },
  opts = {
    handle = {
      color = '#44475a', -- Catppuccin surface1
    },
    marks = {
      Search = { color = '#f9e2af' }, -- Catppuccin yellow
      Error = { color = '#f38ba8' }, -- Catppuccin red
      Warn = { color = '#fab387' }, -- Catppuccin peach
      Info = { color = '#89dceb' }, -- Catppuccin sky
      Hint = { color = '#94e2d5' }, -- Catppuccin teal
      Misc = { color = '#cba6f7' }, -- Catppuccin mauve
      GitAdd = { color = '#a6e3a1' }, -- Catppuccin green
      GitChange = { color = '#f9e2af' }, -- Catppuccin yellow
      GitDelete = { color = '#f38ba8' }, -- Catppuccin red
    },
  },
  config = function(_, opts)
    require('scrollbar').setup(opts)
    require('scrollbar.handlers.gitsigns').setup()
    require('scrollbar.handlers.search').setup()
  end,
},
```

**Priority**: MEDIUM
**Effort**: 15 minutes

---

## 🟢 Nice to Have (Lower Priority)

### 17. REST API Testing
**Issue**: No way to test APIs from Neovim

**Implementation**: Create `lua/plugins/rest.lua`
```lua
return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>rr', '<Plug>RestNvim', desc = '[R]un [R]EST request' },
    { '<leader>rp', '<Plug>RestNvimPreview', desc = '[R]EST [P]review' },
    { '<leader>rl', '<Plug>RestNvimLast', desc = '[R]EST run [L]ast' },
  },
  opts = {
    result_split_horizontal = false,
    result_split_in_place = false,
    skip_ssl_verification = false,
    encode_url = true,
    highlight = {
      enabled = true,
      timeout = 150,
    },
    result = {
      show_url = true,
      show_http_info = true,
      show_headers = true,
      formatters = {
        json = 'jq',
        html = function(body)
          return vim.fn.system({ 'tidy', '-i', '-q', '-' }, body)
        end,
      },
    },
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.rest'` to lazy.setup
**Priority**: LOW - Useful for API development
**Effort**: 15 minutes

---

### 18. Database UI
**Issue**: SQL LSP configured but no query execution

**Implementation**: Create `lua/plugins/database.lua`
```lua
return {
  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection' },
    keys = {
      { '<leader>db', '<cmd>DBUIToggle<cr>', desc = '[D]ata[b]ase UI' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = 'right'
      vim.g.db_ui_winwidth = 40
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    ft = { 'sql', 'mysql', 'plsql' },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
        end,
      })
    end,
  },
}
```

**Add to**: `init.lua` - Add `require 'plugins.database'` to lazy.setup
**Priority**: LOW
**Effort**: 20 minutes

---

### 19. Note Taking
**Issue**: No documentation system

**Implementation**: Create `lua/plugins/notes.lua`
```lua
-- Option 1: If you use Obsidian
return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/notes',
      },
    },
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}

-- Option 2: Built-in note system
-- return {
--   'nvim-neorg/neorg',
--   build = ':Neorg sync-parsers',
--   dependencies = { 'nvim-lua/plenary.nvim' },
--   config = function()
--     require('neorg').setup {
--       load = {
--         ['core.defaults'] = {},
--         ['core.concealer'] = {},
--         ['core.dirman'] = {
--           config = {
--             workspaces = {
--               notes = '~/notes',
--             },
--           },
--         },
--       },
--     }
--   end,
-- }
```

**Choose one**: Obsidian.nvim or Neorg based on your preference
**Add to**: `init.lua` - Add `require 'plugins.notes'` to lazy.setup
**Priority**: LOW
**Effort**: 20 minutes

---

### 20. Smooth Scrolling
**Issue**: No visual scroll feedback

**Implementation**: Update `lua/plugins/misc.lua`
```lua
{
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  opts = {
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    easing_function = 'quadratic',
    pre_hook = nil,
    post_hook = nil,
    performance_mode = false,
  },
},
```

**Priority**: LOW - Visual enhancement
**Effort**: 5 minutes

---

## ⚡ Performance Optimizations

### 21. LSP Diagnostic Performance
**Issue**: No debounce for LSP diagnostic updates
**File**: `lua/core/snippets.lua` (or create new performance.lua)

**Fix**: Add after diagnostic config:
```lua
-- Optimize diagnostic updates
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    prefix = '●',
  },
  severity_sort = true,
})
```

**Priority**: MEDIUM - Reduces CPU usage
**Effort**: 5 minutes

---

### 22. Treesitter Optimization
**Issue**: Loading many parsers that might not be needed
**File**: `lua/plugins/treesitter.lua`

**Fix**: Review and potentially set `auto_install = false`, explicitly list only needed parsers:
```lua
ensure_installed = {
  'typescript',
  'tsx',
  'javascript',
  'python',
  'go',
  'lua',
  'html',
  'css',
  'json',
  'yaml',
  'markdown',
  'bash',
  -- Add only what you actually use
},
auto_install = false, -- Prevent automatic installation
```

**Priority**: MEDIUM - Faster startup
**Effort**: 10 minutes

---

### 23. Large File Handling
**Issue**: No special handling for large files
**File**: `lua/core/options.lua`

**Fix**: Add autocmd:
```lua
-- Disable heavy features for large files
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > 1024000 then -- 1MB
      vim.b.large_file = true
      vim.cmd 'syntax off'
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      -- Disable LSP
      vim.schedule(function()
        vim.cmd 'LspStop'
      end)
    end
  end,
})
```

**Priority**: MEDIUM - Prevents freezing on large files
**Effort**: 10 minutes

---

## 📝 Language-Specific Enhancements

### 24. TypeScript Inlay Hints
**Issue**: Basic ts_ls setup lacks optimization
**File**: `lua/plugins/lsp.lua`

**Fix**: Update ts_ls configuration:
```lua
ts_ls = {
  init_options = {
    preferences = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Disable formatting (prettier handles this)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
},
```

**Priority**: MEDIUM
**Effort**: 5 minutes

---

### 25. Go DAP Configuration
**Issue**: go.nvim has `dap_debug = true` but no actual DAP config
**File**: `lua/plugins/go.lua`

**Fix**: Configure delve properly or use nvim-dap-go (see #9)
**Priority**: HIGH if you debug Go code
**Effort**: Covered in #9

---

### 26. Python Virtual Environment Auto-Select
**Issue**: venv-selector requires manual selection
**File**: `lua/plugins/python.lua`

**Enhancement**: Already has auto_refresh, consider auto-selection:
```lua
-- Add to venv-selector config:
fd_binary_name = 'fd',
auto_refresh = true,
search_venv_managers = true,
search_workspace = true,
```

**Priority**: LOW - Minor convenience
**Effort**: 5 minutes

---

### 27. Markdown LSP
**Issue**: No LSP for markdown files
**File**: `lua/plugins/lsp.lua`

**Fix**: Add to servers table:
```lua
marksman = {},
```

**Priority**: MEDIUM if you write docs
**Effort**: 1 minute

---

### 28. Docker LSP
**Issue**: No LSP for Dockerfiles
**File**: `lua/plugins/lsp.lua`

**Fix**: Add to servers table:
```lua
dockerls = {},
docker_compose_language_service = {},
```

**Priority**: MEDIUM if you use Docker
**Effort**: 2 minutes

---

## 🔧 File-Specific Issues

### 29. Neotree Plugin File Unused
**Issue**: `lua/plugins/neotree.lua` exists but not loaded (commented in init.lua line 18)
**File**: `lua/plugins/neotree.lua`

**Fix**: Either:
- Delete the file if using oil exclusively
- Or document why it's kept (backup option)

**Priority**: LOW - Cleanup
**Effort**: 1 minute

---

### 30. Comment Plugin Multiple Bindings
**Issue**: Three keybinds for same action (C-/, C-_, C-c)
**File**: `lua/plugins/comment.lua`

**Fix**: Keep only C-/ (most common), remove others:
```lua
toggler = {
  line = '<C-/>',
},
opleader = {
  line = '<C-/>',
},
```

**Priority**: LOW - Cleanup
**Effort**: 2 minutes

---

### 31. Which-Key Namespace Collision
**Issue**: Using '<leader>t' for both Terminal and Toggle operations
**Files**: Multiple

**Fix**: Split namespaces:
- `<leader>t` → Terminal operations
- `<leader>u` → Toggle operations (UI)
- Update which-key groups accordingly

**Priority**: MEDIUM - Better organization
**Effort**: 10 minutes

---

## ✅ Implementation Checklist

### Phase 1: Immediate Fixes (30 minutes total)
- [ ] Fix lualine theme mismatch
- [ ] Remove duplicate options from keymaps.lua
- [ ] Add `K` keymap for hover docs
- [ ] Add schemastore for JSON/YAML
- [ ] Fix scrolloff conflict

### Phase 2: Essential Plugins (2-3 hours total)
- [ ] Add session management (persistence.nvim)
- [ ] Add refactoring plugin
- [ ] Add git enhancements (diffview, neogit)
- [ ] Configure DAP for TypeScript and Go
- [ ] Add testing support for all languages

### Phase 3: Quality of Life (2-3 hours total)
- [ ] Add treesitter text objects
- [ ] Add toggleterm
- [ ] Add nvim-spectre (search/replace)
- [ ] Add nvim-notify
- [ ] Add scrollbar
- [ ] Consider typescript-tools.nvim

### Phase 4: Nice to Have (1-2 hours total)
- [ ] Add REST client (optional)
- [ ] Add database UI (optional)
- [ ] Add note-taking (optional)
- [ ] Add smooth scrolling (optional)

### Phase 5: Performance & Cleanup (1 hour total)
- [ ] Optimize LSP diagnostics
- [ ] Review treesitter parsers
- [ ] Add large file handling
- [ ] Clean up unused files
- [ ] Fix namespace collisions
- [ ] Add performance profiling

---

## 📊 Priority Matrix

| Priority | Count | Total Effort | Impact |
|----------|-------|--------------|--------|
| HIGH | 10 items | ~3-4 hours | Critical functionality |
| MEDIUM | 11 items | ~3-4 hours | Quality of life |
| LOW | 10 items | ~2-3 hours | Nice to have |

**Total Estimated Effort**: 8-11 hours for complete implementation

---

## 🎯 Recommended Implementation Order

1. **Week 1**: Phase 1 (Immediate Fixes) + Start Phase 2
2. **Week 2**: Complete Phase 2 (Essential Plugins)
3. **Week 3**: Phase 3 (Quality of Life)
4. **Week 4**: Phase 4 & 5 (Nice to Have + Cleanup)

---

## 📚 Additional Resources

- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) - Curated list of plugins
- [Neovim Craft](https://neovimcraft.com/) - Plugin discovery
- [LazyVim](https://www.lazyvim.org/) - Reference configuration for ideas
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Minimal starting point

---

## 💡 Notes

- All file paths are relative to `/Users/ionut-traistaru/.dotfiles/nvim/.config/nvim/`
- Remember to run `:Lazy sync` after adding new plugins
- Test each change incrementally before moving to the next
- Keep backups before major changes (git branch recommended)
- Check `:checkhealth` after major plugin additions

---

**Generated by**: Claude Code
**Date**: 2025-10-30
**Configuration Version**: Current as of analysis date
