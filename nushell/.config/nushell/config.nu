# ============================================================================
# STARSHIP PROMPT
# ============================================================================
use ~/.cache/starship/init.nu

# ============================================================================
# ZOXIDE (replaces cd)
# ============================================================================
source ~/.zoxide.nu

# ============================================================================
# SHELL SETTINGS
# ============================================================================
$env.config = {
    show_banner: false
    edit_mode: vi
    history: {
        max_size: 10000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    keybindings: [
        {
            name: history_search_backward
            modifier: control
            keycode: char_p
            mode: [vi_insert, vi_normal]
            event: { send: HistoryHintWordComplete }
        }
        {
            name: history_search_forward
            modifier: control
            keycode: char_n
            mode: [vi_insert, vi_normal]
            event: { send: MenuNext }
        }
    ]
}
# ============================================================================
# ALIASES - Tmux
# ============================================================================
alias t  = tmux
alias ta = tmux a

# ============================================================================
# ALIASES - Editors & IDEs
# ============================================================================
alias vim  = /Applications/MacVim.app/Contents/bin/Vim
alias code = code-insiders
alias ws   = webstorm
alias v    = nvim

# ============================================================================
# ALIASES - Utilities
# ============================================================================
alias c = clear

# ============================================================================
# ALIASES - Fuzzy finder
# ============================================================================
alias preview = fzf --preview 'bat --color=always {}' --preview-window '~4'

# ============================================================================
# CUSTOM COMMANDS
# ============================================================================

# Open nvim with lazy session restore
def nvl [...args] {
    ^nvim -c "lua require('persistence').load()" ...$args
}

# Open nvim with lazyvim config
def lazyvim [...args] {
    with-env { NVIM_APPNAME: "lazyvim" } { ^nvim ...$args }
}

# Get public IP
def myip [] { ^curl -s ifconfig.me | str trim }

# Get local IP
def localip [] { ^ipconfig getifaddr en0 }

# Run dotfiles sync script
def sdf [] { ^$"($env.HOME)/.dotfiles/sync-dotfiles.zsh" }

# Exit shell
def e [] { exit }

# Interactive zoxide jump with fzf preview
def --env zz [] {
    let dir = (
        ^zoxide query --list
        | ^fzf --preview 'eza --tree --level=1 --color=always {}'
        | str trim
    )
    if ($dir | is-not-empty) {
        cd $dir
    }
}

# Ripgrep + fzf search, open result in nvim
def s [query?: string] {
    let q = ($query | default ".")
    ^rg --color=always --line-number --no-heading --smart-case $q
    | ^fzf --ansi --delimiter ':' --preview 'bat --color=always {1} --highlight-line {2}' --preview-window 'up,60%,border-bottom,+{2}+3/3' --header 'Enter: nvim | Ctrl-Y: copy path' --bind 'enter:become(nvim +{2} {1})' --bind 'ctrl-y:execute-silent(echo {1} | pbcopy)+abort'
}

# Kill process listening on a port
def killport [port: int] {
    ^bash -c $"lsof -ti:($port) | xargs kill -9"
}

# Fetch cheat sheet for a topic
def cheat [topic: string] {
    ^curl -s $"cheat.sh/($topic)"
}

# Interactive process killer with fzf
def pk [] {
    ^bash -c 'ps aux | awk '"'"'NR==1 {print "PID\t%CPU\t%MEM\tCOMMAND"; next} {printf "%s\t%s\t%s\t", $2, $3, $4; for(i=11;i<=NF;i++) printf "%s ", $i; print ""}'"'"' | column -t -s $'"'"'\t'"'"' | fzf --header-lines=1 --header "Kill process" | awk '"'"'{print $1}'"'"' | xargs -r kill'
}

# Interactive branch checkout with fzf
def gs [] {
    ^bash -c 'git branch | fzf --preview "git log --oneline --graph --color=always {1}" | xargs git checkout'
}

# Interactive checkout from all branches (including remotes)
def gsa [] {
    ^bash -c 'git branch --all | fzf --preview "git log --oneline --graph --color=always {1}" | xargs git checkout'
}

# Interactive git log with fzf
def gll [] {
    ^bash -c 'git log --oneline --graph --color=always | fzf --ansi --preview "git show --color=always {1}" --bind "enter:execute(git show {1})"'
}

# ============================================================================
# EXTERNAL SOURCES
# ============================================================================
source ~/ask/ask.nu
let envs_file = $"($env.HOME)/.envs/.env"
if ($envs_file | path exists) {
    for line in (open $envs_file | lines | where ($it | str starts-with "export ")) {
        let parts = ($line | str replace "export " "" | split row "=")
        let key = ($parts | first | str trim)
        let raw = ($parts | skip 1 | str join "=" | str trim | str trim --char '"' | str trim --char "'")
        let value = if ($raw | str starts-with "$") {
            $env | get -o ($raw | str substring 1..) | default $raw
        } else {
            $raw
        }
        load-env { ($key): $value }
    }
}
