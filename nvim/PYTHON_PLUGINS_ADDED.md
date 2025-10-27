# Python Plugins Added ✅

## Overview

I've added comprehensive Python development tools to your Neovim setup!

## New Plugins Installed

### 1. 🐍 **venv-selector.nvim**
**Virtual Environment Management**

- Automatically detect Python virtual environments
- Switch between venvs with Telescope integration
- Auto-refresh when environments change
- Searches: `.venv`, `venv`, `~/.virtualenvs`, `~/.pyenv/versions`

**Keybindings:**
- `<Space>vs` - Select virtual environment
- `<Space>vc` - Select cached virtual environment

---

### 2. 🐛 **nvim-dap + nvim-dap-python**
**Full Python Debugging**

- Visual debugging with breakpoints
- Step through code (into, over, out)
- Inspect variables in real-time
- Debug REPL
- Auto-open debug UI

**Keybindings:**
- `<Space>db` - Toggle breakpoint (🔴)
- `<Space>dc` - Start/continue debugging
- `<Space>di` - Step into
- `<Space>do` - Step over
- `<Space>dO` - Step out
- `<Space>dr` - Toggle debug REPL
- `<Space>dt` - Terminate debugging
- `<Space>du` - Toggle debug UI
- `<Space>dn` - Debug nearest test method
- `<Space>df` - Debug test file/class
- `<Space>ds` - Debug selection (visual mode)

---

### 3. 🧪 **neotest + neotest-python**
**Advanced Test Runner**

- Run tests directly in Neovim
- Visual feedback (✅/❌) inline
- Test summary window
- Debug tests with one command
- Supports pytest (configured by default)

**Keybindings:**
- `<Space>tn` - Run nearest test
- `<Space>tf` - Run all tests in file
- `<Space>td` - Debug nearest test
- `<Space>ts` - Toggle test summary
- `<Space>to` - Show test output
- `<Space>tO` - Toggle output panel
- `<Space>tS` - Stop running tests

---

### 4. 📝 **neogen**
**Docstring Generator**

- Auto-generate Google-style docstrings
- Works for functions, classes, methods
- Tab through fields to fill in

**Keybinding:**
- `<Space>ng` - Generate docstring

---

### 5. 📐 **vim-python-pep8-indent**
**PEP 8 Indentation**

- Automatic PEP 8 compliant indentation
- Proper function argument formatting
- Multi-line statement handling
- No configuration needed - just works!

---

### 6. 🎨 **nvim-dap-ui**
**Debug UI**

- Beautiful debug interface
- Shows: scopes, breakpoints, call stack, console
- Auto-opens when debugging starts
- Auto-closes when debugging stops

---

## What You Need to Do

### 1. Sync Plugins

Open Neovim and sync:
```bash
nvim
# Inside Neovim:
:Lazy sync
```

Wait for all plugins to install (about 1-2 minutes).

### 2. Install Python Packages

Install required Python tools:

```bash
# LSP servers (recommended globally)
pip install python-lsp-server ruff

# Debugging
pip install debugpy

# Testing
pip install pytest

# Optional but recommended
pip install black isort pytest-cov
```

### 3. Install LSP Servers via Mason

Open Neovim:
```vim
:Mason
```

Search and install:
- `pylsp` (Python LSP Server)
- `ruff` (Python linter/formatter)

They should already be configured from your main lsp.lua!

---

## Quick Start Guide

### Setting Up a Python Project

1. **Create virtual environment:**
   ```bash
   cd your-project
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

2. **Open in Neovim:**
   ```bash
   nvim
   ```

3. **Select virtual environment:**
   - Press `<Space>vs`
   - Choose `.venv` from the list
   - ✅ LSP and debugger now use this venv!

### Running Tests

1. Write a test:
   ```python
   # test_example.py
   def test_addition():
       assert 1 + 1 == 2
   ```

2. Place cursor on test function
3. Press `<Space>tn` to run
4. See ✅ or ❌ inline
5. If it fails, press `<Space>td` to debug!

### Debugging Code

1. Open your Python file
2. Press `<Space>db` on a line to set breakpoint (🔴 appears)
3. Press `<Space>dc` to start debugging
4. Debug UI opens automatically
5. Use `<Space>di` to step into, `<Space>do` to step over
6. Inspect variables in the Scopes window
7. Press `<Space>dt` to stop

### Generating Docstrings

1. Write a function:
   ```python
   def calculate_total(items, tax_rate):
       return sum(items) * (1 + tax_rate)
   ```

2. Place cursor on function definition
3. Press `<Space>ng`
4. Docstring template appears:
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

## Common Workflows

### Workflow 1: Test-Driven Development
```
1. Write test               → test_feature.py
2. <Space>tn                → Run test (fails ❌)
3. Write implementation     → feature.py
4. <Space>tn                → Run test (passes ✅)
5. <Space>ng                → Add docstring
6. <Space>ca                → Format code
```

### Workflow 2: Debugging a Bug
```
1. <Space>vs                → Select venv
2. <Space>db                → Set breakpoint where bug occurs
3. <Space>dc                → Start debugging
4. <Space>di/do             → Step through code
5. Inspect variables        → Check Scopes window
6. Fix bug
7. <Space>tn                → Run tests to verify
```

### Workflow 3: New Feature
```
1. <Space>vs                → Select venv
2. Write function
3. <Space>ng                → Generate docstring
4. Write tests
5. <Space>tf                → Run all tests
6. <Space>ca                → Format & organize imports
```

---

## Keybinding Summary

### Virtual Environment
| Key          | Action                    |
|--------------|---------------------------|
| `<Space>vs`  | Select venv               |
| `<Space>vc`  | Select cached venv        |

### Debugging
| Key          | Action                    |
|--------------|---------------------------|
| `<Space>db`  | Toggle breakpoint         |
| `<Space>dc`  | Start/continue            |
| `<Space>di`  | Step into                 |
| `<Space>do`  | Step over                 |
| `<Space>dO`  | Step out                  |
| `<Space>dt`  | Terminate                 |
| `<Space>du`  | Toggle UI                 |

### Testing
| Key          | Action                    |
|--------------|---------------------------|
| `<Space>tn`  | Run nearest test          |
| `<Space>tf`  | Run file tests            |
| `<Space>td`  | Debug nearest test        |
| `<Space>ts`  | Toggle summary            |
| `<Space>to`  | Show output               |

### Documentation
| Key          | Action                    |
|--------------|---------------------------|
| `<Space>ng`  | Generate docstring        |

---

## Documentation

Full documentation available at:
- **`nvim/docs/06-python-development.md`** - Complete Python guide
- **`nvim/docs/README.md`** - Updated with Python section

---

## Troubleshooting

### "No virtual environments found"
- Create one: `python -m venv .venv`
- Restart Neovim
- Run `<Space>vs` again

### "LSP not working"
1. Check: `:LspInfo`
2. Install: `:Mason` → install `pylsp` and `ruff`
3. Select venv: `<Space>vs`
4. Restart LSP: `:LspRestart`

### "Debugger not starting"
1. Install: `pip install debugpy`
2. Select venv: `<Space>vs`
3. Verify: `:checkhealth nvim-dap-python`

### "Tests not running"
1. Install: `pip install pytest`
2. Ensure test file starts with `test_` or ends with `_test.py`
3. Test functions must start with `test_`

---

## What's Already Configured

From your existing setup, Python already has:
- ✅ **pylsp** - Python Language Server
- ✅ **ruff** - Fast linting and formatting
- ✅ LSP keybindings (`gd`, `gr`, `K`, `<Space>ca`, etc.)
- ✅ Autocompletion with nvim-cmp
- ✅ Syntax highlighting with treesitter

## What We Added

- ✅ Virtual environment management
- ✅ Full debugging capabilities
- ✅ Test runner with visual feedback
- ✅ Docstring generation
- ✅ PEP 8 indentation

---

**Your Neovim is now a full-featured Python IDE! 🚀🐍**

Next steps:
1. Run `:Lazy sync` to install plugins
2. Install Python packages: `pip install debugpy pytest`
3. Try it out: `<Space>vs` to select a venv!
