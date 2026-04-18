-- lua/core/diagnostics.lua

-- Diagnostic configuration
-- See `:help vim.diagnostic.config()`
vim.diagnostic.config({
  -- Show signs in the sign column
  signs = true,

  -- Show virtual text for diagnostics (inline messages)
  virtual_text = {
    prefix = '●', -- Prefix for the diagnostic message
    spacing = 4,   -- Add some space between the code and the message
    source = 'if_many', -- Show source only if there are multiple sources
  },

  -- Underline the code with the diagnostic
  underline = true,

  -- Don't update diagnostics in insert mode
  update_in_insert = false,

  -- Set severity sort order
  severity_sort = true,

  -- Configure floating window
  float = {
    border = 'rounded',
    source = 'if_many',
  },
})
