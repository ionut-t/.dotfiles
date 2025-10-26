# Neovim Configuration Documentation

Welcome to the Neovim configuration documentation! This guide is split into focused sections for easy reference.

**Leader Key:** `<Space>`

## 📚 Documentation Structure

### [01 - Basics](./01-basics.md)
Essential Vim motions, modes, editing commands, and fundamental concepts.

**Topics:**
- Essential Vim motions (h/j/k/l, w/b/e, gg/G, etc.)
- Modes (Insert, Visual, Normal)
- Basic editing (copy, paste, delete, undo/redo)
- Text objects (iw, i", i{, ap, etc.)
- Operators + motions (d, c, y, v, =, >, <)
- Search & replace
- Marks & macros
- Repeat commands

### [02 - File Navigation](./02-file-navigation.md)
Finding and managing files, windows, and buffers.

**Topics:**
- Oil.nvim file manager (`-` to open)
- Telescope fuzzy finder (`<Space>ff`, `<Space>sg`, etc.)
- Window management (`Ctrl-h/j/k/l`)
- Buffer management (Tab/Shift-Tab)
- Git integration via Telescope
- Split navigation and resizing

### [03 - LSP & Code Intelligence](./03-lsp-and-coding.md)
Language Server Protocol features for intelligent code editing.

**Topics:**
- Code navigation (`gd`, `gr`, `gI`)
- Symbols (`<Space>ds`, `<Space>ws`)
- Documentation (`K` for hover)
- Code actions (`<Space>ca`, `<Space>rn`)
- Diagnostics (`<Space>sd`, `[d`, `]d`)
- Autocompletion (Ctrl-Space, Tab, Ctrl-y)
- Mason LSP installer
- Language-specific plugins

### [04 - Editing & Git](./04-editing-and-git.md)
Advanced editing features and git integration.

**Topics:**
- Comments (`Ctrl-/`)
- Visual mode editing
- Indentation
- Search & replace (including multi-file)
- Git integration (Gitsigns)
- Text manipulation
- Registers & clipboard
- Spell checking
- Folding

### [05 - Terminal & Configuration](./05-terminal-and-config.md)
Terminal integration and configuration management.

**Topics:**
- Integrated terminal (`<Space>tt`, `<Space>tv`)
- Configuration reload (`<Space>rc`, `<Space>rl`)
- Plugin management (Lazy.nvim)
- File operations
- Editor settings
- Help system
- Diagnostics & debugging
- Configuration file structure

---

## 🚀 Quick Start Guide

### Most Essential Commands

**File Navigation:**
```
-              Open file manager (Oil.nvim)
<Space>ff      Find files
<Space>sg      Search by grep
<Space><Space> Find buffers
```

**Editing:**
```
i              Insert mode
Esc            Normal mode
u              Undo
Ctrl-r         Redo
Ctrl-/         Toggle comment
```

**Code Intelligence:**
```
gd             Go to definition
gr             Go to references
K              Show documentation
<Space>ca      Code actions
<Space>rn      Rename symbol
```

**Window Navigation:**
```
Ctrl-h/j/k/l   Move between windows
Tab            Next buffer
Shift-Tab      Previous buffer
```

**Search:**
```
/pattern       Search forward
n              Next match
*              Search word under cursor
<Space>/       Fuzzy find in buffer
```

---

## 🎯 Common Workflows

### Opening and Editing Files
1. `<Space>ff` to find files
2. Type to filter
3. `<CR>` to open
4. `i` to start editing
5. `Esc` to return to normal mode

### Code Navigation
1. `gd` to jump to definition
2. `K` to read documentation
3. `Ctrl-t` to jump back
4. `gr` to see all references

### Search and Replace
1. `<Space>sg` to search project
2. Find what you want
3. `Ctrl-q` to send to quickfix
4. `:cdo s/old/new/g | update` to replace all

### Terminal Usage
1. `<Space>tt` to open terminal
2. Run commands
3. `Esc Esc` to exit terminal mode
4. `Ctrl-w q` to close terminal

---

## 🔧 Configuration

### File Structure
```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua         # Editor settings
│   │   ├── keymaps.lua         # Key mappings
│   │   └── snippets.lua        # Code snippets
│   └── plugins/
│       ├── lsp.lua             # LSP configuration
│       ├── telescope.lua       # Fuzzy finder
│       ├── oil.lua             # File manager
│       ├── theme.lua           # Color scheme
│       ├── go.lua              # Go support
│       ├── rust.lua            # Rust support
│       ├── angular.lua         # Angular support
│       ├── zig.lua             # Zig support
│       └── ...                 # Other plugins
└── docs/                       # This documentation
```

### Key Plugins
- **lazy.nvim** - Plugin manager
- **telescope.nvim** - Fuzzy finder
- **oil.nvim** - File manager
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/tool installer
- **nvim-cmp** - Autocompletion
- **nvim-treesitter** - Syntax highlighting
- **gitsigns.nvim** - Git integration
- **catppuccin** - Color theme

### Installed Language Servers
- TypeScript/JavaScript (ts_ls)
- Lua (lua_ls)
- Python (pylsp, ruff)
- HTML, CSS, Tailwind
- JSON, YAML, SQL

---

## 📖 Learning Path

### Beginner
1. Start with [01-basics.md](./01-basics.md)
2. Learn basic motions: `h/j/k/l`, `w/b`, `i/a/o`
3. Practice text objects: `ciw`, `di"`, `yap`
4. Master basic editing: copy, paste, undo

### Intermediate
1. Study [02-file-navigation.md](./02-file-navigation.md)
2. Use Telescope for file finding
3. Learn window navigation
4. Practice buffer management

### Advanced
1. Master [03-lsp-and-coding.md](./03-lsp-and-coding.md)
2. Use code actions and refactoring
3. Learn [04-editing-and-git.md](./04-editing-and-git.md)
4. Multi-file search and replace
5. Customize via [05-terminal-and-config.md](./05-terminal-and-config.md)

---

## 💡 Tips

1. **Use Leader Key:** Most custom commands start with `<Space>`
2. **Telescope is Your Friend:** Use it for files, grep, buffers, help
3. **Learn Text Objects:** They make editing much more efficient
4. **Use Help System:** `:help <topic>` or `<Space>h` for fuzzy help search
5. **Practice Motions:** Combine operators with motions/text objects
6. **Oil.nvim for Files:** Press `-` to open file manager anywhere
7. **Terminal Integration:** `<Space>tt` opens terminal in current file's directory
8. **Code Actions:** `<Space>ca` is your refactoring friend
9. **Jump Back:** After `gd`, use `Ctrl-t` to return
10. **Reload Config:** `<Space>rc` to test config changes quickly

---

## 🆘 Getting Help

- **Built-in Help:** `:help <topic>`
- **Fuzzy Help Search:** `<Space>h`
- **Keymaps:** `<Space>sk` to search all keymaps
- **Check Health:** `:checkhealth` to diagnose issues
- **Plugin Help:** `:help <plugin-name>`
- **Messages:** `:messages` to see error messages

---

## 🔗 External Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Vim Motions](https://vim.rtorr.com/)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)

---

**Happy Vimming! 🎉**
