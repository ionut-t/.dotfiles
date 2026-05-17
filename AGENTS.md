# AGENTS.md

This document provides essential information for AI agents working within this dotfiles repository.

## Repository Overview

This repository is managed by **mos** — a dotfiles manager with multi-machine, multi-profile overlay support. Configurations are symlinked into their target locations rather than copied. Files are organized in a three-layer overlay: `base` → `profiles/<name>` → `hosts/<hostname>`. Higher-priority layers override lower ones for the same relative path.

## Directory Structure

```
~/.dotfiles/
  base/          # shared config, active on all machines and profiles
  profiles/      # profile-specific overrides (e.g. home, work)
  hosts/         # machine-specific overrides (keyed by hostname)
  mos.toml       # single source of truth: modules, profiles, hosts, deps
```

Each module's files live under `base/<source-path>/`, and optionally under `profiles/<profile>/<source-path>/` or `hosts/<hostname>/<source-path>/`.

## mos.toml

The config file at the root of this repo. It defines:

- `[settings]` — dotfiles dir, backup dir, optional `commit_cmd`
- `[hosts.<hostname>]` — OS, package manager, and default profile per machine
- `[profiles.<name>]` — list of modules active in that profile
- `[modules.<name>]` — source path, target path, and dependencies

Modules with no `source`/`target` are deps-only (tools to install but not configure).

## Common mos Commands

```sh
mos link                      # link all modules in the active profile
mos link <module>             # link a single module
mos unlink <module>           # remove symlinks for a module
mos status                    # show linked modules and drift

mos profile list              # list profiles (* = active)
mos profile switch <name>     # switch active profile (unlinks old, links new)
mos profile create <name>     # create a new profile interactively
mos profile override <module> # copy base files into active profile for editing

mos host list                 # list registered hosts
mos host register             # register this machine interactively
mos host info                 # show this host's config

mos deps check                # show which dependencies are installed/missing
mos deps install              # install missing dependencies

mos sync pull                 # git pull + re-link active profile
mos sync push                 # git add -A + commit (via commit_cmd or prompt) + push
```

## Workflow

### On a new machine

```sh
mos init          # creates directory structure and saves global config
mos host register # register this hostname
mos link          # links all modules in the default profile
mos deps install  # installs missing tools
```

### Day-to-day

Edit files directly under `base/` (or the appropriate profile/host layer), then:

```sh
mos sync push     # commit and push changes
```

On another machine:

```sh
mos sync pull     # pull latest + re-link
```

### Profile-specific overrides

```sh
mos profile override <module>  # copies base files into profiles/<active>/
# edit the copied files
mos link <module>              # re-link to pick up the override
```

## Modules

Current modules are defined in `mos.toml`. Each has a `source` (relative path inside the dotfiles repo) and a `target` (absolute path where symlinks are created). Deps-only modules (bark, vex, perp, lens) have no source/target — they just declare installation dependencies.

## Dependency Backends

| Backend    | Example                                              |
| ---------- | ---------------------------------------------------- | ------- |
| `packages` | `["git"]` or `[{ brew = "sevenzip", apt = "7zip" }]` |
| `brew`     | `["git"]` or `[{ pkg = "ripgrep", bin = "rg" }]`     |
| `apt`      | `["git"]` or `[{ pkg = "fd-find", bin = "fdfind" }]` |
| `cargo`    | `["stylua"]`                                         |
| `go`       | `["github.com/user/tool@latest"]`                    |
| `script`   | `[{ name = "x", cmd = "curl ...                      | sh" }]` |

`packages` is the cross-platform field. Plain strings use the same package name on every manager; inline maps (`{ brew = "x", apt = "y" }`) handle name differences — omit a key to skip that platform entirely. Use `brew` or `apt` directly for packages that only make sense on one platform.

## Modifying Configurations

- Edit files under `base/` for changes that apply everywhere.
- Edit files under `profiles/<name>/` for profile-specific changes.
- Edit files under `hosts/<hostname>/` for machine-specific changes.
- After editing, run `mos sync push` to commit and push.
- Never edit symlink targets directly — edit the source files in this repo.

## Neovim Architecture

Config lives at `base/nvim/.config/nvim/`. Entry point: `init.lua`. Plugins managed by `lazy.nvim` under `lua/plugins/`. Core settings in `lua/core/` (options, keymaps, snippets). To add a plugin: create `lua/plugins/<name>.lua` and add it to the `lazy.nvim` setup in `init.lua`.

## Git Configuration

File: `base/git/.gitconfig`. Custom aliases: `ac`, `acp`, `co`, `cob`, `bd`, `puo`, `parent`. Default editor: vim.

## Commit Conventions

Commit messages should be descriptive. If `commit_cmd = "bark commit"` is set in `mos.toml`, bark generates the message automatically on `mos sync push`.
