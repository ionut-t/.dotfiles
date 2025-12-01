return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    vim.opt.foldcolumn = '1'
    vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    -- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

    -- NOTE: Folding capabilities are now added in lsp.lua
    -- This prevents overwriting code action and other LSP capabilities
    require('ufo').setup()
  end,
}
