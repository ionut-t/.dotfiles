# ============================================================================
# INSTANT PROMPT
# ============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# HOMEBREW
# ============================================================================
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# ZINIT PLUGIN MANAGER
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ============================================================================
# ZSH PLUGINS
# ============================================================================
# Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh My Zsh snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::gcloud
zinit snippet OMZP::python
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

zinit load atuinsh/atuin

# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# SHELL CONFIGURATION
# ============================================================================
# Vi mode cursor shape
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'  # Block cursor for normal mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'  # Beam cursor for insert mode
  fi
}
zle -N zle-keymap-select

# Start each new prompt with beam cursor (insert mode)
function zle-line-init {
  echo -ne '\e[6 q'
}
zle -N zle-line-init

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

unsetopt CORRECT_ALL

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export BAT_THEME=catppuccin_mocha

# ============================================================================
# PATH CONFIGURATION
# ============================================================================
export PATH="${HOME}/.local/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"                                       # Go
export PATH="$PATH:$HOME/zig"                                                  # Zig
export PATH="$PATH:/usr/local/share/dotnet"                                    # .NET
export PATH="/usr/local/opt/postgresql@17/bin:$PATH"                           # PostgreSQL
export PATH="$PATH:$HOME/tools/flutter/bin"                                    # Flutter
export PATH="$HOME/tools/bin:$PATH"                                            # Custom tools
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"  # Yarn

# ============================================================================
# LANGUAGE & FRAMEWORK SETUP
# ============================================================================
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
unset PREFIX
nvm use default --silent 2>/dev/null

# Conda
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Dart
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && \
  source "$HOME/.dart-cli-completion/zsh-config.zsh"

# Google Cloud SDK
[ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ] && \
  source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ] && \
  source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"

# ============================================================================
# FZF CONFIGURATION
# ============================================================================
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

source ~/fzf-git.sh/fzf-git.sh

# ============================================================================
# TOOL INTEGRATIONS
# ============================================================================
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
eval "$(atuin init zsh)"

# ============================================================================
# ALIASES
# ============================================================================
# Navigation & file management
alias zz="cd \$(zoxide query --list | fzf --preview 'eza --tree --level=1 --color=always {}')"
alias ls="eza --color=always --long --git --icons=always --no-user --no-time --no-permissions --no-filesize --group-directories-first"
alias ll="eza --color=always --long --git --icons=always --no-user --group-directories-first --time-style='+%d/%m/%y'"
alias la="eza --color=always --long --git --icons=always --no-user --group-directories-first --all --time-style='+%d/%m/%y'"
alias lt="eza --color=always --icons=always --tree --level=2 --group-directories-first"
alias lt3="eza --color=always --icons=always --tree --level=3 --group-directories-first"
alias lr="eza --color=always --long --git --icons=always --no-user --sort=modified --reverse --time-style='+%d/%m/%y'"

# Fuzzy finder
alias preview="fzf --preview 'bat --color=always {}' --preview-window '~4'"

# Tmux
alias t="tmux"
alias ta="tmux a"

# Git + fzf
alias gs="git branch | fzf --preview 'git log --oneline --graph --color=always {1}' | xargs git checkout"
alias gsa="git branch --all | fzf --preview 'git log --oneline --graph --color=always {1}' | xargs git checkout"
alias gll="git log --oneline --graph --color=always | fzf --ansi --preview 'git show --color=always {1}' --bind 'enter:execute(git show {1})'"

# Editors & IDEs
alias vim="/Applications/MacVim.app/Contents/bin/Vim"
alias code="code-insiders"
alias ws="webstorm"
alias v="nvim"
alias nvl="nvim -c \"lua require('persistence').load()\""
alias lazyvim="NVIM_APPNAME=lazyvim nvim"

# Utilities
alias c='clear'
alias e='exit'
alias sdf="$HOME/.dotfiles/sync-dotfiles.zsh"
alias myip="curl -s ifconfig.me && echo"
alias localip="ipconfig getifaddr en0"

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================
# Launch gemini with Angular prompt
function gem-ng() {
  gemini -p "$(cat "${HOME}/prompts/angular.md")"
}

# Grep search with preview and open in nvim
function search() {
  rg --color=always --line-number --no-heading --smart-case "${1:-.}" | \
    fzf --ansi --delimiter ':' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3' \
      --header 'Enter: nvim | Ctrl-Y: copy path' \
      --bind 'enter:execute(nvim +{2} {1})' \
      --bind 'ctrl-y:execute-silent(echo {1} | pbcopy)+abort' \
}
alias s=search

# Kill process on a port
function killport() { lsof -ti:$1 | xargs kill -9 }

# Cheat sheets
function cheat() { curl -s "cheat.sh/$1" }

# Process killer with clean format
function pk() {
  ps aux | \
    awk 'NR==1 {print "PID\t%CPU\t%MEM\tCOMMAND"; next} {printf "%s\t%s\t%s\t", $2, $3, $4; for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | \
    column -t -s $'\t' | \
    fzf --header-lines=1 --header 'Kill process' | \
    awk '{print $1}' | \
    xargs -r kill
}

# ============================================================================
# EXTERNAL SOURCES
# ============================================================================
source ~/.envs/.env
source ~/ask/ask.zsh
