return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup()

    -- NUCLEAR: Override the virtual_text handler completely
    vim.diagnostic.handlers.virtual_text = {
      show = function() end,
      hide = function() end,
    }

    vim.diagnostic.config {
      virtual_text = false,
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'always',
      },
    }
  end,
}
