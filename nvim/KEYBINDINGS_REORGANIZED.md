# Keybindings Reorganized ✅

## New Organization

Your Telescope keybindings are now logically organized into two clear namespaces:

---

## 📁 FIND Namespace (`<Space>f`)

**Purpose:** Find files, buffers, UI elements (by name/location)

### Files

| Key         | Command       | Description                   |
| ----------- | ------------- | ----------------------------- |
| `<Space>ff` | Find Files    | Find files by name in project |
| `<Space>fr` | Find Recent   | Recently opened files         |
| `<Space>fs` | Find Siblings | Files in same directory       |

### Git Files

| Key         | Command        | Description                 |
| ----------- | -------------- | --------------------------- |
| `<Space>fg` | Find Git files | All files tracked by git    |
| `<Space>fm` | Find Modified  | Git modified files (status) |
| `<Space>fc` | Find Changed   | Git changed files only      |

### Buffers & UI

| Key         | Command        | Description        |
| ----------- | -------------- | ------------------ |
| `<Space>fb` | Find Buffers   | Open buffers       |
| `<Space>fh` | Find Help      | Neovim help topics |
| `<Space>fk` | Find Keymaps   | All keybindings    |
| `<Space>ft` | Find Telescope | Telescope pickers  |

---

## 🔍 SEARCH Namespace (`<Space>s`)

**Purpose:** Search content inside files (text/code)

### Content Search

| Key         | Command            | Description                   |
| ----------- | ------------------ | ----------------------------- |
| `<Space>sg` | Search Grep        | **Live grep in all files** ⭐ |
| `<Space>sw` | Search Word        | Search word under cursor      |
| `<Space>sd` | Search Diagnostics | LSP errors/warnings           |
| `<Space>sr` | Search Resume      | Resume last search            |

### Context Search

| Key         | Command       | Description               |
| ----------- | ------------- | ------------------------- |
| `<Space>sb` | Search Buffer | Search in current buffer  |
| `<Space>so` | Search Open   | Search in open files only |

---

## 🎯 Quick Access (Legacy)

These are kept for convenience:

| Key              | Command       | Description                    |
| ---------------- | ------------- | ------------------------------ |
| `<Space><Space>` | Buffers       | Quick buffer switcher          |
| `<Space>/`       | Buffer search | Quick search in current buffer |

---

## 🧠 Memory Aid

### Think of it this way:

**`<Space>f`** = **"Where is it?"** (Finding things by location/name)

- Files, buffers, recent files, git files, help topics

**`<Space>s`** = **"What does it say?"** (Searching content)

- Grep, word search, diagnostics, text inside files

---

## 📊 Comparison: Before vs After

### Before (Inconsistent)

```
<Space>ff  - Find files        ← Find namespace
<Space>fs  - Find siblings     ← Find namespace
<Space>fm  - Find modified     ← Find namespace
<Space>fc  - Find changed      ← Find namespace

<Space>sg  - Search grep       ← Search namespace
<Space>sw  - Search word       ← Search namespace
<Space>sd  - Search diag       ← Search namespace
<Space>sk  - Search keymaps    ← Should be Find!
<Space>ss  - Search telescope  ← Should be Find!
<Space>s.  - Search recent     ← Should be Find!

<Space>h   - Find help         ← Inconsistent!
```

### After (Consistent)

```
FIND (<Space>f) - Files, Buffers, UI:
  <Space>ff  - Files
  <Space>fb  - Buffers
  <Space>fr  - Recent files
  <Space>fg  - Git files
  <Space>fm  - Modified (git)
  <Space>fc  - Changed (git)
  <Space>fs  - Sibling files
  <Space>fh  - Help
  <Space>fk  - Keymaps
  <Space>ft  - Telescope pickers

SEARCH (<Space>s) - Content:
  <Space>sg  - Grep
  <Space>sw  - Word
  <Space>sd  - Diagnostics
  <Space>sr  - Resume
  <Space>sb  - Search in Buffer
  <Space>so  - Search in Open files
```

---

## 💡 Most Used Commands

### Daily Workflow

1. **`<Space>ff`** - Find file by name (most common)
2. **`<Space>sg`** - Search inside files (second most common)
3. **`<Space>fb`** - Switch between open buffers
4. **`<Space>sw`** - Find all uses of current word

### Quick Access

- **`<Space><Space>`** - Quick buffer switch (fastest)
- **`<Space>/`** - Quick search in current file

---

## 🎓 Learning the New Layout

### Week 1: Core Commands

Focus on these:

- `<Space>ff` - Find files
- `<Space>sg` - Search grep
- `<Space>fb` - Find buffers

### Week 2: Git Commands

Add these:

- `<Space>fm` - Find modified (git)
- `<Space>fg` - Find git files

### Week 3: Advanced

Master these:

- `<Space>fs` - Find siblings
- `<Space>sw` - Search word
- `<Space>sb` - Search in buffer

---

## 🔄 Migration Guide

If you were used to old bindings:

| Old         | New         | Command           |
| ----------- | ----------- | ----------------- |
| `<Space>h`  | `<Space>fh` | Find help         |
| `<Space>sk` | `<Space>fk` | Find keymaps      |
| `<Space>ss` | `<Space>ft` | Find telescope    |
| `<Space>s.` | `<Space>fr` | Find recent       |
| `<Space>s/` | `<Space>so` | Search open files |
| `<Space>/`  | `<Space>sb` | Search buffer     |

**Legacy bindings kept:**

- `<Space><Space>` - Still works for buffers
- `<Space>/` - Still works for buffer search

---

## 🎯 Pro Tips

1. **Use `<Space>` then wait** - You'll see which-key popup showing all options
2. **`<Space>f` for files** - If you're looking for a file/buffer/UI element
3. **`<Space>s` for content** - If you're searching text inside files
4. **Muscle memory** - Give it a week, it'll feel natural!

---

**The new layout is more intuitive and easier to remember! 🎉**

