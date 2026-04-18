-- Inline git blame annotations
return {
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = true,
    message_template = ' <author> • <date> • <summary>',
    date_format = '%d/%m/%Y',
    virtual_text_column = 1,
    delay = 500,
  },
  config = function(_, opts)
    require('gitblame').setup(opts)

    local wk = require 'which-key'
    wk.add {
      {
        '<leader>ub',
        '<cmd>GitBlameToggle<cr>',
        desc = function()
          if vim.g.gitblame_enabled then
            return 'Disable git blame'
          else
            return 'Enable git blame'
          end
        end,
      },
    }
  end,
}
