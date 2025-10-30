# LSP & Code Intelligence

**Leader Key:** `<Space>`

## Code Navigation

### Go To Definition
- `gd` - **[G]oto [D]efinition**
  - Jump to where symbol is defined
  - Opens in Telescope picker if multiple definitions
  - Press `Ctrl-t` to jump back

- `gD` - **[G]oto [D]eclaration**
  - Jump to declaration (e.g., C header file)
  - Different from definition in some languages

### Find References
- `gr` - **[G]oto [R]eferences**
  - Find all references to symbol
  - Opens in Telescope picker
  - Shows file and line context
  - Useful for understanding usage

### Implementation & Type
- `gI` - **[G]oto [I]mplementation**
  - Jump to implementation of interface
  - Useful in OOP languages
  - Skips interface definitions

- `<Space>D` - **Type [D]efinition**
  - Jump to type definition of symbol
  - See the definition of the type itself
  - Different from where variable is defined

### Jump Stack
- `Ctrl-t` - Jump back (after goto definition)
- `Ctrl-o` - Jump to older position in jump list
- `Ctrl-i` - Jump to newer position in jump list
- `:jumps` - Show jump list

---

## Symbols

### Document Symbols
- `<Space>ds` - **[D]ocument [S]ymbols**
  - List all symbols in current file
  - Functions, classes, variables, etc.
  - Fuzzy searchable
  - Quick navigation within file

### Workspace Symbols
- `<Space>ws` - **[W]orkspace [S]ymbols**
  - Search symbols across entire project
  - Find functions/classes anywhere
  - Dynamic search as you type
  - Useful for large codebases

---

## Documentation

### Hover Information
- `K` - Show hover documentation
  - Shows type information
  - Function signatures
  - Documentation strings
  - Press `K` twice to enter documentation window
  - Use `q` to close documentation

### Signature Help
- `Ctrl-k` - Show signature help (in insert mode)
  - Shows function parameters
  - Highlights current parameter
  - Updates as you type

---

## Code Actions & Refactoring

### Rename Symbol
- `<Space>rn` - **[R]e[n]ame**
  - Rename symbol across entire project
  - Updates all references
  - LSP-powered (language-aware)
  - Shows preview before applying

### Code Actions
- `<Space>ca` - **[C]ode [A]ction**
  - Shows available quick fixes
  - Refactoring options
  - Import management
  - Auto-fix issues
  - Works in normal and visual mode

**Common Code Actions:**
- Add missing imports
- Remove unused variables
- Extract to function/variable
- Inline variable
- Generate constructors
- Implement interface methods
- Auto-fix linting errors

---

## Diagnostics

### Status Bar Display
The status bar (lualine) shows diagnostic counts:
- Error count with `` icon
- Warning count with `` icon
- Info count with `` icon
- Hint count with `` icon

### Viewing Diagnostics

#### Trouble.nvim - Diagnostic Panel
- `<Space>xx` - **Toggle Trouble diagnostics panel** (workspace-wide)
  - Shows all diagnostics in a dedicated window
  - Navigate without scrolling through code
  - Auto-updates as you fix issues

- `<Space>xX` - **Toggle buffer diagnostics only**
  - Shows diagnostics for current file only
  - Focused view for current work

- `<Space>xf` - **Focus trouble panel**
  - Switch focus to trouble window
  - Navigate diagnostics with `j/k`

- `<Space>xb` - **Focus back to buffer**
  - Return focus to code editor
  - Quick toggle between views

#### Inside Trouble Panel
- `j` / `k` - Navigate between diagnostics
- `<CR>` or `<Tab>` - Jump to diagnostic location
- `o` - Jump to diagnostic and close panel
- `q` or `<Esc>` - Close panel
- `K` - Show full diagnostic message
- `p` - Preview location
- `m` - Toggle between workspace/document mode
- `r` - Refresh diagnostics

#### Other Diagnostic Views
- `<Space>sd` - **[S]earch [D]iagnostics** (Telescope)
  - View all diagnostics in project
  - Fuzzy searchable
  - Jump directly to issues

- `<Space>q` - **Open Diagnostic [Q]uickfix List**
  - Opens quickfix window
  - Navigate with `:cnext` / `:cprev`
  - Useful for fixing issues sequentially

- `<Space>cs` - **Show symbols in Trouble**
  - Document outline in trouble panel

- `<Space>cl` - **LSP definitions/references in Trouble**
  - Shows LSP information in trouble format

- `<Space>xL` - **Location list in Trouble**
- `<Space>xQ` - **Quickfix list in Trouble**

### Diagnostic Navigation (Without Panel)
- `]d` - **Go to next diagnostic**
  - Jump directly to next error/warning
  - Works without opening panel
  - Fast navigation through issues

- `[d` - **Go to previous diagnostic**
  - Jump to previous error/warning
  - Backward navigation

- `<Space>e` - **Show diagnostic [E]rror in floating window**
  - Shows full diagnostic message at cursor
  - No need to open panel
  - Useful for quick checks

### Diagnostic Levels
- **Error** () - Code won't compile/run
- **Warning** () - Potential issues
- **Info** () - Informational messages
- **Hint** () - Code improvements

### Signs in Gutter
Look for signs in the left column:
- `` - Error
- `` - Warning
- `` - Info
- `` - Hint

---

## Formatting & Linting

### Auto-Format
Most LSP servers provide formatting via code actions:
- `<Space>ca` - Open code actions, select "Format Document"

Or use none-ls for formatting:
- Configured formatters run on save (if enabled)
- Manual format with LSP: `:lua vim.lsp.buf.format()`

### Configured Formatters (via none-ls)
- **stylua** - Lua formatting
- Additional formatters per language server

---

## LSP Features by Language

### TypeScript/JavaScript (ts_ls)
- Full IntelliSense
- Auto imports
- Refactoring (extract, inline, etc.)
- Unused code detection
- Type checking

### Python (pylsp + ruff)
- **pylsp**: Code completion, go-to-definition
- **ruff**: Fast linting and formatting
- Type hints support
- Import sorting

### Lua (lua_ls)
- Neovim API completion
- Type annotations
- Workspace library support
- Configured for Neovim development

### Web (HTML, CSS, Tailwind)
- **html**: HTML completion and validation
- **cssls**: CSS completion and validation
- **tailwindcss**: Tailwind class completion and hints

### Data Formats
- **jsonls**: JSON schema validation
- **yamlls**: YAML validation
- **sqlls**: SQL completion

---

## Inlay Hints

- `<Space>th` - **[T]oggle Inlay [H]ints**
  - Shows type information inline
  - Parameter names in function calls
  - Variable types
  - Return types
  - May be distracting for some

---

## Mason - LSP Installer

### Opening Mason
- `:Mason` - Open Mason UI
  - Browse available LSP servers
  - Install/uninstall servers
  - Update servers

### Mason UI Navigation
- `g?` - Show help
- `i` - Install package
- `u` - Update package
- `U` - Update all packages
- `X` - Uninstall package
- `c` - Check for updates
- `/` - Filter packages
- `q` - Close

### Installed Language Servers
- `ts_ls` - TypeScript/JavaScript
- `lua_ls` - Lua
- `html` - HTML
- `cssls` - CSS
- `tailwindcss` - Tailwind CSS
- `jsonls` - JSON
- `yamlls` - YAML
- `sqlls` - SQL
- `pylsp` - Python
- `ruff` - Python linter/formatter
- `stylua` - Lua formatter

### Adding New LSP Servers
1. `:Mason` - Open Mason
2. Search for server
3. Press `i` to install
4. Add to `servers` table in `lua/plugins/lsp.lua`
5. Restart Neovim or `:Lazy reload nvim-lspconfig`

---

## Language-Specific Plugins

### Angular
- Template completion
- Component navigation
- TypeScript integration
- File: `lua/plugins/angular.lua`

### Go
- Go tooling integration
- File: `lua/plugins/go.lua`

### Rust
- rust-analyzer integration
- File: `lua/plugins/rust.lua`

### Zig
- Zig language support
- File: `lua/plugins/zig.lua`

---

## Autocompletion (nvim-cmp)

### Basic Completion
- `Ctrl-Space` - Manually trigger completion
- Completion appears automatically while typing

### Navigating Suggestions
- `Ctrl-n` - Next suggestion
- `Ctrl-p` - Previous suggestion
- `Tab` - Next suggestion (also jumps in snippets)
- `Shift-Tab` - Previous suggestion

### Accepting Completion
- `Ctrl-y` - **[Y]es**, accept completion
- `Enter` - Can be configured to accept
- `Ctrl-e` - Cancel completion

### Documentation
- `Ctrl-b` - Scroll documentation up
- `Ctrl-f` - Scroll documentation down

### Snippets
- `Ctrl-l` - Jump to next snippet field
- `Ctrl-h` - Jump to previous snippet field
- `Tab` - Jump forward (in snippet)
- `Shift-Tab` - Jump backward (in snippet)

### Completion Sources
Shown in brackets after suggestion:
- `[LSP]` - From language server
- `[Snippet]` - Code snippets
- `[Buffer]` - Words from current buffer
- `[Path]` - File system paths

### Completion Icons
- 󰉿 Text
- m Method
- 󰊕 Function
-  Constructor
-  Field
- 󰆧 Variable
- 󰌗 Class
-  Interface
-  Module
-  Property
- 󰎠 Value
-  Enum
- 󰌋 Keyword
-  Snippet
- 󰈙 File
- 󰉋 Folder

---

## GitHub Copilot

Configured via `lua/plugins/copilot.lua`

### Copilot Commands
- `:Copilot setup` - Initial setup
- `:Copilot enable` - Enable Copilot
- `:Copilot disable` - Disable Copilot
- `:Copilot status` - Check status

### Accepting Suggestions
Check plugin configuration for specific keybindings.

---

## Treesitter - Syntax Highlighting

### Features
- Enhanced syntax highlighting
- Code folding
- Incremental selection
- Language-aware motions

### Treesitter Commands
- `:TSUpdate` - Update parsers
- `:TSInstall <language>` - Install parser
- `:TSInstallInfo` - Show installed parsers
- `:TSBufEnable highlight` - Enable highlighting

---

## Quickfix & Location Lists

### Quickfix List
- `:copen` - Open quickfix window
- `:cclose` - Close quickfix window
- `:cnext` / `:cn` - Next item
- `:cprev` / `:cp` - Previous item
- `:cfirst` - First item
- `:clast` - Last item
- `:cdo <cmd>` - Execute command on each item

### Location List
Similar to quickfix but window-local:
- `:lopen` - Open location list
- `:lclose` - Close location list
- `:lnext` / `:ln` - Next item
- `:lprev` / `:lp` - Previous item

---

## Tips & Workflows

### Rename Across Project
1. Place cursor on symbol
2. `<Space>rn` to rename
3. Type new name
4. Enter to confirm

### Find All Uses of Function
1. Place cursor on function
2. `gr` for references
3. Navigate with `Ctrl-j/k`
4. `<CR>` to jump to usage

### Fix All Errors in File

**Method 1: Using Trouble Panel**
1. `<Space>xx` to open trouble diagnostics
2. Navigate with `j/k` to browse errors
3. `<CR>` to jump to error location
4. `<Space>ca` for code actions to fix
5. Continue fixing, trouble auto-updates

**Method 2: Quick Navigation**
1. `]d` to jump to next diagnostic
2. `<Space>e` to see full error message
3. `<Space>ca` for code actions
4. `]d` to move to next error
5. Repeat until no more diagnostics

**Method 3: Telescope Search**
1. `<Space>sd` to see all diagnostics
2. Fuzzy search for specific errors
3. `<CR>` to jump to location
4. Fix and repeat

### Explore Unknown Code
1. `<Space>ds` to see file structure
2. `gd` to jump to definitions
3. `K` to read documentation
4. `gr` to see how it's used
5. `Ctrl-t` to jump back

### Quick Documentation Lookup
1. Hover over symbol
2. `K` to show docs
3. `K` again to enter doc window
4. Navigate with `j/k`
5. `q` to close

### Auto-Import Missing Symbol
1. Notice error about missing import
2. `<Space>ca` for code actions
3. Select "Add import" or "Auto import"
4. Done!
