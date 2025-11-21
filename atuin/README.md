# Atuin - Zen Shell History

A minimal, calm, and focused shell history configuration for atuin.

## Overview

This configuration provides a zen-like experience for your shell history:
- **Minimal UI**: Clean, distraction-free interface
- **Catppuccin Mocha**: Matching your terminal's aesthetic
- **Flow State**: Smooth interactions and reduced motion
- **Privacy First**: Automatic secret filtering

## Features

### 🎨 Zen Design
- Compact, minimal interface without clutter
- No moving numbers or excessive UI elements
- Search bar at top for natural flow
- Preview without overwhelming context

### 🔍 Smart Search
- Fuzzy search for forgiving queries
- Git workspace-aware filtering
- Global history by default
- Smart command statistics

### 🛡️ Privacy & Security
- Automatic secret detection
- Filter sensitive commands (keys, tokens, passwords)
- Local-only mode (no sync)

### ⌨️ Smooth Interactions
- Immediate command execution on Enter
- Intentional navigation (no accidental exits)
- Reduced motion for calm experience
- Adaptive cursor styles

## Installation

1. **Symlink the configuration:**
   ```bash
   ln -sf ~/.dotfiles/atuin/.config/atuin ~/.config/atuin
   ```

2. **Initialize atuin in your shell:**

   The configuration is already set up in `~/.zshrc`. If you need to add it manually:
   ```bash
   echo 'eval "$(atuin init zsh)"' >> ~/.zshrc
   ```

3. **Reload your shell:**
   ```bash
   source ~/.zshrc
   ```

## Usage

### Basic Commands
- **Ctrl+R**: Search history (fuzzy search)
- **↑**: Navigate up through history
- **Tab**: Copy command to edit
- **Enter**: Execute immediately

### Filter Modes
Press `Ctrl+R` and then use these shortcuts:
- `Ctrl+/`: Toggle filter mode (global, directory, session, workspace)
- `Ctrl+S`: Search mode toggle (fuzzy, prefix, fulltext)

### Advanced Navigation
- **Ctrl+N / Ctrl+P**: Next/Previous item
- **Alt+Up / Alt+Down**: Scroll context
- **Esc**: Exit search (return original)

## Configuration Files

```
atuin/
├── .config/
│   └── atuin/
│       ├── config.toml              # Main zen configuration
│       └── themes/
│           └── catppuccin-mocha.toml  # Custom theme
└── README.md                        # This file
```

## Customization

### Adjust UI Height
Edit `config.toml`:
```toml
inline_height = 12  # Change to your preference (0 for fullscreen)
```

### Enable Sync
If you want to sync across machines:
```toml
auto_sync = true
sync_frequency = "10m"
```

### Change Theme
Built-in themes: `default`, `autumn`, `marine`, `catppuccin-mocha`
```toml
[theme]
name = "autumn"  # or your preferred theme
```

### Add More Ignored Commands
```toml
[stats]
ignored_commands = [
  "ls", "cd", "pwd", "clear", "exit",
  "your_command_here",
]
```

## Philosophy

This configuration follows a zen approach:
- **Less is more**: Minimal UI, maximum focus
- **Flow state**: Smooth interactions without interruptions
- **Intentional**: No accidental actions or surprises
- **Calm**: Reduced motion, soft colors, gentle feedback

## Tips

1. **Use fuzzy search**: Don't remember exact commands? Just type keywords
2. **Workspace filtering**: In git repos, press `Ctrl+/` to filter by project
3. **Preview mode**: Long commands? The preview shows full context
4. **Secret safety**: Atuin automatically filters secrets from history

## Troubleshooting

### Theme not applying
```bash
# Check if theme file exists
ls ~/.config/atuin/themes/catppuccin-mocha.toml

# Test the configuration
atuin search --help
```

### Config not loading
```bash
# Verify symlink
ls -la ~/.config/atuin

# Check if atuin is initialized
which atuin
```

### Reset to defaults
```bash
# Backup current config
cp ~/.config/atuin/config.toml ~/.config/atuin/config.toml.backup

# Use default config
atuin gen-config > ~/.config/atuin/config.toml
```

## Sync with Work Branch

To sync this configuration to your work branch:
```bash
sdf  # or ./sync-dotfiles.zsh
# Select files: atuin/.config/atuin/config.toml
#               atuin/.config/atuin/themes/catppuccin-mocha.toml
```

## Resources

- [Atuin Documentation](https://atuin.sh)
- [Atuin GitHub](https://github.com/atuinsh/atuin)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

---

*Breathe. Focus. Flow.*
