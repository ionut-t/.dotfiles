# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managing configuration files for development tools and terminal environments across macOS systems. The repository uses a multi-branch workflow (main/work) to maintain separate configurations for different contexts.

## Key Management Script

**sync-dotfiles.zsh** - Interactive dotfile synchronization script
- Location: `./sync-dotfiles.zsh` (alias: `sdf` in zsh)
- Purpose: Sync configuration files between main and work branches using yazi file picker
- Workflow:
  1. Automatically pulls latest changes from the target branch
  2. Prompts for source/target branch selection
  3. Opens yazi for interactive file selection (Space to select, q to confirm)
  4. Syncs selected files and commits changes
  5. Returns to original branch with stashed changes restored
- Requirements: yazi must be installed
- Note: Uses zsh-specific features (word splitting, extended globbing)

## Directory Structure

The repository is organized by tool, with each tool's config stored in its standard location:

- **nvim/** - Neovim configuration (Lua-based with lazy.nvim plugin manager)
- **helix/** - Helix editor configuration
- **zsh/** - Zsh shell configuration with Oh My Zsh and powerlevel10k
- **tmux/** - Terminal multiplexer configuration
- **git/** - Git aliases and settings
- **alacritty/** - Alacritty terminal emulator config (TOML)
- **ghostty/** - Ghostty terminal config
- **kitty/** - Kitty terminal config
- **yazi/** - Yazi file manager config (TOML)
- **zellij/** - Zellij terminal workspace config
- **vim/** - Vim configuration

## Neovim Architecture

Neovim uses a modular Lua configuration structure:

**Entry Point**: `nvim/.config/nvim/init.lua`
- Loads core modules: options, keymaps, snippets
- Bootstraps lazy.nvim plugin manager
- Loads all plugin configurations from `lua/plugins/`

**Core Modules** (`nvim/.config/nvim/lua/core/`):
- `options.lua` - Editor options (line numbers, clipboard, indentation, etc.)
- `keymaps.lua` - Custom key bindings (leader key: Space)
- `snippets.lua` - Custom code snippets

**Plugin System** (`nvim/.config/nvim/lua/plugins/`):
- Each plugin has its own configuration file (e.g., `lsp.lua`, `telescope.lua`)
- LSP configuration uses mason.nvim for automatic LSP installation
- Language-specific plugins: `angular.lua`, `go.lua`, `rust.lua`, `zig.lua`
- UI plugins: `theme.lua` (catppuccin), `lualine.lua`, `bufferline.lua`
- File navigation: `oil.lua` (file manager), `telescope.lua` (fuzzy finder)
- Git integration: `gitsigns.lua`
- Code quality: `none-ls.lua` (formatting/linting), `copilot.lua`
- Diagnostics: `trouble.nvim` (diagnostic panel/viewer)

**Adding New Plugins**:
1. Create new file in `lua/plugins/` (e.g., `lua/plugins/newplugin.lua`)
2. Return a lazy.nvim plugin spec table with the plugin configuration
3. Add `require 'plugins.newplugin'` to the `require('lazy').setup` call in `init.lua`
4. The plugin will be automatically loaded by lazy.nvim on next restart

**Diagnostic System**:
- **Status bar display** (`lualine.lua`): Shows counts for errors, warnings, info, and hints in status bar
- **Diagnostic navigation** (`core/keymaps.lua`):
  - `]d` - Jump to next diagnostic
  - `[d` - Jump to previous diagnostic
  - `<leader>e` - Show diagnostic float at cursor
  - `<leader>q` - Open diagnostic quickfix list
- **Trouble.nvim panel** (`plugins/trouble.lua`):
  - `<leader>xx` - Toggle trouble diagnostics panel (workspace-wide)
  - `<leader>xX` - Toggle buffer diagnostics only
  - `<leader>xf` - Focus trouble panel
  - `<leader>xb` - Focus back to buffer
  - `<leader>cs` - Show symbols in trouble
  - `<leader>cl` - Show LSP definitions/references
  - `<leader>xL` - Location list in trouble
  - `<leader>xQ` - Quickfix list in trouble
  - Inside trouble panel: `j/k` (navigate), `<CR>` (jump), `o` (jump & close), `q` (close), `K` (full message), `p` (preview)

## Zsh Configuration

**File**: `zsh/.zshrc`

Key features:
- **Theme**: powerlevel10k with starship
- **Plugins**: git, sudo, gcloud, python, zsh-autosuggestions, zsh-syntax-highlighting
- **Package Managers**: NVM, Conda, Yarn
- **CLI Tools**:
  - fzf (fuzzy finder) with custom catppuccin theme and fd integration
  - eza (modern ls replacement)
  - zoxide (smart cd replacement, alias: `z`)
  - bat (cat with syntax highlighting, theme: catppuccin_mocha)
  - thefuck (command correction, alias: `fk`)
- **Editor**: Default editor set to helix (`hx`)
- **Custom Functions**: `gem-ng()` - Launches gemini with Angular prompt

Common aliases:
- `sdf` - Run sync-dotfiles.zsh script
- `cd` - aliased to zoxide (`z`)
- `ls` - aliased to eza with icons and git info
- `t/ta/tls/tks` - tmux shortcuts (tmux, attach, list, kill-session)
- `code` - Opens code-insiders
- `vim` - Opens MacVim
- `ws` - Opens WebStorm
- `lvim` - Opens LunarVim
- `f` - fzf fuzzy finder
- `fp` - fzf with preview

## Git Configuration

**File**: `git/.gitconfig`

Custom aliases:
- `git ac "message"` - Add all and commit
- `git acp "message"` - Add, commit, and push
- `git co` - Checkout
- `git cob` - Checkout new branch
- `git bd` - Delete branch forcefully
- `git puo` - Push with upstream origin
- `git parent` - Find parent branch (complex branch detection)

Default branch: `main`
Default editor: `hx` (helix)

## Development Paths

The environment includes paths for:
- Go: `$(go env GOPATH)/bin`
- Zig: `~/zig`
- PostgreSQL 17: `/usr/local/opt/postgresql@17/bin`
- Flutter: `~/tools/flutter/bin`
- Conda: `~/anaconda3`
- Docker: `/Applications/Docker.app/Contents/Resources/bin`
- Local binaries: `~/.local/bin`

## Modifying Configurations

When editing dotfiles:
1. Make changes in the current branch (main or work)
2. Test the changes in your environment
3. Commit changes with descriptive commit messages following the pattern: `feat(tool): description` or `Update tool configuration`
4. If changes should be synced to the other branch (main/work):
   - Run `sdf` (or `./sync-dotfiles.zsh`)
   - The script will automatically pull latest changes from the target branch
   - Select source/target branches
   - Use yazi to interactively select files (Space to select, q to confirm)
   - Confirm and the script will sync files and commit automatically

**Important Workflow Notes**:
- The script handles git stashing and branch switching automatically
- Always verify modified files with `git status` before running sync
- Backup files (*.bak, ghostty config backups, yazi *.toml-* files) are typically temporary and should not be committed
- When adding new plugin files to nvim, remember to add the `require` statement to `init.lua`

**Branch Strategy**:
- **main**: Personal/home configuration
- **work**: Work-specific configuration
- Use sync-dotfiles.zsh to maintain consistency across branches while allowing environment-specific customizations
