return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- You can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- true to Use a classic bottom cmdline for search
      command_palette = true, -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = false, -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- Add a border to hover docs and signature help
    },
    cmdline = {
      enabled = true, -- Enable the Noice cmdline UI
      view = 'cmdline_popup', -- View for rendering the cmdline (cmdline_popup for floating)
      opts = {}, -- Global options for the cmdline
      format = {
        -- Customize cmdline icons
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
        lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
        input = {}, -- Used by input()
      },
    },
    messages = {
      enabled = true, -- Enables the Noice messages UI
      view = 'notify', -- Default view for messages
      view_error = 'notify', -- View for errors
      view_warn = 'notify', -- View for warnings
      view_history = 'messages', -- View for :messages
      view_search = 'virtualtext', -- View for search count messages
    },
    popupmenu = {
      enabled = true, -- Enables the Noice popupmenu UI
      backend = 'nui', -- Backend to use to show regular cmdline completions
      kind_icons = {}, -- Icons for completion item kinds
    },
    notify = {
      enabled = true,
      view = 'notify',
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
  },
  keys = {
    {
      '<leader>snh',
      function()
        require('noice').cmd 'history'
      end,
      desc = 'Search noice history',
    },
    {
      '<leader>snl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Search noice last message',
    },
    {
      '<leader>snd',
      function()
        require('noice').cmd 'dismiss'
      end,
      desc = 'Search noice dismiss all',
    },
  },
}
