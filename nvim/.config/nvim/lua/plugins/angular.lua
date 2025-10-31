return {
  -- Angular language support is handled via angularls in the main lsp.lua
  -- This file can contain Angular-specific utilities or remain minimal

  -- Angular template syntax support
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "typescript", "html", "css" })
      end
    end,
  },
}
