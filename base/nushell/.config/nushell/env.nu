# ============================================================================
# PATH CONFIGURATION
# ============================================================================
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend [
        $"($env.HOME)/.local/bin"
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "/usr/local/opt/postgresql@17/bin"
        "/Applications/Docker.app/Contents/Resources/bin"
        $"($env.HOME)/.antigravity/antigravity/bin"
        $"($env.HOME)/tools/bin"
        $"($env.HOME)/.yarn/bin"
        $"($env.HOME)/.config/yarn/global/node_modules/.bin"
    ]
    | append [
        $"($env.HOME)/zig"
        "/usr/local/share/dotnet"
        $"($env.HOME)/tools/flutter/bin"
    ]
    | uniq
)

# Append Go bin if go is available
if (which go | is-not-empty) {
    let gopath = (^go env GOPATH | str trim)
    $env.PATH = ($env.PATH | append $"($gopath)/bin")
}

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BAT_THEME = "catppuccin_mocha"
$env.NVM_DIR = $"($env.HOME)/.nvm"

# FZF
$env.FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env.FZF_CTRL_T_COMMAND = $env.FZF_DEFAULT_COMMAND
$env.FZF_ALT_C_COMMAND = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
$env.FZF_DEFAULT_OPTS = "
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--multi"

# ============================================================================
# PROMPT INIT (Starship - Tokyo Night theme)
# ============================================================================
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship-nushell.toml"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# ============================================================================
# ZOXIDE INIT
# ============================================================================
zoxide init nushell | save -f ~/.zoxide.nu

# ============================================================================
# ATUIN INIT
# ============================================================================
if (which atuin | is-not-empty) {
    atuin init nu | save -f $"($env.HOME)/.local/share/atuin/init.nu"
}
