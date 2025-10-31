# Terminal & Configuration

**Leader Key:** `<Space>`

## Integrated Terminal

### Opening Terminal
- `<Space>tt` - **Open terminal in horizontal split** (in current file's directory)
- `<Space>tv` - **Open terminal in vertical split** (in current file's directory)

### Terminal Features
- Opens in the directory of the current file
- Handles Oil.nvim paths (oil://) correctly
- Automatically enters insert mode
- Horizontal split sized to 15 lines

### Terminal Mode Navigation
- `Esc Esc` - Exit terminal mode (back to normal mode)
- `Ctrl-\ Ctrl-n` - Alternative exit terminal mode
- `Ctrl-h/j/k/l` - Navigate to other windows (from normal mode)

### Using Terminal
Once in terminal:
1. You're in insert mode - type commands as usual
2. Press `Esc Esc` to enter normal mode
3. In normal mode:
   - Navigate with `h/j/k/l`
   - Copy text with `y`
   - Switch windows with `Ctrl-h/j/k/l`
4. Press `i` or `a` to return to insert mode in terminal
5. Close with `:q` or `Ctrl-w q`

### Terminal Commands
- `:terminal` or `:term` - Open terminal in current window
- `:split | terminal` - Open in horizontal split
- `:vsplit | terminal` - Open in vertical split
- `:tabnew | terminal` - Open in new tab

---

## Configuration Management

### Reload Configuration
- `<Space>rc` - **[R]eload nvim [C]onfiguration** (full reload)
  - Sources $MYVIMRC (init.lua)
  - Reloads all settings
  - Shows notification when done
  - Note: Doesn't reload plugins

- `<Space>rl` - **[R]eload [L]ua config files** (faster)
  - Reloads: options.lua, keymaps.lua, snippets.lua
  - Faster than full reload
  - Doesn't reload plugins
  - Good for testing config changes

### Full Restart
To fully reload plugins:
1. Save all work
2. `:qa` to quit Neovim
3. Restart Neovim
4. Or use `:Lazy reload <plugin>`

---

## Plugin Management (Lazy.nvim)

### Opening Lazy
- `:Lazy` - Open Lazy plugin manager UI

### Lazy UI Commands
- `I` or `i` - Install missing plugins
- `U` or `u` - Update plugins
- `S` or `s` - Sync (install missing + update + clean)
- `C` or `c` - Clean (remove unused plugins)
- `L` or `l` - Show log
- `P` or `p` - Profile startup time
- `R` or `r` - Reload plugin
- `X` or `x` - Clear finished tasks
- `D` or `d` - Debug plugin
- `?` - Show help
- `q` - Close Lazy UI

### Lazy Commands
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing + update + clean
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates
- `:Lazy log` - Show recent updates
- `:Lazy restore <lockfile>` - Restore from lockfile
- `:Lazy profile` - Profile startup time
- `:Lazy reload <plugin>` - Reload specific plugin

### Plugin Status Icons
- `✓` - Installed and loaded
- `●` - Loaded (not lazy-loaded)
- `○` - Not loaded (lazy-loaded)
- `⚠` - Warning
- `✗` - Not installed

### Lockfile
- Lazy generates `lazy-lock.json`
- Pins exact plugin versions
- Commit this file for reproducibility
- Restore with `:Lazy restore`

---

## File Operations

### Save & Quit
- `:w` - Save (write) file
- `:w!` - Force save (override readonly)
- `:q` - Quit (if no unsaved changes)
- `:q!` - Quit without saving (force)
- `:wq` - Save and quit
- `:x` or `ZZ` - Save (if modified) and quit
- `ZQ` - Quit without saving
- `:qa` - Quit all windows
- `:qa!` - Quit all without saving
- `:wqa` - Save all and quit

### File Management
- `:e <file>` - Edit (open) file
- `:e!` - Reload file (discard changes)
- `:e.` - Edit current directory (opens netrw, but you have Oil.nvim)
- `:saveas <file>` - Save as new file
- `:file <name>` - Rename current buffer
- `:read <file>` - Insert file contents below cursor
- `:write <file>` - Write to different file

### File Information
- `Ctrl-g` - Show file info (name, line, %)
- `g Ctrl-g` - Show detailed info (word count, byte count)
- `:file` - Show current filename
- `:pwd` - Print working directory
- `:cd <path>` - Change directory

---

## Editor Settings

### Line Numbers
- `:set number` - Show line numbers (default on)
- `:set nonumber` - Hide line numbers
- `:set relativenumber` - Show relative numbers (default on)
- `:set norelativenumber` - Hide relative numbers

### Display
- `:set wrap` - Wrap long lines
- `:set nowrap` - Don't wrap lines
- `:set cursorline` - Highlight current line (default on)
- `:set nocursorline` - Don't highlight current line
- `:set colorcolumn=80` - Show column at 80 chars
- `:set colorcolumn=` - Hide column

### Indentation
- `:set tabstop=4` - Tab display width
- `:set shiftwidth=4` - Indent width
- `:set expandtab` - Use spaces instead of tabs (default on)
- `:set noexpandtab` - Use tabs
- `:set autoindent` - Auto indent (default on)
- `:set smartindent` - Smart indent (default on)

### Search
- `:set hlsearch` - Highlight search (default on)
- `:set nohlsearch` - Don't highlight search
- `:set incsearch` - Incremental search (default on)
- `:set ignorecase` - Case insensitive (default on)
- `:set smartcase` - Smart case (default on)

### Clipboard
- `:set clipboard=unnamedplus` - Use system clipboard (default)
- `:set clipboard=` - Use internal clipboard only

---

## Help System

### Getting Help
- `:help` - Open help
- `:help <topic>` - Help on specific topic
- `<Space>h` - Search help with Telescope (fuzzy finder)
- `:help <topic>` then `Ctrl-]` - Jump to tag
- `:help <topic>` then `Ctrl-o` - Jump back

### Help Navigation
- `Ctrl-]` - Jump to tag under cursor
- `Ctrl-o` - Jump to older position
- `Ctrl-i` - Jump to newer position
- `Ctrl-t` - Jump back (same as Ctrl-o in help)
- `/` - Search in help
- `n` - Next match
- `N` - Previous match
- `:q` - Close help

### Useful Help Topics
- `:help quickref` - Quick reference
- `:help index` - Index of all commands
- `:help user-manual` - User manual
- `:help vim-modes` - Vim modes
- `:help motion` - Motion commands
- `:help pattern` - Search patterns
- `:help options` - All options
- `:help keymaps` - Key mappings
- `:help lsp` - LSP information
- `:help telescope.nvim` - Telescope help

### Plugin Help
- `:help <plugin-name>` - Plugin documentation
- Examples:
  - `:help oil.nvim`
  - `:help telescope.nvim`
  - `:help nvim-cmp`
  - `:help lazy.nvim`

---

## Diagnostics & Debugging

### Health Check
- `:checkhealth` - Run all health checks
- `:checkhealth <plugin>` - Check specific plugin
  - `:checkhealth vim.lsp`
  - `:checkhealth telescope`
  - `:checkhealth lazy`

### Messages
- `:messages` - Show message history
- `:messages clear` - Clear message history
- `g<` - Show last page of previous command output

### Lua Inspection
- `:lua =vim.inspect(vim.lsp.get_active_clients())` - Inspect active LSP clients
- `:lua =vim.inspect(vim.api.nvim_list_bufs())` - Inspect buffers
- `:lua print(vim.fn.expand('%:p'))` - Print current file path

### LSP Logging
- `:lua vim.lsp.set_log_level("debug")` - Enable LSP debug logging
- `:lua vim.lsp.set_log_level("info")` - Reset to info level
- `:lua =vim.lsp.get_log_path()` - Get LSP log file path

---

## Sessions

### Manual Sessions
- `:mksession session.vim` - Save session
- `:source session.vim` - Load session
- `:mksession! session.vim` - Overwrite existing session

### What's Saved
- Window layout
- Open files
- Working directory
- Some settings

---

## Command-Line Mode

### History
- `Up` / `Down` - Navigate command history
- `Ctrl-p` / `Ctrl-n` - Navigate command history (alternative)
- `:history` - Show command history
- `q:` - Open command-line window (editable history)

### Command-Line Editing
- `Ctrl-b` - Move to beginning
- `Ctrl-e` - Move to end
- `Ctrl-w` - Delete word backward
- `Ctrl-u` - Delete to beginning
- `Ctrl-r "` - Insert from unnamed register
- `Ctrl-r %` - Insert current filename
- `Tab` - Command/file completion
- `Ctrl-d` - List completions

### Command-Line Window
- `q:` - Open command-line window
- `q/` - Open search history window
- `q?` - Open backward search history window
- Edit history like normal buffer
- `Enter` to execute line
- `:q` to close

---

## Bufdo, Windo, Tabdo

### Execute in Multiple Locations
- `:bufdo <cmd>` - Execute command in all buffers
  - `:bufdo %s/old/new/ge | update` - Replace in all buffers
- `:windo <cmd>` - Execute in all windows
  - `:windo set number` - Enable numbers in all windows
- `:tabdo <cmd>` - Execute in all tabs
  - `:tabdo close` - Close all tabs
- `:argdo <cmd>` - Execute in argument list
  - `:argdo %s/old/new/ge | update` - Replace in all args

---

## Configuration Files

### File Locations
- Main config: `~/.config/nvim/init.lua`
- Core settings: `~/.config/nvim/lua/core/`
  - `options.lua` - Editor options
  - `keymaps.lua` - Key mappings
  - `snippets.lua` - Code snippets
- Plugin configs: `~/.config/nvim/lua/plugins/`
  - Each plugin has its own .lua file
- Data directory: `~/.local/share/nvim/`
- Cache directory: `~/.cache/nvim/`

### Editing Config
1. `:e ~/.config/nvim/init.lua` - Edit main config
2. `:e ~/.config/nvim/lua/core/options.lua` - Edit options
3. `:e ~/.config/nvim/lua/core/keymaps.lua` - Edit keymaps
4. Make changes
5. `<Space>rc` or `<Space>rl` to reload

### Adding Plugins
1. Create new file: `~/.config/nvim/lua/plugins/newplugin.lua`
2. Write plugin spec (see existing plugins for examples)
3. Add `require 'plugins.newplugin'` to `init.lua`
4. Restart Neovim or `:Lazy reload`
5. `:Lazy sync` to install

---

## Useful Commands

### Miscellaneous
- `:!<cmd>` - Execute shell command
  - `:!ls` - List files
  - `:!git status` - Run git status
- `:r !<cmd>` - Insert command output
  - `:r !date` - Insert current date
- `:%!<cmd>` - Filter buffer through command
  - `:%!jq` - Format JSON
  - `:%!sort` - Sort lines
- `:cd %:h` - Change to current file's directory
- `:lcd %:h` - Change directory for current window only
- `:so %` - Source current file
- `:runtime! plugin/**/*.vim` - Source all plugin files

### System Interaction
- `:!open .` - Open current directory in Finder (macOS)
- `:!explorer .` - Open in Explorer (Windows)
- `:!xdg-open .` - Open in file manager (Linux)

---

## Tips

1. **Quick Config Edits:** Use `<Space>rc` to reload after changes
2. **Test Keymaps:** Use `:verbose map <key>` to see what a key does
3. **Plugin Issues:** Run `:checkhealth <plugin>` to diagnose
4. **Learn Help System:** Most answers are in `:help`
5. **Use Terminal:** `<Space>tt` for quick terminal access
6. **Profile Startup:** `:Lazy profile` shows slow plugins
7. **Check Messages:** `:messages` shows errors you might have missed
8. **Lockfile:** Commit `lazy-lock.json` for reproducible setups
