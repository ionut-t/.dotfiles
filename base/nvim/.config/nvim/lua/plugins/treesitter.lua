return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    local langs = {
      'lua',
      'python',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'regex',
      'terraform',
      'sql',
      'dockerfile',
      'toml',
      'json',
      'go',
      'gomod',
      'gowork',
      'gosum',
      'gitignore',
      'yaml',
      'make',
      'cmake',
      'markdown',
      'markdown_inline',
      'bash',
      'tsx',
      'css',
      'html',
      'angular',
      'rust',
      'zig',
    }

    -- Register Angular for htmlangular filetype
    vim.treesitter.language.register('angular', 'htmlangular')

    -- Install missing parsers
    require('nvim-treesitter.install').install(langs)

    -- Enable treesitter highlighting and indentation for all buffers.
    -- In nvim-treesitter v1.x, highlight.enable is gone — we use an autocmd.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        -- Enable treesitter-based folding
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldenable = false
      end,
    })

    -- nvim-treesitter-textobjects v2 API: keymaps are set explicitly
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

    -- Swap textobjects
    local swap = require('nvim-treesitter-textobjects.swap')
    map('<leader>a', function() swap.swap_next('@parameter.inner') end, 'Swap next parameter')
    map('<leader>A', function() swap.swap_previous('@parameter.inner') end, 'Swap previous parameter')
  end,
}
