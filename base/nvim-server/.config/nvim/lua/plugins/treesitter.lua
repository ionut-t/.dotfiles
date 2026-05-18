return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    local langs = {
      'lua',
      'python',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'regex',
      'sql',
      'toml',
      'json',
      'go',
      'gomod',
      'gowork',
      'gosum',
      'gitignore',
      'yaml',
      'make',
      'markdown',
      'markdown_inline',
      'bash',
      'tsx',
      'rust',
    }

    require('nvim-treesitter.install').install(langs)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldenable = false
      end,
    })

    local move = require('nvim-treesitter-textobjects.move')

    local function map(lhs, fn, desc)
      vim.keymap.set('n', lhs, fn, { silent = true, desc = desc })
    end

    map(']f', function() move.goto_next_start('@function.outer') end, 'Next function start')
    map(']c', function() move.goto_next_start('@class.outer') end, 'Next class start')
    map(']a', function() move.goto_next_start('@parameter.inner') end, 'Next parameter start')
    map(']F', function() move.goto_next_end('@function.outer') end, 'Next function end')
    map(']C', function() move.goto_next_end('@class.outer') end, 'Next class end')
    map(']A', function() move.goto_next_end('@parameter.inner') end, 'Next parameter end')
    map('[f', function() move.goto_previous_start('@function.outer') end, 'Previous function start')
    map('[c', function() move.goto_previous_start('@class.outer') end, 'Previous class start')
    map('[a', function() move.goto_previous_start('@parameter.inner') end, 'Previous parameter start')
    map('[F', function() move.goto_previous_end('@function.outer') end, 'Previous function end')
    map('[C', function() move.goto_previous_end('@class.outer') end, 'Previous class end')
    map('[A', function() move.goto_previous_end('@parameter.inner') end, 'Previous parameter end')

    local swap = require('nvim-treesitter-textobjects.swap')
    map('<leader>a', function() swap.swap_next('@parameter.inner') end, 'Swap next parameter')
    map('<leader>A', function() swap.swap_previous('@parameter.inner') end, 'Swap previous parameter')
  end,
}
