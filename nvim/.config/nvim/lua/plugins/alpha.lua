return {
  'goolord/alpha-nvim',
  lazy = false,
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
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
