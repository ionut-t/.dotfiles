return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>Sr',
      function()
        require('spectre').open()
      end,
      desc = 'Search replace',
    },
    {
      '<leader>Sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = 'Search and replace current word',
    },
    {
      '<leader>S',
      function()
        require('spectre').open_visual()
      end,
      mode = 'v',
      desc = 'Search and replace selection',
    },
    {
      '<leader>Sf',
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'Search and replace in file',
    },
  },
  opts = {
    open_cmd = 'vnew',
    is_insert_mode = true, -- Start in insert mode
    replace_engine = {
      ['sed'] = {
        cmd = 'sed',
        args = { '-i', '', '-E' },
      },
    },
    default = {
      find = {
        cmd = 'rg',
        options = { 'hidden', 'ignore-case', 'smart-case' },
      },
      replace = {
        cmd = 'sd',
      },
    },
    find_engine = {
      ['rg'] = {
        cmd = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--glob=!.git/',
          '--glob=!node_modules/',
        },
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('spectre').setup(opts)

    -- Show help on open
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'spectre_panel',
      callback = function()
        vim.notify(
          'Spectre Commands:\n'
            .. '• Press ? for help\n'
            .. '• <leader>R to replace all\n'
            .. '• <leader>rc to replace current\n'
            .. '• dd to toggle line',
          vim.log.levels.INFO
        )
      end,
    })
  end,
}
