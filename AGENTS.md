# AGENTS.md

This document provides essential information for AI agents working within this dotfiles repository.

## Repository Overview

This repository manages personal dotfiles for various development tools and terminal environments across macOS systems. It employs a multi-branch workflow (`main`/`work`) to maintain distinct configurations for different contexts.

## Key Management Script

### `sync-dotfiles.zsh` (alias: `sdf`)

- **Location**: `./sync-dotfiles.zsh`
- **Purpose**: Interactively synchronize configuration files between `main` and `work` branches using `yazi` file picker.
- **Workflow**:
  1.  Automatically pulls latest changes from the target branch.
  2.  Prompts for source/target branch selection.
  3.  Opens `yazi` for interactive file selection (Space to select, `q` to confirm).
  4.  Syncs selected files and commits changes automatically.
  5.  Returns to the original branch, restoring any stashed changes.
- **Requirements**: `yazi` must be installed.
- **Note**: Uses zsh-specific features.

## Directory Structure

The repository is organized by tool, with each tool's configuration stored in its standard location:

- `nvim/`: Neovim configuration (Lua-based with lazy.nvim)
- `helix/`: Helix editor configuration
- `zsh/`: Zsh shell configuration (Oh My Zsh, powerlevel10k)
- `tmux/`: Terminal multiplexer configuration
- `git/`: Git aliases and settings
- `alacritty/`: Alacritty terminal emulator config (TOML)
- `ghostty/`: Ghostty terminal config
- `kitty/`: Kitty terminal config
- `yazi/`: Yazi file manager config (TOML)
- `zellij/`: Zellij terminal workspace config
- `vim/`: Vim configuration
- `atuin/`: Atuin shell history config

## Neovim Architecture

Neovim uses a modular Lua configuration structure located at `nvim/.config/nvim/`.

- **Entry Point**: `init.lua`
  - Loads core modules and bootstraps `lazy.nvim` plugin manager.
  - Loads all plugin configurations from `lua/plugins/`.
- **Core Modules** (`lua/core/`):
  - `options.lua`: Editor options (line numbers, clipboard, indentation).
  - `keymaps.lua`: Custom key bindings (leader key: Space).
  - `snippets.lua`: Custom code snippets.
- **Plugin System** (`lua/plugins/`):
  - Each plugin has its own configuration file (e.g., `lsp.lua`, `telescope.lua`).
  - LSP configuration uses `mason.nvim`.
  - Example categories: Language-specific, UI, File navigation, Git integration, Code quality, Diagnostics.
- **Adding New Plugins**:
  1.  Create a new file in `lua/plugins/` (e.g., `lua/plugins/newplugin.lua`).
  2.  Return a `lazy.nvim` plugin spec table.
  3.  Add `require 'plugins.newplugin'` to the `require('lazy').setup` call in `init.lua`.
- **Diagnostic System**:
  - Status bar display (`lualine.lua`), diagnostic navigation (`core/keymaps.lua`), `trouble.nvim` panel (`plugins/trouble.lua`).
  - Keybindings for diagnostics are detailed in `core/keymaps.lua` and `plugins/trouble.lua`.

## Zsh Configuration

- **File**: `zsh/.zshrc`
- **Key Features**:
  - **Theme**: `powerlevel10k` with `starship`.
  - **Plugins**: `git`, `sudo`, `gcloud`, `python`, `zsh-autosuggestions`, `zsh-syntax-highlighting`.
  - **Package Managers**: NVM, Conda, Yarn.
  - **CLI Tools**: `fzf` (fuzzy finder), `eza` (ls replacement), `zoxide` (smart cd), `bat` (cat with syntax highlighting), `thefuck` (command correction).
  - **Editor**: Default editor set to `helix` (`hx`).
  - **Custom Functions**: `gem-ng()` (launches gemini with Angular prompt).
- **Common Aliases**: `sdf`, `cd` (zoxide), `ls` (eza), `t/ta/tls/tks` (tmux), `code`, `vim`, `ws`, `lvim`, `f`, `fp`.

## Git Configuration

- **File**: `git/.gitconfig`
- **Custom Aliases**: `git ac`, `git acp`, `git co`, `git cob`, `git bd`, `git puo`, `git parent`.
- **Default Branch**: `main`.
- **Default Editor**: `hx` (helix).

## Development Paths

The environment includes paths for: Go, Zig, PostgreSQL 17, Flutter, Conda, Docker, and local binaries.

## Modifying Configurations

- **General Workflow**:
  1.  Make changes in the current branch (`main` or `work`).
  2.  Test the changes in your environment.
  3.  Commit changes with descriptive messages.
- **Syncing Changes (Cross-Branch)**:
  - To sync changes to the other branch (e.g., from `main` to `work`), run `sdf` (or `./sync-dotfiles.zsh`).
  - The script handles `git stash`, branch switching, file selection via `yazi`, syncing, and automatic committing.
  - Always verify modified files with `git status` before running `sdf`.
- **Important Notes**:
  - Backup files (`*.bak`, `ghostty` config backups, `yazi *.toml-*`) are typically temporary and should not be committed.
  - When adding new Neovim plugin files, remember to add the `require` statement to `nvim/.config/nvim/init.lua`.
- **Branch Strategy**:
  - `main`: Personal/home configuration.
  - `work`: Work-specific configuration.
  - Use `sync-dotfiles.zsh` to maintain consistency while allowing environment-specific customizations.

## Commit Conventions

- Commit messages should be descriptive, following the pattern: `feat(tool): description` or `Update tool configuration`.

## Testing Approach

- Formal testing frameworks are generally not used for dotfiles.
- All configuration changes should be manually tested and verified in the respective environment after modification.
