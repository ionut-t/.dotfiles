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
