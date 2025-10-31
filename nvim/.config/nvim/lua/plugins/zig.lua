return {
  'ziglang/zig.vim',
  ft = 'zig',
  config = function()
    -- Zig.vim provides syntax highlighting and basic integration
    -- ZLS (Zig Language Server) should be installed via Mason and configured in lsp.lua
    vim.g.zig_fmt_autosave = 1
  end,
}
