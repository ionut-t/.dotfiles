# File Navigation

**Leader Key:** `<Space>`

## Oil.nvim - File Manager

### Opening Oil
- `-` - Open parent directory in current window
- `<Space>-` - Open parent directory in floating window

### Navigation Inside Oil
- `<CR>` (Enter) - Open file or enter directory
- `-` - Go to parent directory
- `<C-s>` - Open in horizontal split
- `<M-h>` - Open in horizontal split (custom)
- `<C-v>` - Open in vertical split
- `<C-p>` - Preview file
- `<C-c>` - Close Oil

### File Operations
- `g?` - Show help
- `g.` - Toggle hidden files
- `g\` - Toggle trash
- `gs` - Change sort order
- `gx` - Open file in external program
- `g?` - Open help

### Editing Operations
Oil treats the file list like a buffer, so you can edit it:
- Edit file/folder names directly in the buffer
- Delete lines to delete files
- Add lines to create files/folders
- Save with `:w` to apply changes

### Features
- Shows hidden files by default
- Icon support (requires Nerd Font)
- Shows parent directory in winbar
- Integrated with git (shows status)

---

## Telescope - Fuzzy Finder

### File Finding

#### Basic File Search
- `<Space>ff` - **[F]ind [F]iles** (main file finder)
  - Searches all files in project
  - Respects .gitignore
  - Includes hidden files
  - Excludes: node_modules, .git, .venv

#### Contextual File Search
- `<Space>fs` - **[F]ind [S]ibling Files**
  - Finds files in same directory as current file
  - Perfect for quickly switching between related files

#### Recent Files
- `<Space>s.` - **[S]earch Recent Files** (oldfiles)
  - Shows recently opened files
  - Great for returning to previous work

#### Buffer Search
- `<Space><Space>` - **Find Existing Buffers**
  - Lists all open buffers
  - Fuzzy search through open files
  - Shows buffer numbers

### Git Integration

#### Git Status
- `<Space>fm` - **[F]ind [M]odified Files**
  - Shows all modified files (git status)
  - Displays git status icons:
    - `A` - Added
    - `M` - Modified
    - `D` - Deleted
    - `R` - Renamed
    - `C` - Copied
    - `U` - Unmerged
    - `?` - Untracked

#### Git Changed Files
- `<Space>fc` - **[F]ind [C]hanged Files**
  - More focused than git status
  - Shows only tracked changed files
  - Includes untracked files

### Text Search

#### Live Grep
- `<Space>sg` - **[S]earch by [G]rep**
  - Live grep across entire project
  - Real-time search as you type
  - Respects .gitignore
  - Searches hidden files
  - Excludes: node_modules, .git, .venv

#### Word Search
- `<Space>sw` - **[S]earch current [W]ord**
  - Searches for word under cursor
  - Across entire project
  - Useful for finding all occurrences

#### Buffer Search
- `<Space>/` - **Fuzzy Search in Current Buffer**
  - Searches only current file
  - Dropdown style preview
  - No preview window (compact view)

#### Open Files Search
- `<Space>s/` - **[S]earch [/] in Open Files**
  - Live grep but only in open buffers
  - Perfect for searching across working set

### Help & Documentation

- `<Space>h` - **Find [H]elp**
  - Search all Neovim help tags
  - Includes plugin documentation
  - Opens help in split window

- `<Space>sk` - **[S]earch [K]eymaps**
  - Lists all keymaps
  - Shows descriptions
  - Find what keys do

### Telescope Pickers

- `<Space>ss` - **[S]earch [S]elect Telescope**
  - Lists all available telescope pickers
  - Meta-search: search for searchers
  - Discover telescope features

### Diagnostics

- `<Space>sd` - **[S]earch [D]iagnostics**
  - Lists all LSP diagnostics
  - Errors, warnings, info, hints
  - Across entire project
  - Jump directly to issues

### Resume

- `<Space>sr` - **[S]earch [R]esume**
  - Reopens last telescope picker
  - Preserves search query
  - Useful for continuing work

---

## Telescope Navigation

### Insert Mode (while searching)
- `Ctrl-j` - Move to next item
- `Ctrl-k` - Move to previous item
- `Ctrl-l` - Select item (open)
- `Ctrl-n` - Next item (default)
- `Ctrl-p` - Previous item (default)

### Opening Files
- `<CR>` - Open in current window
- `Ctrl-x` - Open in horizontal split
- `Ctrl-v` - Open in vertical split
- `Ctrl-t` - Open in new tab

### Preview Navigation
- `Ctrl-u` - Scroll preview up
- `Ctrl-d` - Scroll preview down

### Actions
- `Ctrl-q` - Send results to quickfix list
- `Tab` - Toggle selection (multi-select)
- `Shift-Tab` - Toggle selection (reverse)
- `Ctrl-a` - Select all
- `Ctrl-/` - Show mappings (help)

### Exiting
- `Esc` - Close telescope
- `Ctrl-c` - Close telescope

---

## Window Management

### Creating Windows
- `:split` or `:sp` - Horizontal split
- `:vsplit` or `:vsp` - Vertical split
- `:new` - New horizontal split with empty buffer
- `:vnew` - New vertical split with empty buffer
- `Ctrl-w s` - Horizontal split (same file)
- `Ctrl-w v` - Vertical split (same file)

### Navigating Windows
- `Ctrl-h` - Move to left window
- `Ctrl-l` - Move to right window
- `Ctrl-j` - Move to lower window
- `Ctrl-k` - Move to upper window
- `Ctrl-w w` - Cycle through windows
- `Ctrl-w p` - Go to previous window

### Resizing Windows
- `Ctrl-w =` - Make all windows equal size
- `Ctrl-w _` - Maximize height
- `Ctrl-w |` - Maximize width
- `Ctrl-w +` - Increase height
- `Ctrl-w -` - Decrease height
- `Ctrl-w >` - Increase width
- `Ctrl-w <` - Decrease width
- `:resize 20` - Set height to 20 lines
- `:vertical resize 80` - Set width to 80 columns

### Moving Windows
- `Ctrl-w H` - Move window to far left
- `Ctrl-w L` - Move window to far right
- `Ctrl-w J` - Move window to bottom
- `Ctrl-w K` - Move window to top
- `Ctrl-w r` - Rotate windows
- `Ctrl-w x` - Exchange with next window

### Closing Windows
- `Ctrl-w q` - Close current window
- `Ctrl-w o` - Close all other windows
- `:q` - Close current window
- `:only` - Close all other windows

---

## Buffer Management

### Buffer Navigation
- `:bnext` or `:bn` - Next buffer
- `:bprevious` or `:bp` - Previous buffer
- `:buffer <number>` or `:b <number>` - Go to buffer number
- `:buffer <name>` or `:b <name>` - Go to buffer by name (partial match)
- `Tab` - Next buffer (via bufferline)
- `Shift-Tab` - Previous buffer (via bufferline)

### Buffer Information
- `:buffers` or `:ls` - List all buffers
  - `%` - Current buffer
  - `#` - Alternate buffer
  - `a` - Active buffer (loaded and visible)
  - `h` - Hidden buffer
  - `+` - Modified buffer
- `Ctrl-^` or `Ctrl-6` - Switch to alternate buffer

### Buffer Operations
- `:edit <file>` or `:e <file>` - Open file in buffer
- `:badd <file>` - Add file to buffer list
- `:bdelete` or `:bd` - Delete buffer
- `:bdelete!` or `:bd!` - Force delete buffer
- `Bdelete` - Delete buffer (via vim-bbye, preserves layout)
- `:bufdo <command>` - Execute command in all buffers
- `:1,5bd` - Delete buffers 1 through 5

### Bufferline Plugin
- Visual tabs at top of screen
- Shows buffer icons and names
- Click to switch buffers
- Close icons on buffers
- Modified indicator (●)

---

## Quick Reference

### Most Used Commands
```
-              Open file manager
<Space>ff      Find files
<Space>sg      Search grep
<Space><Space> Switch buffers
<Space>fs      Find sibling files
<Space>fm      Find modified files
Ctrl-h/j/k/l   Navigate windows
Tab/Shift-Tab  Next/previous buffer
```

### Common Workflows

**Open Related File:**
1. `-` to open file manager
2. Navigate with `j/k`
3. `<CR>` to open file

**Search Project:**
1. `<Space>sg` for live grep
2. Type search term
3. `Ctrl-j/k` to navigate results
4. `<CR>` to open file

**Switch Between Files:**
1. `<Space><Space>` for buffer list
2. Type part of filename
3. `<CR>` to switch

**Find and Replace Across Project:**
1. `<Space>sg` to search
2. `Ctrl-q` to send to quickfix
3. `:cdo s/old/new/g | update` to replace
