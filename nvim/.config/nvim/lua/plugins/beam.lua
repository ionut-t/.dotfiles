return {
  'Piotr1215/beam.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim', -- Required by telescope
  },
  config = function()
    require('beam').setup {
      prefix = '\\',
    } -- default prefix ','
  end,
}
