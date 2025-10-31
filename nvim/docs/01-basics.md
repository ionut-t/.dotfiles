# Neovim Basics

**Leader Key:** `<Space>`

## Essential Vim Motions

### Basic Movement
- `h/j/k/l` - Move left/down/up/right
- `w` - Move forward by word
- `b` - Move backward by word
- `e` - Move to end of word
- `0` - Move to start of line
- `^` - Move to first non-blank character
- `$` - Move to end of line
- `gg` - Go to first line
- `G` - Go to last line

### Line Navigation
- `{` / `}` - Move by paragraph
- `(` / `)` - Move by sentence
- `%` - Jump to matching bracket/parenthesis

### Screen Navigation
- `Ctrl-u` - Scroll half page up
- `Ctrl-d` - Scroll half page down
- `Ctrl-b` - Scroll full page up
- `Ctrl-f` - Scroll full page down
- `H` - Move to top of screen
- `M` - Move to middle of screen
- `L` - Move to bottom of screen
- `zt` - Scroll line to top
- `zz` - Scroll line to center
- `zb` - Scroll line to bottom

## Modes

### Entering Insert Mode
- `i` - Insert before cursor
- `I` - Insert at beginning of line
- `a` - Insert after cursor
- `A` - Insert at end of line
- `o` - Open new line below
- `O` - Open new line above
- `s` - Delete character and insert
- `S` - Delete line and insert
- `C` - Change from cursor to end of line

### Exiting Insert Mode
- `Esc` - Return to normal mode
- `Ctrl-c` - Return to normal mode (alternative)
- `Ctrl-[` - Return to normal mode (alternative)

### Visual Mode
- `v` - Character-wise visual mode
- `V` - Line-wise visual mode
- `Ctrl-v` - Block-wise visual mode
- `gv` - Reselect last visual selection

## Basic Editing

### Copy, Cut, Paste
- `yy` or `Y` - Yank (copy) line
- `dd` - Delete (cut) line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `x` - Delete character under cursor
- `X` - Delete character before cursor

### Undo/Redo
- `u` - Undo
- `Ctrl-r` - Redo
- `U` - Undo all changes on line

### Change/Replace
- `r` - Replace single character
- `R` - Enter replace mode
- `~` - Toggle case of character
- `ciw` - Change inner word
- `caw` - Change around word
- `cc` - Change entire line

### Delete
- `diw` - Delete inner word
- `daw` - Delete around word
- `D` - Delete to end of line
- `d$` - Delete to end of line
- `d0` - Delete to start of line

## Text Objects

### Word Objects
- `iw` - Inner word (excludes surrounding space)
- `aw` - Around word (includes surrounding space)
- `iW` - Inner WORD (space-separated)
- `aW` - Around WORD

### Quote/Bracket Objects
- `i"` / `a"` - Inside/around double quotes
- `i'` / `a'` - Inside/around single quotes
- `i\`` / `a\`` - Inside/around backticks
- `i(` / `a(` - Inside/around parentheses
- `i{` / `a{` - Inside/around braces
- `i[` / `a[` - Inside/around brackets
- `i<` / `a<` - Inside/around angle brackets

### Other Objects
- `it` / `at` - Inside/around HTML/XML tags
- `ip` / `ap` - Inside/around paragraph
- `is` / `as` - Inside/around sentence

## Operators + Text Objects

Combine operators with motions/text objects:

**Operators:**
- `d` - Delete
- `c` - Change
- `y` - Yank (copy)
- `v` - Visual select
- `>` / `<` - Indent/dedent
- `=` - Auto-indent
- `gU` - Make uppercase
- `gu` - Make lowercase

**Examples:**
- `diw` - Delete inner word
- `ci"` - Change inside quotes
- `yap` - Yank around paragraph
- `vi{` - Visual select inside braces
- `=i{` - Auto-indent inside braces
- `>ip` - Indent paragraph
- `gUiw` - Uppercase word
- `guaw` - Lowercase word

## Search

### Basic Search
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next match
- `N` - Previous match
- `*` - Search forward for word under cursor
- `#` - Search backward for word under cursor
- `Esc` - Clear search highlight

### Search & Replace
- `:s/old/new/` - Replace first occurrence in line
- `:s/old/new/g` - Replace all in line
- `:%s/old/new/g` - Replace all in file
- `:%s/old/new/gc` - Replace all with confirmation
- `:'<,'>s/old/new/g` - Replace in visual selection

### Search Options
- `:set hlsearch` - Highlight search results (default on)
- `:set incsearch` - Show matches as you type (default on)
- `:set ignorecase` - Case-insensitive search (default on)
- `:set smartcase` - Case-sensitive if uppercase present (default on)

## Indentation

### Visual Mode Indenting
- `>` - Indent selected lines
- `<` - Dedent selected lines
- `=` - Auto-indent selected lines

### Normal Mode Indenting
- `>>` - Indent current line
- `<<` - Dedent current line
- `==` - Auto-indent current line
- `>ip` - Indent paragraph
- `=ip` - Auto-indent paragraph

## Marks

### Setting Marks
- `ma` - Set mark 'a' (local to file)
- `mA` - Set mark 'A' (global across files)

### Jumping to Marks
- `'a` - Jump to mark 'a' (first non-blank)
- `` `a `` - Jump to exact position of mark 'a'
- `''` - Jump to last position
- ``` `` ``` - Jump to last exact position

### Special Marks (automatic)
- `'.` - Jump to last change
- `'^` - Jump to last insert position
- `'[` - Jump to start of last change/yank
- `']` - Jump to end of last change/yank

### List Marks
- `:marks` - Show all marks
- `:delmarks a` - Delete mark 'a'
- `:delmarks!` - Delete all lowercase marks

## Macros

### Recording
- `qa` - Start recording macro in register 'a'
- `q` - Stop recording

### Executing
- `@a` - Execute macro 'a'
- `@@` - Execute last macro
- `10@a` - Execute macro 'a' 10 times

### Tips
- Use `0` to start recording from beginning of line
- Test macro on single line first
- Store multiple macros in different registers (a-z)

## Repeat Commands

- `.` - Repeat last change
- `@:` - Repeat last command-line command
- `n` - Repeat last search
- `;` - Repeat last f/t motion
- `,` - Repeat last f/t motion (opposite direction)

## Tips

1. **Combine Operators with Counts:** `d3w` deletes 3 words, `5dd` deletes 5 lines
2. **Use Text Objects:** More reliable than manual motions (e.g., `ci"` vs `f"lct"`)
3. **Visual Mode for Complex Changes:** Select first, then operate
4. **Practice Text Objects:** They're the key to Vim efficiency
5. **Use `*` for Quick Search:** Place cursor on word, press `*` to search
6. **Combine with Clipboard:** Yanked text goes to system clipboard
7. **Use `.` to Repeat:** Make a change once, repeat with `.`
8. **Block Visual Mode:** Perfect for column editing (`Ctrl-v`)
