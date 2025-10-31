# Python Development Guide

**Leader Key:** `<Space>`

## Overview

Your Neovim setup now includes comprehensive Python development tools:
- **Virtual Environment Management** (venv-selector)
- **Debugging** (nvim-dap-python)
- **Testing** (neotest)
- **Docstring Generation** (neogen)
- **PEP 8 Indentation**
- **LSP Support** (pylsp + ruff)

---

## Virtual Environment Management

### VenvSelector

Automatically detect and switch between Python virtual environments.

#### Selecting a Virtual Environment
- `<Space>vs` - **[V]env [S]elect** - Choose from available virtual environments
- `<Space>vc` - **[V]env Select [C]ached** - Use previously selected venv

#### Supported Virtual Environment Locations
The plugin automatically searches for:
- `.venv` (project root)
- `venv` (project root)
- `env`, `.env` (project root)
- `~/.virtualenvs` (global virtualenvs)
- `~/.pyenv/versions` (pyenv installations)

#### Features
- ✅ Auto-refresh when virtual environments change
- ✅ Telescope integration for fuzzy finding
- ✅ Notification when switching environments
- ✅ Integration with LSP and DAP

#### Workflow
1. Open a Python project
2. `<Space>vs` to select virtual environment
3. Choose from the list
4. LSP and debugger automatically use the selected venv

---

## Debugging (DAP)

### Debug Adapter Protocol

Full debugging support for Python with visual debugging UI.

#### Core Debugging Commands
- `<Space>db` - **[D]ebug toggle [B]reakpoint** - Set/remove breakpoint
- `<Space>dc` - **[D]ebug [C]ontinue** - Start/continue debugging
- `<Space>dt` - **[D]ebug [T]erminate** - Stop debugging
- `<Space>du` - **[D]ebug toggle [U]I** - Show/hide debug UI

#### Stepping Through Code
- `<Space>di` - **[D]ebug step [I]nto** - Step into function
- `<Space>do` - **[D]ebug step [O]ver** - Step over line
- `<Space>dO` - **[D]ebug step [O]ut** - Step out of function

#### Advanced Debug Commands
- `<Space>dr` - **[D]ebug toggle [R]EPL** - Open debug REPL
- `<Space>dl` - **[D]ebug run [L]ast** - Rerun last debug session

#### Python-Specific Debug
- `<Space>dn` - **[D]ebug [N]earest test method** - Debug test under cursor
- `<Space>df` - **[D]ebug test [F]ile/class** - Debug entire test file
- `<Space>ds` - **[D]ebug [S]election** (visual mode) - Debug selected code

#### Breakpoint Signs
- 🔴 - Regular breakpoint
- 🟡 - Conditional breakpoint
- 📝 - Log point
- 👉 - Current execution point
- ❌ - Rejected breakpoint

#### Debug Workflow
1. Open a Python file
2. `<Space>db` on line to set breakpoint (🔴 appears)
3. `<Space>dc` to start debugging
4. Debug UI opens automatically
5. Use `<Space>di/do/dO` to step through code
6. `<Space>dt` to stop debugging

#### Debug UI Windows
When debugging starts, you'll see:
- **Scopes** - Variables in current scope
- **Breakpoints** - All breakpoints
- **Stacks** - Call stack
- **Console** - Debug output
- **Watches** - Custom watch expressions

---

## Testing (Neotest)

### Python Test Runner

Run and debug Python tests directly in Neovim with visual feedback.

#### Test Commands
- `<Space>tn` - **[T]est [N]earest** - Run test under cursor
- `<Space>tf` - **[T]est [F]ile** - Run all tests in current file
- `<Space>td` - **[T]est [D]ebug nearest** - Debug test under cursor

#### Test Management
- `<Space>ts` - **[T]est [S]ummary** - Toggle test summary window
- `<Space>to` - **[T]est [O]utput** - Show test output
- `<Space>tO` - **[T]est [O]utput panel** - Toggle output panel
- `<Space>tS` - **[T]est [S]top** - Stop running tests

#### Supported Test Frameworks
- **pytest** (default and recommended)
- Configured with verbose output and debug logging

#### Test Workflow
1. Write tests using pytest
2. Place cursor on test function
3. `<Space>tn` to run test
4. See results inline with ✅/❌ symbols
5. `<Space>to` to see detailed output
6. `<Space>td` to debug failing tests

#### Visual Feedback
- ✅ - Test passed
- ❌ - Test failed
- 🔄 - Test running
- ⏭️ - Test skipped

---

## Docstring Generation (Neogen)

### Auto-generate Docstrings

Automatically create Google-style docstrings for functions and classes.

#### Command
- `<Space>ng` - **[N]eogen [G]enerate docstring**

#### Supported Styles
- **Google** (default) - Google-style docstrings
- NumPy - NumPy-style docstrings
- reST - reStructuredText docstrings

#### Workflow
1. Place cursor on function/class definition
2. `<Space>ng`
3. Docstring template appears
4. Fill in descriptions

#### Example

**Before:**
```python
def calculate_total(items, tax_rate):
    return sum(items) * (1 + tax_rate)
```

**After** (`<Space>ng`):
```python
def calculate_total(items, tax_rate):
    """[Brief description]

    Args:
        items: [description]
        tax_rate: [description]

    Returns:
        [description]
    """
    return sum(items) * (1 + tax_rate)
```

---

## LSP Integration

### Python Language Servers

Your setup includes two complementary language servers:

#### pylsp (Python LSP Server)
- Code completion
- Go to definition
- Find references
- Hover documentation
- Signature help

#### ruff (Fast Linter)
- Fast linting
- Auto-formatting
- Import sorting
- PEP 8 compliance

### LSP Commands (from main LSP config)
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show documentation
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code actions (fix imports, organize, etc.)
- `<Space>ds` - Document symbols
- `<Space>sd` - Search diagnostics

---

## Code Formatting

### PEP 8 Indentation

Automatic PEP 8 compliant indentation for Python files.

#### Features
- ✅ Correct indentation for function arguments
- ✅ Proper list/dict formatting
- ✅ Multi-line statement handling
- ✅ Hanging indents

#### Auto-formatting
Use LSP code actions:
1. `<Space>ca` - Open code actions
2. Select "Format Document" or "Organize Imports"

---

## Common Workflows

### Setting Up a New Python Project

1. **Create virtual environment:**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # or .venv\Scripts\activate on Windows
   pip install -r requirements.txt
   ```

2. **Open project in Neovim:**
   ```bash
   nvim
   ```

3. **Select virtual environment:**
   - `<Space>vs`
   - Choose `.venv` from list

4. **Verify LSP is running:**
   - `:LspInfo`
   - Should show pylsp and ruff attached

### Debugging a Python Script

1. Open your Python file
2. Set breakpoint: `<Space>db` on desired line
3. Start debugging: `<Space>dc`
4. Debug UI appears automatically
5. Step through: `<Space>di` (into) or `<Space>do` (over)
6. Inspect variables in Scopes window
7. Stop: `<Space>dt`

### Running Tests

1. Write tests using pytest:
   ```python
   def test_something():
       assert 1 + 1 == 2
   ```

2. Run test: `<Space>tn` (cursor on test)
3. See results inline
4. Debug if fails: `<Space>td`
5. View summary: `<Space>ts`

### Adding Docstrings

1. Write function:
   ```python
   def process_data(data, options):
       return processed
   ```

2. Cursor on function line
3. Generate docstring: `<Space>ng`
4. Fill in descriptions
5. Tab through fields

### Formatting Code

1. Write Python code
2. `<Space>ca` - Code actions
3. Select:
   - "Format Document" - Format entire file
   - "Organize Imports" - Sort and clean imports
4. Or let it format on save (if configured)

---

## Installation & Setup

### Required Python Packages

For full functionality, install these in your virtual environment:

```bash
# LSP servers (install globally or in venv)
pip install python-lsp-server
pip install ruff

# Debugging
pip install debugpy

# Testing
pip install pytest

# Optional but recommended
pip install pytest-asyncio  # For async tests
pip install pytest-cov      # Coverage reports
pip install black           # Code formatter
pip install isort           # Import sorter
```

### First Time Setup

1. **Open Neovim:**
   ```bash
   nvim
   ```

2. **Let plugins install:**
   - `:Lazy sync`
   - Wait for all plugins to install

3. **Install LSP servers:**
   - `:Mason`
   - Search and install: `pylsp`, `ruff`

4. **Verify setup:**
   - Open a Python file
   - Run `:checkhealth`
   - Check `nvim-dap-python`, `neotest`, LSP sections

---

## Troubleshooting

### Virtual Environment Not Detected

**Issue:** `<Space>vs` shows no environments

**Solutions:**
1. Ensure venv exists in project root
2. Create one: `python -m venv .venv`
3. Restart Neovim
4. Check search paths in plugin config

### LSP Not Working

**Issue:** No completions or diagnostics

**Solutions:**
1. Check LSP status: `:LspInfo`
2. Install servers: `:Mason` → install `pylsp`, `ruff`
3. Select venv: `<Space>vs`
4. Restart LSP: `:LspRestart`

### Debugger Not Starting

**Issue:** Breakpoints don't work

**Solutions:**
1. Install debugpy: `pip install debugpy`
2. Select correct venv: `<Space>vs`
3. Check Python path: `:echo exepath('python3')`
4. Verify DAP config: `:lua print(vim.inspect(require('dap').configurations.python))`

### Tests Not Running

**Issue:** `<Space>tn` does nothing

**Solutions:**
1. Install pytest: `pip install pytest`
2. Ensure test file starts with `test_` or ends with `_test.py`
3. Test functions must start with `test_`
4. Check neotest status: `:Neotest summary`

---

## Tips & Best Practices

1. **Always use virtual environments** - Keep project dependencies isolated
2. **Select venv first** - Do this when opening any Python project
3. **Use `<Space>td` for debugging tests** - Much faster than print debugging
4. **Generate docstrings early** - Easier than adding them later
5. **Check test summary** - `<Space>ts` gives overview of all tests
6. **Use code actions** - `<Space>ca` for quick fixes and formatting
7. **Watch variables while debugging** - Use the Watches window in debug UI
8. **Run single tests** - `<Space>tn` is faster than running entire suite

---

## Quick Reference

### Most Used Commands

```
<Space>vs    Select virtual environment
<Space>db    Toggle breakpoint
<Space>dc    Start/continue debugging
<Space>tn    Run nearest test
<Space>tf    Run file tests
<Space>ng    Generate docstring
<Space>ca    Code actions (format, imports)
gd           Go to definition
K            Show documentation
```

### Testing Workflow
```
1. <Space>tn  - Run test
2. <Space>td  - Debug test if fails
3. <Space>to  - See output
4. <Space>ts  - View summary
```

### Debugging Workflow
```
1. <Space>db  - Set breakpoint
2. <Space>dc  - Start debug
3. <Space>di  - Step into
4. <Space>do  - Step over
5. <Space>dt  - Stop
```

---

**Happy Python coding! 🐍**
