ASK_DIR="${0:a:h}"

function _ask() {
  local context="$(cat "$ASK_DIR/general.md")"$'\n\n'

  if [ $# -eq 0 ]; then
    echo "Usage: ? <your question>"
    return 1
  fi

  printf '%s\nQuestion: %s\n' "$context" "$@" | ask -m "gemini-2.5-flash" | glow
}

alias '?'='_ask'

function _dothelp_add_zsh() {
  local dotfiles=$1
  context+=$'=== ZSH CONFIG (.zshrc) ===\n'"$(cat "$dotfiles/zsh/.zshrc")"$'\n\n'
}

function _dothelp_add_git() {
  local dotfiles=$1
  context+=$'=== GIT CONFIG (.gitconfig) ===\n'"$(cat "$dotfiles/git/.gitconfig")"$'\n\n'
}

function _dothelp_add_tmux() {
  local dotfiles=$1
  context+=$'=== TMUX CONFIG (.tmux.conf) ===\n'"$(cat "$dotfiles/tmux/.tmux.conf")"$'\n\n'
}

function _dothelp_add_aerospace() {
  local dotfiles=$1
  [ -f "$dotfiles/aerospace/.config/aerospace/aerospace.toml" ] && \
    context+=$'=== AEROSPACE CONFIG ===\n'"$(cat "$dotfiles/aerospace/.config/aerospace/aerospace.toml")"$'\n\n'
}

function _dothelp_add_nvim() {
  local dotfiles=$1
  context+=$'=== NVIM KEYMAPS ===\n'"$(cat "$dotfiles/nvim/.config/nvim/lua/core/keymaps.lua")"$'\n\n'
  context+=$'=== NVIM OPTIONS ===\n'"$(cat "$dotfiles/nvim/.config/nvim/lua/core/options.lua")"$'\n\n'
  for f in "$dotfiles"/nvim/.config/nvim/lua/plugins/*.lua; do
    context+="=== NVIM PLUGIN: $(basename "$f") ==="$'\n'"$(cat "$f")"$'\n\n'
  done
}

function dothelp() {
  if [ $# -eq 0 ]; then
    echo "Usage: dothelp [tool] <question>"
    echo "Tools: nvim, zsh, git, tmux, aerospace"
    echo "Omit tool to include all configs."
    return 1
  fi

  local dotfiles="$HOME/.dotfiles"
  local context="$(cat "$ASK_DIR/dothelp.md")"$'\n\n'
  local tool=""
  local query="$*"

  # Extract the first word to check for a tool name
  local first_word="${${query}%% *}"

  case "${first_word:l}" in
    nvim|neovim|vim)  tool=nvim      ;;
    zsh|shell)        tool=zsh       ;;
    git)              tool=git       ;;
    tmux)             tool=tmux      ;;
    aerospace|aero)   tool=aerospace ;;
  esac

  # Strip the tool name from the query
  if [ -n "$tool" ]; then
    query="${query#$first_word}"
    query="${query# }"
  fi

  if [ -z "$query" ]; then
    echo "Please provide a question."
    return 1
  fi

  if [ -n "$tool" ]; then
    _dothelp_add_$tool "$dotfiles"
  else
    _dothelp_add_zsh "$dotfiles"
    _dothelp_add_git "$dotfiles"
    _dothelp_add_tmux "$dotfiles"
    _dothelp_add_aerospace "$dotfiles"
    _dothelp_add_nvim "$dotfiles"
  fi

  printf '%s\nQuestion: %s\n' "$context" "$query" | ask -m "gemini-2.5-flash-lite" | glow
}

alias '??'='dothelp'

function _tailwind() {
  local context="$(cat "$ASK_DIR/tailwind.md")"$'\n\n'

  if [ $# -eq 0 ]; then
    echo "Usage: ?tw <your question>"
    return 1
  fi

  printf '%s\nQuestion: %s\n' "$context" "$@" | ask -m "gemini-2.5-flash" | glow
}

alias '?tw'='_tailwind'
