return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require 'lualine_require'
    lualine_require.require = require

    local icons = {
      diagnostics = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' },
      git = { added = ' ', modified = ' ', removed = ' ' },
    }

    local function fg(name)
      return function()
        local hl = vim.api.nvim_get_hl(0, { name = name })
        return hl and hl.fg and { fg = string.format('#%06x', hl.fg) } or nil
      end
    end

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },

        lualine_c = {
          -- 1. File Type Icon
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },

          -- 2. PRETTY PATH: Parent Directory Only (Dimmed)
          {
            function()
              -- Gets the immediate parent directory name
              local dir = vim.fn.expand '%:p:h:t'
              -- Check if we are at the root (dir is same as cwd name) or no parent
              if dir == vim.fn.expand '%:p:h:h:t' or dir == '' then
                return ''
              end
              return dir .. '/'
            end,
            color = fg 'Comment',
            separator = '',
            padding = { left = 0, right = 0 },
          },

          -- 3. PRETTY PATH: Filename (Bold + Modified Status)
          {
            function()
              local file = vim.fn.expand '%:t'
              if file == '' then
                return '[No Name]'
              end
              return file .. (vim.bo.modified and ' ●' or '')
            end,
            color = function()
              if vim.bo.modified then
                return { fg = '#89dceb', gui = 'bold' }
              else
                return { gui = 'bold' }
              end
            end,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              return require('snacks').profiler.status()
            end,
            cond = function()
              return package.loaded['snacks']
            end,
          },
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
            color = fg 'Statement',
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = fg 'Constant',
          },
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            color = fg 'Debug',
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = fg 'Special',
          },
          {
            'diff',
            symbols = icons.git,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { 'location', separator = '|' },
          { 'progress' },
        },
        lualine_z = {
          -- Root Directory
          {
            function()
              return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            end,
          },
        },
      },
      extensions = { 'neo-tree', 'lazy', 'fzf' },
    }

    if vim.g.trouble_lualine and package.loaded['trouble'] then
      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
