# shellcheck shell=bash disable=SC1090,SC1091
# ============================================================================
# BASH SETTINGS
# ============================================================================
[[ $- != *i* ]] && return

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:ll:la:cd:pwd:exit:clear"
shopt -s histappend
shopt -s checkwinsize
[ "${BASH_VERSINFO[0]}" -ge 4 ] && shopt -s globstar

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
export PATH="$HOME/.cargo/bin:$PATH"                     # Cargo
_gopath=$(go env GOPATH 2>/dev/null)
export PATH="$PATH:$_gopath/bin"                         # Go
export PATH="$HOME/tools/bin:$PATH"                      # Custom tools
export PATH="$HOME/bin:$PATH"

# ============================================================================
# LANGUAGE & FRAMEWORK SETUP
# ============================================================================
# NVM (lazy load)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  command nvm "$@"
}
node() {
  unset -f nvm node npm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  command node "$@"
}
npm() {
  unset -f nvm node npm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  command npm "$@"
}

# ============================================================================
# FZF CONFIGURATION
# ============================================================================
# On Ubuntu, fd may be installed as fdfind; symlink fd -> fdfind if needed
_fd_cmd="fd"
command -v fdfind &>/dev/null && _fd_cmd="fdfind"

export FZF_DEFAULT_COMMAND="$_fd_cmd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$_fd_cmd --type=d --hidden --strip-cwd-prefix --exclude .git"

_bat_cmd="bat"
command -v batcat &>/dev/null && _bat_cmd="batcat"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else $_bat_cmd -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--multi"

# ============================================================================
# TOOL INTEGRATIONS
# ============================================================================
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd bash)"
fi

if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

[ -f ~/fzf-git.sh/fzf-git.sh ] && source ~/fzf-git.sh/fzf-git.sh

# ============================================================================
# ALIASES
# ============================================================================
# Navigation & file management
alias zz='cd "$(zoxide query --list | fzf --preview '"'"'eza --tree --level=1 --color=always {}'"'"')"'
alias ls='eza --color=always --long --git --icons=always --no-user --no-time --no-permissions --no-filesize --group-directories-first'
alias ll='eza --color=always --long --git --icons=always --no-user --group-directories-first --time-style="+%d/%m/%y"'
alias la='eza --color=always --long --git --icons=always --no-user --group-directories-first --all --time-style="+%d/%m/%y"'
alias lt='eza --color=always --icons=always --tree --level=2 --group-directories-first'
alias lt3='eza --color=always --icons=always --tree --level=3 --group-directories-first'
alias lr='eza --color=always --long --git --icons=always --no-user --sort=modified --reverse --time-style="+%d/%m/%y"'

# Fuzzy finder
alias preview="fzf --preview '$_bat_cmd --color=always {}' --preview-window '~4'"

# Tmux
alias t="tmux"
alias ta="tmux a"

# Git + fzf
alias gs="git branch | fzf --preview 'git log --oneline --graph --color=always {1}' | xargs git checkout"
alias gsa="git branch --all | fzf --preview 'git log --oneline --graph --color=always {1}' | xargs git checkout"
alias gll="git log --oneline --graph --color=always | fzf --ansi --preview 'git show --color=always {1}' --bind 'enter:execute(git show {1})'"

# Editors
alias v="nvim"
alias nvl="nvim -c \"lua require('persistence').load()\""

# Utilities
alias c='clear'
alias e='exit'
alias myip="curl -s ifconfig.me && echo"
function localip() { hostname -I | awk '{print $1}'; }

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================
function search() {
  local rg_flag="" prompt="Search ➤ "
  [[ "$1" == "-w" ]] && { rg_flag="-w"; prompt="Word ➤ "; shift; }
  [[ "$1" == "-F" ]] && { rg_flag="-F"; prompt="Fixed ➤ "; shift; }

  local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/' --glob '!node_modules/'"

  fzf --ansi --disabled --query "$*" \
    --bind "start:reload($rg_prefix $rg_flag {q} || true)" \
    --bind "change:reload:sleep 0.1; $rg_prefix $rg_flag {q} || true" \
    --bind "ctrl-w:reload($rg_prefix -w {q} || true)+change-prompt(Word ➤ )" \
    --bind "ctrl-f:reload($rg_prefix -F {q} || true)+change-prompt(Fixed ➤ )" \
    --bind "ctrl-r:reload($rg_prefix {q} || true)+change-prompt(Search ➤ )" \
    --delimiter ':' \
    --preview "$_bat_cmd --color=always {1} --highlight-line {2}" \
    --preview-window 'up,60%,border-bottom,+{2}+3/3' \
    --header 'C-w: Word Match | C-f: Fixed String | C-r: Regex | Enter: nvim' \
    --bind 'enter:execute(nvim +{2} {1})' \
    --prompt "$prompt"
}
alias s=search
alias se="search -w"

function killport() { fuser -k "$1"/tcp; }

function cheat() { curl -s "cheat.sh/$1"; }

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
[ -f ~/.envs/.env ] && source ~/.envs/.env
[ -f ~/ask/ask.bash ] && source ~/ask/ask.bash

if command -v vex &>/dev/null; then
  function vex() {
    local cmd
    cmd=$(command vex "$@")
    [[ -n "$cmd" ]] && history -s "$cmd"
  }
fi
