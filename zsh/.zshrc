# Terminal settings (add these at the very top)
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh path
export ZSH="/Users/ionut-traistaru/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Settings
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins (removed duplicates and conflicts)
plugins=(
  git
  sudo
  gcloud
  python
  zsh-autosuggestions
  zsh-syntax-highlighting
  thefuck
)

source $ZSH/oh-my-zsh.sh

# Flutter path
export PATH="$PATH:/Users/ionut-traistaru/tools/flutter/bin"
export PATH="Users/ionut-traistaru/tools/bin:$PATH"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Yarn path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Google Cloud SDK
if [ -f '/Users/ionut-traistaru/Downloads/google-cloud-sdk/path.zsh.inc' ]; then
  source '/Users/ionut-traistaru/Downloads/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/ionut-traistaru/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then
  source '/Users/ionut-traistaru/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

# Dart completion
[[ -f /Users/ionut-traistaru/.dart-cli-completion/zsh-config.zsh ]] && source /Users/ionut-traistaru/.dart-cli-completion/zsh-config.zsh

# Docker path
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Conda initialization
__conda_setup="$('/Users/ionut-traistaru/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ionut-traistaru/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ionut-traistaru/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ionut-traistaru/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# .NET Core path
export PATH=$PATH:/usr/local/share/dotnet

# FZF configuration
source <(fzf --zsh)
source ~/fzf-git.sh/fzf-git.sh

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF theme
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Aliases
alias f="fzf"
alias fp="fzf --preview 'bat --color=always --line-range :500 {}'"
alias ls="eza --color=always --long --git --icons=always --no-user --no-time --no-permissions --no-filesize"
alias cd="z"
alias ws="webstorm"
alias t="tmux"
alias tks="tmux kill-session"
alias ta="tmux a"
alias tls="tmux ls"
alias sdf="$HOME/.dotfiles/sync-dotfiles.zsh"

# Tool configurations
eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"
export BAT_THEME=tokyonight_night

# Load p10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias lvim="/Users/ionut-traistaru/.local/bin/lvim"

export PATH=$PATH:$(go env GOPATH)/bin
