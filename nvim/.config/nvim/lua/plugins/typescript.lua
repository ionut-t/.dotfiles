return {
  'pmizio/typescript-tools.nvim',
  enabled = true,
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    settings = {
      -- Spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = 'insert_leave',
      -- Array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
      -- "remove_unused_imports"|"organize_imports") -- or string "all"
      -- to include all supported code actions
      expose_as_code_action = 'all',
      -- String|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- Specify max file size for typescript server to load, measured in KB
      tsserver_max_memory = 'auto',
      -- Locale of all tsserver messages, supported locales you can find here:
      -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
      tsserver_locale = 'en',
      -- Mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = true,
      include_completions_with_insert_text = true,
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      code_lens = 'off',
      -- By default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
      -- JSXCloseTag
      -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
      -- that maybe have a conflict if enable this feature. )
      jsx_close_tag = {
        enable = false,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
    },
  },
  config = function(_, opts)
    require('typescript-tools').setup(opts)

    -- Keymaps
    vim.keymap.set('n', '<leader>co', '<cmd>TSToolsOrganizeImports<cr>', { desc = 'Code organize imports' })
    vim.keymap.set('n', '<leader>cO', '<cmd>TSToolsSortImports<cr>', { desc = 'Code sort imports' })
    vim.keymap.set('n', '<leader>cu', '<cmd>TSToolsRemoveUnused<cr>', { desc = 'Code remove unused' })
    vim.keymap.set('n', '<leader>cz', '<cmd>TSToolsGoToSourceDefinition<cr>', { desc = 'Code go to source definition' })
    vim.keymap.set('n', '<leader>cR', '<cmd>TSToolsRenameFile<cr>', { desc = 'Code rename file' })
    vim.keymap.set('n', '<leader>cI', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'Code add missing imports' })
    vim.keymap.set('n', '<leader>cF', '<cmd>TSToolsFixAll<cr>', { desc = 'Code fix all' })
  end,
}
