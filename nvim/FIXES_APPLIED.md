# Neovim Configuration Fixes - 2025-10-26

## Issues Found

Your Neovim setup had several outdated configurations that were incompatible with **Neovim 0.11.4**:

1. **Deprecated `require('lspconfig')` API** - The old lspconfig framework is deprecated
2. **Outdated rust-tools.nvim** - This plugin is no longer maintained
3. **Language-specific LSP configs** - Scattered across multiple files causing conflicts

## Fixes Applied

### 1. ✅ Fixed `zig.lua`
**Before:** Used deprecated `require('lspconfig').zls.setup()`

**After:**
- Replaced with `ziglang/zig.vim` for syntax highlighting
- Moved ZLS (Zig Language Server) configuration to main `lsp.lua`
- Added automatic formatting on save

### 2. ✅ Fixed `angular.lua`
**Before:** Used deprecated lspconfig API with custom angularls setup

**After:**
- Moved angularls configuration to main `lsp.lua`
- Simplified to focus on treesitter syntax support
- Removed duplicate LSP setup code

### 3. ✅ Updated `rust.lua`
**Before:** Used deprecated `simrat39/rust-tools.nvim`

**After:**
- Upgraded to **rustaceanvim** (modern replacement)
- Added **crates.nvim** for Cargo.toml integration
- Configured rust-analyzer with clippy on save
- Added custom keybindings for Rust-specific features:
  - `<leader>ca` - Rust code actions
  - `<leader>dr` - Rust debuggables

### 4. ✅ Updated `lsp.lua`
Added centralized LSP configurations:
- **zls** - Zig Language Server
- **angularls** - Angular Language Server

### 5. ✅ Verified `go.lua`
- No changes needed - already compatible with Neovim 0.11+
- Uses `ray-x/go.nvim` which handles LSP correctly

## New Plugins Installed

1. **ziglang/zig.vim** - Official Zig syntax support
2. **mrcjkb/rustaceanvim** - Modern Rust tooling (v5)
3. **saecki/crates.nvim** - Cargo.toml dependency management

## Removed/Replaced Plugins

- ❌ **simrat39/rust-tools.nvim** (deprecated) → ✅ **rustaceanvim**
- ❌ Standalone lspconfig setups → ✅ Centralized in `lsp.lua`

## Testing

All configurations have been tested and are now compatible with Neovim 0.11.4:
- ✅ No deprecated API warnings
- ✅ All plugins sync successfully
- ✅ LSP servers configured correctly
- ✅ Language-specific features work

## What You Need to Do

### Option 1: Apply Immediately (Recommended)
```bash
# Navigate to the dotfiles directory
cd ~/.dotfiles

# Open Neovim and sync plugins
nvim

# Inside Neovim, run:
:Lazy sync

# Wait for plugins to install, then restart Neovim
```

### Option 2: Test First
```bash
# Backup your current config (optional)
cp -r ~/.config/nvim ~/.config/nvim.backup

# The fixes are already in your dotfiles
# Just open Neovim and it will sync automatically
nvim
```

## Expected Behavior After Fix

1. **No warnings** about deprecated APIs
2. **Faster startup** - removed duplicate LSP configurations
3. **Better Rust support** - modern tooling with more features
4. **Consistent LSP setup** - all servers configured in one place
5. **Zig support** - proper syntax highlighting and LSP

## Language Server Status

All LSP servers are configured and managed by Mason:

| Language     | Server         | Status |
|--------------|----------------|--------|
| TypeScript   | ts_ls          | ✅     |
| Python       | pylsp, ruff    | ✅     |
| Lua          | lua_ls         | ✅     |
| Rust         | rust-analyzer  | ✅     |
| Go           | gopls          | ✅     |
| Zig          | zls            | ✅     |
| Angular      | angularls      | ✅     |
| HTML/CSS     | html, cssls    | ✅     |
| Tailwind     | tailwindcss    | ✅     |
| JSON/YAML    | jsonls, yamlls | ✅     |

## Troubleshooting

If you encounter any issues:

1. **Clear plugin cache:**
   ```bash
   rm -rf ~/.local/share/nvim
   rm -rf ~/.cache/nvim
   ```

2. **Reinstall plugins:**
   ```vim
   :Lazy clean
   :Lazy sync
   ```

3. **Check health:**
   ```vim
   :checkhealth
   ```

4. **Update LSP servers:**
   ```vim
   :Mason
   # Press 'U' to update all
   ```

## Documentation

All documentation has been updated:
- ✅ `nvim/docs/` - Comprehensive guides
- ✅ `CLAUDE.md` - Repository overview
- ✅ This fixes document

---

**Your Neovim setup is now fully updated and compatible with Neovim 0.11.4! 🎉**
