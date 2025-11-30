return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        {
          section = 'terminal',
          cmd = 'chafa ~/.dotfiles/nvim/.config/nvim/nvim_dashboard.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1',
          height = 17,
          padding = 1,
        },
        {
          pane = 2,
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 3, padding = 2 },
          { section = 'startup' },
        },
      },
    },
    picker = {
      formatters = {
        file = {
          filename_first = true,
        },
      },
      actions = {
        -- Custom action to switch to preview and set up return keybinding
        goto_preview = function(picker)
          if picker.preview and picker.preview.win and picker.preview.win.win then
            local preview_win = picker.preview.win.win
            local list_win = picker.list and picker.list.win and picker.list.win.win

            -- Switch to preview
            vim.api.nvim_set_current_win(preview_win)

            -- Set up Tab keybinding in preview buffer to return to list
            if list_win then
              local preview_buf = vim.api.nvim_win_get_buf(preview_win)
              vim.keymap.set('n', '<Tab>', function()
                if vim.api.nvim_win_is_valid(list_win) then
                  vim.api.nvim_set_current_win(list_win)
                end
              end, { buffer = preview_buf, nowait = true, silent = true })
            end
          end
        end,
      },
      win = {
        input = {
          keys = {
            ['<Tab>'] = { 'goto_preview', mode = { 'n' } },
          },
        },
        list = {
          keys = {
            ['<Tab>'] = { 'goto_preview', mode = { 'n' } },
          },
        },
      },
    },

    -- Always-on performance features
    bigfile = { enabled = true }, -- Disable heavy features for large files
    quickfile = { enabled = true }, -- Speed up file loading

    -- Git integration
    git = {
      enabled = true,
      -- Git blame in floating window
      -- Git browse commits, diff view
    },

    -- Lazygit integration
    lazygit = {
      enabled = true,
      -- Automatically configure lazygit to use the colors of your Neovim theme
      configure = true,
      -- Floating window configuration
      win = {
        style = 'lazygit',
      },
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
        git_signs = true,
        mini_indentscope = false,
        diagnostics = true,
        inlay_hints = true,
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
      enabled = true,
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

    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { 'level', 'added' },
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
    },

    -- Terminal (optional - you have toggleterm)
    terminal = {
      enabled = false, -- Set to true if you want to replace toggleterm
    },

    -- Indent guides (optional - you have indent-blankline)
    indent = {
      enabled = true,
    },

    -- Scroll animation
    scroll = {
      enabled = false,
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
      lazygit = {
        border = 'rounded',
        width = 0.9,
        height = 0.9,
        backdrop = 60,
      },
    },
  },

  keys = {
    -- Git commands
    {
      '<leader>gG',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Blame line',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'File history',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Log',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Branches',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Log line',
    },
    {
      '<leader>gx',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Stash',
    },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'Pull Requests (open)',
    },
    {
      '<leader>gP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'Pull Requests (all)',
    },

    -- Scratch buffer
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Scratch buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select scratch buffer',
    },

    -- Zen mode
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },

    -- Dim toggle
    {
      '<leader>ud',
      function()
        Snacks.dim()
      end,
      desc = 'Toggle Dim',
    },

    -- Notification history (if enabled)
    {
      '<leader>nh',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification history',
    },

    {
      '<leader>nd',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss all notifications',
    },

    -- Snacks Picker
    {
      '<leader>fi',
      function()
        Snacks.picker.files {
          layout = {
            preset = 'ivy',
          },
        }
      end,
      desc = 'Files (ivy)',
    },

    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },

    {
      '<leader>fC',
      function()
        Snacks.picker.files { cwd = '~/.dotfiles/nvim/.config/nvim/lua' }
      end,
      desc = 'Config file',
    },

    {
      '<leader>fs',
      function()
        Snacks.picker.grep {
          layout = {
            preset = 'ivy',
          },
        }
      end,
      desc = 'Grep word',
    },

    {
      '<leader>fw',
      function()
        Snacks.picker.grep_word {
          on_show = function()
            vim.cmd.stopinsert()
          end,
          layout = {
            preset = 'ivy',
          },
        }
      end,
      desc = 'Selected bytes',
      mode = { 'n', 'v' },
    },

    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command history',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo history',
    },

    {
      '<M-l>',
      function()
        Snacks.picker.keymaps { layout = 'ivy' }
      end,
      desc = 'Search keymaps',
    },

    -- Buffers
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          on_show = function()
            vim.cmd.stopinsert()
          end,
          layout = 'ivy',
          hidden = false,
          sort_lastused = true,
          current = true,
          win = {
            input = {
              keys = {
                d = 'bufdelete',
              },
            },
            list = {
              keys = {
                d = 'bufdelete',
              },
            },
          },
        }
      end,
      desc = 'Opened buffers',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete.delete()
      end,
      desc = 'Delete',
    },
    {
      '<leader>bD',
      function()
        Snacks.bufdelete.all()
      end,
      desc = 'Delete all',
    },
    {
      '<leader>bo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete other',
    },

    {
      'folke/snacks.nvim',
      opts = {
        image = {},
      },
    },

    -- Search
    {
      '<leader>mM',
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_file = vim.api.nvim_buf_get_name(current_buf)
        local items = {}

        -- Get buffer-local marks (a-z)
        for _, mark in ipairs(vim.fn.getmarklist(current_buf)) do
          local m = mark.mark:sub(2, 2)
          if m:match '[a-z]' then
            local fname = vim.fn.fnamemodify(current_file, ':t')
            table.insert(items, {
              idx = #items + 1,
              text = string.format('  %s  %s:%d:%d', m, fname, mark.pos[2], mark.pos[3]),
              file = current_file,
              pos = { mark.pos[2], mark.pos[3] - 1 },
            })
          end
        end

        -- Get global marks (A-Z)
        for _, mark in ipairs(vim.fn.getmarklist()) do
          local m = mark.mark:sub(2, 2)
          if m:match '[A-Z]' and mark.file and mark.file ~= '' then
            local fname = vim.fn.fnamemodify(mark.file, ':t')
            table.insert(items, {
              idx = #items + 1,
              text = string.format('  %s  %s:%d:%d', m, fname, mark.pos[2], mark.pos[3]),
              file = mark.file,
              pos = { mark.pos[2], mark.pos[3] - 1 },
            })
          end
        end

        Snacks.picker.pick {
          title = 'All marks',
          items = items,
          on_show = function()
            vim.cmd.stopinsert()
          end,
          layout = {
            preset = 'ivy',
          },
        }
      end,
      desc = 'All marks',
    },
    {
      '<leader>mm',
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_file = vim.api.nvim_buf_get_name(current_buf)
        local cwd = vim.fn.getcwd()
        local items = {}

        -- Get buffer-local marks (a-z) only if current file is in project
        if current_file:match('^' .. vim.pesc(cwd)) then
          for _, mark in ipairs(vim.fn.getmarklist(current_buf)) do
            local m = mark.mark:sub(2, 2)
            if m:match '[a-z]' then
              local fname = vim.fn.fnamemodify(current_file, ':t')
              table.insert(items, {
                idx = #items + 1,
                text = string.format('  %s  %s:%d:%d', m, fname, mark.pos[2], mark.pos[3]),
                file = current_file,
                pos = { mark.pos[2], mark.pos[3] - 1 },
              })
            end
          end
        end

        -- Get global marks (A-Z) only if within project
        for _, mark in ipairs(vim.fn.getmarklist()) do
          local m = mark.mark:sub(2, 2)
          if m:match '[A-Z]' and mark.file and mark.file ~= '' then
            -- Check if mark's file is within current project
            if mark.file:match('^' .. vim.pesc(cwd)) then
              local fname = vim.fn.fnamemodify(mark.file, ':t')
              table.insert(items, {
                idx = #items + 1,
                text = string.format('  %s  %s:%d:%d', m, fname, mark.pos[2], mark.pos[3]),
                file = mark.file,
                pos = { mark.pos[2], mark.pos[3] - 1 },
              })
            end
          end
        end

        Snacks.picker.pick {
          title = 'Marks',
          items = items,
          on_show = function()
            vim.cmd.stopinsert()
          end,
          layout = {
            preset = 'ivy',
          },
        }
      end,
      desc = 'Marks',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols {
          layout = {
            preset = 'ivy',
          },
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man pages',
    },

    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix list',
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

        -- Toggle treesitter context
        snacks.toggle
          .new({
            name = 'Treesitter Context',
            get = function()
              return require('treesitter-context').enabled()
            end,
            set = function(state)
              local tsc = require 'treesitter-context'
              if state then
                tsc.enable()
              else
                tsc.disable()
              end
            end,
          })
          :map '<leader>uc'

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
