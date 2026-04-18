-- Detect Angular component templates
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.html' },
  callback = function()
    vim.bo.filetype = 'htmlangular'
  end,
})
