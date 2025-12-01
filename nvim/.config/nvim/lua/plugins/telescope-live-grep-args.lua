return {
  'nvim-telescope/telescope-live-grep-args.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    local telescope = require 'telescope'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- Enable/disable auto-quoting
          -- Display filename first in results
          filename_first = true,
          -- Default arguments passed to ripgrep
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
            '--glob=!node_modules/',
            '--glob=!.next/',
            '--glob=!dist/',
            '--glob=!build/',
            '--glob=!target/', -- Rust build directory
            '--glob=!.venv/', -- Python virtual env
            '--glob=!venv/',
            '--glob=!__pycache__/',
            '--glob=!*.min.js',
            '--glob=!*.min.css',
            '--glob=!package-lock.json',
            '--glob=!yarn.lock',
            '--glob=!pnpm-lock.yaml',
            '--trim',
          },
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              ['<C-t>'] = lga_actions.quote_prompt { postfix = ' --type=' },
            },
          },
        },
      },
    }

    telescope.load_extension 'live_grep_args'
  end,
}
