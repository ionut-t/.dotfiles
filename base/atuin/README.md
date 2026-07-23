# Atuin

Shell history config: local-only, secret-filtered, workspace-aware search.

## Files

| File                                         | Purpose      |
| -------------------------------------------- | ------------ |
| `.config/atuin/config.toml`                  | Main config  |
| `.config/atuin/themes/catppuccin-mocha.toml` | Custom theme |

`mos` symlinks these into `~/.config/atuin/` (module `atuin` in `mos.toml`).

## Setup

```sh
mos link atuin      # symlink config
mos deps install     # installs the atuin package
eval "$(atuin init zsh)"   # already wired into base/zsh
```

## What's configured

- **Search**: `daemon-fuzzy` mode (fuzzy matching offloaded to the background
  daemon, `[daemon] enabled = true`), `filter_mode = "global"` by default,
  workspace filtering when invoked via the shell's Up-arrow
  (`filter_mode_shell_up_key_binding = "workspace"`).
- **Behavior**: `enter_accept = true` runs the selected command immediately;
  `exit_mode = "return-original"` restores your original input line on Esc.
- **Privacy**: `secrets_filter = true` plus `history_filter` regexes drop
  `KEY`/`TOKEN`/`SECRET`/`PASSWORD` exports and `--password`/`--token` flags
  from being recorded at all.
- **Sync**: `auto_sync = false` and no server configured — history never
  leaves this machine unless you explicitly log in and enable it.
- **Stats**: `common_subcommands` groups `git status`/`git commit`/etc. under
  `git` in `atuin stats`; `ignored_commands` excludes noise like `ls`/`cd`.
- **Theme**: `catppuccin-mocha`.

## Usage

- `Ctrl-R` — open interactive search
- `↑` — prefix search from the current line (workspace-filtered)
- `Enter` — run the selected command
- `Esc` — cancel, restoring what you'd typed

## Customizing

**Ignore more commands in stats:**

```toml
[stats]
ignored_commands = ["ls", "cd", "pwd", "clear", "exit", "z", "f", "fp", "your_command"]
```

**Switch theme:** built-in options are `default`, `autumn`, `marine`; drop a
custom `.toml` in `.config/atuin/themes/` for others.

```toml
[theme]
name = "autumn"
```

**Enable sync across machines** (opt-in, off by default here):

```sh
atuin register   # or `atuin login` if you already have an account
```

then set `auto_sync = true` in `config.toml`.

## Troubleshooting

```sh
ls -la ~/.config/atuin           # confirm the symlink is in place
atuin status                     # sync state (errors if not logged in — expected)
mos link atuin                   # re-link if the symlink is missing/stale
```

## Resources

- [Atuin docs](https://atuin.sh)
- [Atuin GitHub](https://github.com/atuinsh/atuin)
