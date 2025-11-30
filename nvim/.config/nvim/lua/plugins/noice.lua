return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },

      hover = {
        enabled = true,
        view = 'hover', -- Use custom hover view with padding
        silent = true,
      },

      signature = {
        enabled = true,
        view = 'hover', -- Use same view for signature help
      },
    },

    views = {
      hover = {
        border = {
          style = 'rounded',
          padding = { 0, 1 }, -- Add horizontal padding (top/bottom, left/right)
        },
        position = { row = 2, col = 2 },
        size = {
          max_width = 80,
          max_height = 30,
        },
      },
    },

    -- You can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- true to Use a classic bottom cmdline for search
      command_palette = true, -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = true, -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- Add a border to hover docs and signature help
    },

    cmdline = {
      enabled = true, -- Enable the Noice cmdline UI
      view = 'cmdline_popup', -- View for rendering the cmdline (cmdline_popup for floating)
      opts = {}, -- Global options for the cmdline
      format = {
        -- Customize cmdline icons with Nerd Fonts
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
        lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
        input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
      },
    },

    popupmenu = {
      enabled = true, -- Enables the Noice popupmenu UI
      backend = 'nui', -- Backend to use to show regular cmdline completions
      -- Optional: Add icons to completion kinds (requires lspkind or similar usually, but valid here)
      kind_icons = {
        Class = ' ',
        Color = ' ',
        Constant = ' ',
        Constructor = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Field = '󰜢 ',
        File = ' ',
        Folder = ' ',
        Function = ' ',
        Interface = 'ﰮ ',
        Keyword = ' ',
        Method = 'ƒ ',
        Module = ' ',
        Property = ' ',
        Snippet = ' ',
        Struct = ' ',
        Text = ' ',
        Unit = ' ',
        Value = ' ',
        Variable = ' ',
      },
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
}
