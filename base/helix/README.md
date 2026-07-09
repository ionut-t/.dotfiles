# Helix

Helix config with Angular + Nx support.

## Files

| File                                     | Purpose                                                                                        |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `.config/helix/config.toml`              | Editor settings, keybindings, theme                                                            |
| `.config/helix/languages.toml`           | Language servers (angular, nxls) + angular language/grammar                                    |
| `.config/helix/runtime/queries/angular/` | Hand-written tree-sitter queries for Angular templates (Helix has no built-in Angular support) |

`mos` symlinks these per-file into `~/.config/helix/`. Grammar build output
(`~/.config/helix/runtime/grammars/`, ~GBs) is local-only and never part of
this repo.

## New machine setup

```sh
# 1. Link config and install deps (helix + language servers via npm)
mos link helix
mos deps install

# 2. Compile the angular tree-sitter grammar (one-time, local)
hx --grammar fetch
hx --grammar build

# 3. Verify
hx --health angular     # LSP ✓, parser ✓, highlight queries ✓
hx --health typescript  # typescript-language-server ✓ + angular ✓
hx --health json        # vscode-json-language-server ✓ + nxls ✓
```

`mos deps install` installs the language servers (requires node/npm on PATH);
to do it manually in one go:

```sh
# typescript-language-server, ngserver, nxls, vscode-json-language-server
npm i -g typescript typescript-language-server @angular/language-server nxls vscode-langservers-extracted
```

The `catppuccin_mocha` theme ships built-in with Helix — no theme step needed.

## How the Angular/Nx setup works

- `*.html` files use the `angular` language: tree-sitter-angular grammar
  (control flow `@if`/`@for`/`@defer`, pipes, bindings) + `ngserver` +
  prettier via `npx prettier --parser angular` on format.
- `ngserver` probes project-local `node_modules` first, then the global npm
  root (`npm root -g`), so it also starts for files outside a project.
- `.ts` files run `typescript-language-server` and `ngserver` together, so
  component files get Angular-aware diagnostics too.
- JSON files run `vscode-json-language-server` and `nxls` together: Nx
  completions/docs in `nx.json`, `project.json`, and `package.json` targets.
  `nxls` is inert outside Nx workspaces.
- Queries in `runtime/queries/angular/` are ported from the grammar's Neovim
  queries: Helix capture names, pattern order reversed (Helix = first match
  wins, Neovim = last).

## Navigation extras

- `C-y` opens yazi inside Helix as a file tree/picker (pick a file → opens in
  Helix). Requires yazi on PATH — install via the `yazi` module.
- `{` / `}` jump between paragraphs (vim muscle memory).
- Built-in, no config needed: `gw` flash-style jump labels, `Space e` file
  explorer, `Space f` fuzzy files, `Space /` live grep, `ga` alternate file.

## Gotchas

- After bumping the grammar `rev` in `languages.toml`, re-run
  `hx --grammar fetch && hx --grammar build`.
- Formatting shells out to `npx prettier`; in a project without prettier
  installed, npx may prompt/fetch. Disable per-project with
  `.helix/languages.toml` overriding `auto-format = false` if needed.
