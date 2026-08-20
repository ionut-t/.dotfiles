# .dotfiles

Personal dotfiles managed by [mos](https://github.com/ionut-t/mos), a dotfiles manager with
multi-machine, multi-profile overlay support.

## New machine

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

```sh
cargo install --git https://github.com/ionut-t/mos.git
```

```sh
git clone https://github.com/ionut-t/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

```sh
mos init
mos host register
mos link
mos deps install
~/.tmux/plugins/tpm/bin/install_plugins
```
