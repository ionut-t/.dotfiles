return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    -- Skip alpha if we're going to restore a session
    if vim.fn.argc() == 0 then
      local session_file = vim.fn.stdpath 'state' .. '/sessions/' .. vim.fn.getcwd():gsub('/', '%%') .. '.vim'
      if vim.fn.filereadable(session_file) == 1 then
        return -- Don't setup alpha at all
      end
    end

    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.startify'

    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }

    -- Set Catppuccin colors for alpha
    -- Options: String (teal), Function (blue), Type (yellow),
    --          Keyword (mauve/purple), Special (pink), Constant (peach/orange)
    dashboard.section.header.opts.hl = 'Function' -- Change this to your preference

    alpha.setup(dashboard.opts)

    -- Apply Catppuccin highlight groups after setup
    vim.cmd [[
      highlight link AlphaHeader Function
      highlight link AlphaButtons Identifier
      highlight link AlphaShortcut Type
      highlight link AlphaFooter Comment
    ]]
  end,
}
