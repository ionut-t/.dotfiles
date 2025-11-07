return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Always-on performance features
    bigfile = { enabled = true }, -- Disable heavy features for large files
    quickfile = { enabled = true }, -- Speed up file loading

    -- Git integration
    git = {
      enabled = true,
      -- Git blame in floating window
      -- Git browse commits, diff view
    },

    -- Scratch buffers for quick notes
    scratch = {
      enabled = true,
      -- File type options for syntax highlighting
      ft = function()
        if vim.bo.buftype == '' and vim.bo.filetype == '' then
          return 'markdown'
        end
        return vim.bo.filetype
      end,
      -- Auto-create scratch dir
      autowrite = true,
      filekey = {
        cwd = true,
        branch = true,
        count = true,
      },
      -- Default to floating window
      win = { style = 'scratch' },
      win_by_ft = {
        lua = { keys = { ['source'] = '<leader>x' } },
      },
    },

    -- Dim inactive code sections
    dim = {
      enabled = true,
      -- Scope detection
      scope = {
        min_size = 5,
        max_size = 100,
        siblings = true,
      },
    },

    -- Zen mode for distraction-free writing
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_indentscope = false,
        diagnostics = false,
        inlay_hints = false,
      },
      zoom = {
        width = 120,
        height = 0.9,
      },
      show = {
        statusline = false,
        tabline = false,
      },
    },

    -- Improved statuscolumn
    statuscolumn = {
      enabled = false, -- Disable if you're happy with default
      left = { 'mark', 'sign' },
      right = { 'fold', 'git' },
      folds = {
        open = true,
        git_hl = true,
      },
      git = {
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
    },

    -- Notification system (optional - you have noice)
    notifier = {
      enabled = false, -- Set to true if you want to replace noice
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { 'level', 'added' },
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
    },

    -- Dashboard (optional - you have alpha)
    dashboard = {
      enabled = false, -- Set to true if you want to replace alpha
    },

    -- Terminal (optional - you have toggleterm)
    terminal = {
      enabled = false, -- Set to true if you want to replace toggleterm
    },

    -- Indent guides (optional - you have indent-blankline)
    indent = {
      enabled = false, -- Set to true if you want to replace indent-blankline
    },

    -- Scroll animation
    scroll = {
      enabled = false, -- Can enable if you want smooth scrolling
    },

    -- Words highlighting under cursor
    words = {
      enabled = true,
      debounce = 200,
    },

    -- Styles for floating windows
    styles = {
      notification = {
        wo = { wrap = true },
        border = 'rounded',
      },
      scratch = {
        border = 'rounded',
        width = 100,
        height = 30,
        backdrop = 60,
        keys = {
          ['gf'] = false, -- disable gf in scratch
        },
      },
      zen = {
        backdrop = {
          transparent = false,
          blend = 60,
        },
        width = 120,
        wo = {
          winhighlight = 'NormalFloat:Normal',
        },
      },
    },
  },

  keys = {
    -- Git commands
    {
      '<leader>gb',
      function()
        require('snacks').git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gB',
      function()
        require('snacks').gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gf',
      function()
        require('snacks').lazygit.log_file()
      end,
      desc = 'Git File History',
    },
    {
      '<leader>gl',
      function()
        require('snacks').lazygit.log()
      end,
      desc = 'Git Log',
    },

    -- Scratch buffer
    {
      '<leader>.',
      function()
        require('snacks').scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        require('snacks').scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },

    -- Zen mode
    {
      '<leader>z',
      function()
        require('snacks').zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        require('snacks').zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },

    -- Dim toggle
    {
      '<leader>ud',
      function()
        require('snacks').dim()
      end,
      desc = 'Toggle Dim',
    },

    -- Notification history (if enabled)
    {
      '<leader>nh',
      function()
        require('snacks').notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>nd',
      function()
        require('snacks').notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        local snacks = require 'snacks'

        -- Setup some globals for easier access
        _G.dd = function(...)
          snacks.debug.inspect(...)
        end
        _G.bt = function()
          snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks.debug

        -- Create some toggle commands with state display
        snacks.toggle
          .option('spell', {
            name = 'Spelling',
            get = function()
              return vim.wo.spell
            end,
            set = function(state)
              vim.wo.spell = state
            end,
          })
          :map '<leader>us'

        snacks.toggle
          .option('wrap', {
            name = 'Wrap',
            get = function()
              return vim.wo.wrap
            end,
            set = function(state)
              vim.wo.wrap = state
            end,
          })
          :map '<leader>uw'

        snacks.toggle
          .option('relativenumber', {
            name = 'Relative Number',
            get = function()
              return vim.wo.relativenumber
            end,
            set = function(state)
              vim.wo.relativenumber = state
            end,
          })
          :map '<leader>uL'

        snacks.toggle.diagnostics():map '<leader>ud'
        snacks.toggle.line_number():map '<leader>ul'

        -- Note: Conceal toggle removed - hides/shows concealed text (e.g., markdown links)
        -- Note: Background toggle removed - not needed

        snacks.toggle.treesitter():map '<leader>uT'

        snacks.toggle.inlay_hints():map '<leader>uh'
        snacks.toggle.indent():map '<leader>ug'
        snacks.toggle.dim():map '<leader>uD'

        -- Toggle auto-format on save
        snacks.toggle
          .new({
            name = 'Auto Format',
            get = function()
              return vim.g.format_on_save_enabled == true
            end,
            set = function(state)
              vim.g.format_on_save_enabled = state
            end,
          })
          :map '<leader>uf'
      end,
    })
  end,
}
