# Editing & Git Integration

**Leader Key:** `<Space>`

## Comments

### Toggle Comments
- `Ctrl-/` or `Ctrl-c` - Toggle line comment (normal mode)
- `Ctrl-/` or `Ctrl-c` - Toggle selected lines (visual mode)

### Default Comment.nvim Bindings
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` - Comment operator (use with motions)

### Examples
- `gcap` - Comment around paragraph
- `gc3j` - Comment 3 lines down
- `gcG` - Comment from cursor to end of file
- `gc$` - Comment from cursor to end of line

---

## Visual Mode Editing

### Entering Visual Mode
- `v` - Character-wise visual mode
- `V` - Line-wise visual mode
- `Ctrl-v` - Block-wise (column) visual mode
- `gv` - Reselect last visual selection

### Visual Mode Operations
- `d` - Delete selection
- `c` - Change selection (delete and enter insert)
- `y` - Yank (copy) selection
- `>` - Indent selection
- `<` - Dedent selection
- `=` - Auto-indent selection
- `U` - Uppercase selection
- `u` - Lowercase selection
- `~` - Toggle case of selection
- `J` - Join selected lines

### Visual Block Mode (Ctrl-v)
Perfect for column editing:

**Insert at Start of Lines:**
1. `Ctrl-v` to enter block mode
2. Select lines with `j/k`
3. `I` to insert at start
4. Type text
5. `Esc` to apply to all lines

**Append at End of Lines:**
1. `Ctrl-v` to enter block mode
2. Select lines with `j/k`
3. `$` to go to end (if needed)
4. `A` to append at end
5. Type text
6. `Esc` to apply to all lines

**Delete Column:**
1. `Ctrl-v` to enter block mode
2. Select column with `j/k` and `h/l`
3. `d` to delete
4. Or `c` to change

---

## Indentation

### Visual Mode
- `>` - Indent selected lines
- `<` - Dedent selected lines
- `=` - Auto-indent selected lines (smart indent)

### Normal Mode
- `>>` - Indent current line
- `<<` - Dedent current line
- `==` - Auto-indent current line
- `>ip` - Indent paragraph
- `<ip` - Dedent paragraph
- `=ip` - Auto-indent paragraph
- `=G` - Auto-indent from cursor to end of file
- `gg=G` - Auto-indent entire file

### Settings
- `:set shiftwidth=4` - Set indent width to 4 spaces
- `:set tabstop=4` - Set tab display width to 4 spaces
- `:set expandtab` - Use spaces instead of tabs
- `:set noexpandtab` - Use tabs instead of spaces

---

## Search & Replace

### Basic Search
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next match
- `N` - Previous match
- `*` - Search forward for word under cursor
- `#` - Search backward for word under cursor
- `Esc` - Clear search highlight (custom binding)

### Replace in Line
- `:s/old/new/` - Replace first occurrence
- `:s/old/new/g` - Replace all in line
- `:s/old/new/gc` - Replace all with confirmation

### Replace in File
- `:%s/old/new/g` - Replace all in file
- `:%s/old/new/gc` - Replace all with confirmation
- `:%s/old/new/gn` - Count matches (don't replace)

### Replace in Range
- `:10,20s/old/new/g` - Replace in lines 10-20
- `:'<,'>s/old/new/g` - Replace in visual selection

### Advanced Patterns
- `:%s/\<word\>/new/g` - Replace whole word only
- `:%s/old/new/gi` - Case-insensitive replace
- `:%s/old/new/gI` - Case-sensitive replace

### Replace with Regex
- `:%s/\d\+/NUMBER/g` - Replace all numbers
- `:%s/^\s\+//g` - Remove leading whitespace
- `:%s/\s\+$//g` - Remove trailing whitespace
- `:%s/\n\n\+/\r\r/g` - Collapse multiple blank lines

### Confirmation Options
When using `/c` flag:
- `y` - Yes, replace
- `n` - No, skip
- `a` - Replace all remaining
- `q` - Quit
- `l` - Replace and quit
- `Ctrl-e` - Scroll down
- `Ctrl-y` - Scroll up

---

## Multi-file Search & Replace

### Using Telescope + Quickfix
1. `<Space>sg` - Search with grep
2. Find what you want to replace
3. `Ctrl-q` - Send results to quickfix
4. `:cdo s/old/new/g | update` - Replace in all files
   - `cdo` - Execute on each file in quickfix
   - `| update` - Save each file

### Using :grep
1. `:grep pattern **/*.js` - Search in all .js files
2. `:copen` - Open quickfix
3. `:cdo s/old/new/g | update` - Replace

### Using :bufdo
Replace in all open buffers:
1. `:bufdo %s/old/new/ge | update`
   - `bufdo` - Execute in all buffers
   - `/e` - Suppress errors
   - `| update` - Save

---

## Git Integration (Gitsigns)

### Signs in Gutter
- `+` - Added line (new line)
- `~` - Changed line (modified)
- `_` - Deleted line (removed)
- `‾` - Top delete
- `~` - Change delete

### Git Commands

#### Blame
- `:Gitsigns blame_line` - Show git blame for current line
  - Shows commit hash, author, date
  - Inline virtual text
- `:Gitsigns toggle_current_line_blame` - Toggle inline blame

#### Hunk Operations
- `:Gitsigns preview_hunk` - Preview changes in floating window
- `:Gitsigns stage_hunk` - Stage current hunk
- `:Gitsigns undo_stage_hunk` - Undo staged hunk
- `:Gitsigns reset_hunk` - Reset hunk to HEAD
- `:Gitsigns stage_buffer` - Stage entire buffer
- `:Gitsigns reset_buffer` - Reset entire buffer

#### Hunk Navigation
- `]c` - Next hunk (may need to configure)
- `[c` - Previous hunk (may need to configure)

#### Diff
- `:Gitsigns diffthis` - Diff against index
- `:Gitsigns diffthis ~1` - Diff against HEAD~1
- `:Gitsigns toggle_deleted` - Show deleted lines

### Visual Mode Git Operations
Select lines in visual mode, then:
- `:Gitsigns stage_hunk` - Stage selected lines
- `:Gitsigns reset_hunk` - Reset selected lines

---

## Text Manipulation

### Join Lines
- `J` - Join next line to current (removes newline)
- `gJ` - Join without adding space
- `3J` - Join next 3 lines

### Case Changes
- `guu` - Lowercase line
- `gUU` - Uppercase line
- `g~~` - Toggle case of line
- `guiw` - Lowercase inner word
- `gUiw` - Uppercase inner word

### Increment/Decrement Numbers
- `Ctrl-a` - Increment number under cursor
- `Ctrl-x` - Decrement number under cursor
- `10Ctrl-a` - Add 10 to number
- `g Ctrl-a` - Increment in visual block (sequential)

### Sorting
- `:sort` - Sort selected lines
- `:sort!` - Reverse sort
- `:sort u` - Sort and remove duplicates
- `:sort n` - Numeric sort

### Filter Through External Command
- `:%!jq` - Format JSON (requires jq)
- `:%!prettier --stdin-filepath %` - Format with Prettier
- `:'<,'>!sort` - Sort selected lines with Unix sort

---

## Whitespace Management

### Show Whitespace
- `:set list` - Show whitespace characters (already on)
  - `»` - Tab
  - `·` - Trailing space
  - `␣` - Non-breaking space

### Remove Trailing Whitespace
- `:%s/\s\+$//g` - Remove from entire file
- `:'<,'>s/\s\+$//g` - Remove from selection

### Convert Tabs/Spaces
- `:retab` - Convert tabs to spaces (or vice versa)
- `:set expandtab` - Use spaces
- `:set noexpandtab` - Use tabs

---

## Spell Checking

### Enable Spell Check
- `:set spell` - Enable spell checking
- `:set nospell` - Disable spell checking
- `:set spelllang=en_us` - Set language

### Navigation
- `]s` - Next misspelled word
- `[s` - Previous misspelled word
- `]S` - Next misspelled word (skip rare words)
- `[S` - Previous misspelled word (skip rare words)

### Corrections
- `z=` - Suggest corrections
- `1z=` - Use first suggestion
- `zg` - Add word to dictionary (good word)
- `zw` - Mark word as incorrect (wrong word)
- `zug` - Undo add to dictionary
- `zuw` - Undo mark as incorrect

---

## Folding

### Manual Folding
- `zf` - Create fold (with motion or visual)
- `zfip` - Fold paragraph
- `zf}` - Fold to next paragraph

### Opening/Closing Folds
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `za` - Toggle fold under cursor
- `zO` - Open all folds under cursor recursively
- `zC` - Close all folds under cursor recursively
- `zA` - Toggle all folds under cursor recursively

### All Folds
- `zR` - Open all folds
- `zM` - Close all folds

### Navigation
- `zj` - Move to next fold
- `zk` - Move to previous fold

### Fold Methods
- `:set foldmethod=indent` - Fold by indentation
- `:set foldmethod=syntax` - Fold by syntax
- `:set foldmethod=marker` - Fold by markers
- `:set foldmethod=manual` - Manual folding

---

## Registers

### Using Registers
- `"ayy` - Yank line to register 'a'
- `"ap` - Paste from register 'a'
- `"Ayy` - Append line to register 'a' (uppercase)
- `:registers` or `:reg` - View all registers

### Special Registers
- `"` - Unnamed register (default)
- `0` - Last yank
- `1-9` - Delete history (1 is most recent)
- `-` - Small delete (less than one line)
- `+` - System clipboard
- `*` - Primary selection (X11)
- `%` - Current filename
- `#` - Alternate filename
- `/` - Last search pattern
- `:` - Last command
- `.` - Last inserted text
- `_` - Black hole register (delete without saving)

### Examples
- `"+yy` - Copy line to system clipboard
- `"+p` - Paste from system clipboard
- `"_dd` - Delete line without affecting registers
- `"0p` - Paste last yank (not delete)

---

## Tips & Workflows

### Quick File Formatting
1. `gg=G` - Auto-indent entire file
2. `:%s/\s\+$//g` - Remove trailing whitespace
3. Or use LSP formatter: `<Space>ca` → Format

### Multi-line Editing
1. `Ctrl-v` to enter block mode
2. Select lines with `j`
3. `I` to insert at start or `A` to append at end
4. Type text
5. `Esc` to apply

### Git Workflow
1. Make changes
2. `:Gitsigns preview_hunk` to review
3. `:Gitsigns stage_hunk` to stage good changes
4. Use external tool to commit

### Find & Replace Across Project
1. `<Space>sg` to search term
2. `Ctrl-q` to send to quickfix
3. `:cdo s/old/new/g | update` to replace all

### Comment Out Block
1. `Ctrl-v` to select column
2. Select lines with `j`
3. `I` then type `//` (or comment chars)
4. `Esc` to apply

### Check Spelling
1. `:set spell` to enable
2. `]s` to navigate to errors
3. `z=` to see suggestions
4. `1z=` to accept first suggestion
