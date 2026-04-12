const ASK_DIR = "~/ask"

# Ask a general question using Gemini
def "?" [...question: string] {
    if ($question | is-empty) {
        print "Usage: ? <your question>"
        return
    }
    let context = (open ($ASK_DIR | path expand | path join "general.md"))
    $"($context)\n\nQuestion: ($question | str join ' ')" | ^ask -m "gemini-2.5-flash" | ^glow
}

# Ask a question about your dotfiles configs
def "??" [...args: string] {
    let dotfiles = $"($env.HOME)/.dotfiles"
    let ask_dir = ($ASK_DIR | path expand)

    if ($args | is-empty) {
        print "Usage: ?? [tool] <question>"
        print "Tools: nvim, zsh, git, tmux, aerospace"
        print "Omit tool to include all configs."
        return
    }

    let first = ($args | first | str downcase)
    let tool = match $first {
        "nvim" | "neovim" | "vim" => "nvim"
        "zsh" | "shell"           => "zsh"
        "git"                     => "git"
        "tmux"                    => "tmux"
        "aerospace" | "aero"      => "aerospace"
        _                         => ""
    }

    let query = if ($tool | is-not-empty) {
        $args | skip 1 | str join " "
    } else {
        $args | str join " "
    }

    if ($query | is-empty) {
        print "Please provide a question."
        return
    }

    let base = (open ($ask_dir | path join "dothelp.md")) + "\n\n"

    let context = if ($tool | is-not-empty) {
        _ask_dotfiles_context $tool $dotfiles
    } else {
        ["zsh" "git" "tmux" "aerospace" "nvim"] | each { |t|
            _ask_dotfiles_context $t $dotfiles
        } | str join
    }

    $"($base)($context)\nQuestion: ($query)" | ^ask -m "gemini-2.5-flash-lite" | ^glow
}

# Ask a Tailwind CSS question
def "?tw" [...question: string] {
    if ($question | is-empty) {
        print "Usage: ?tw <your question>"
        return
    }
    let context = (open ($ASK_DIR | path expand | path join "tailwind.md"))
    $"($context)\n\nQuestion: ($question | str join ' ')" | ^ask -m "gemini-2.5-flash" | ^glow
}

# Command of the day
def cotd [] {
    open ($ASK_DIR | path expand | path join "cotd.md") | ^ask -m "gemini-2.5-flash-lite" | ^glow
}

# Neovim command of the day
def ncotd [] {
    open ($ASK_DIR | path expand | path join "nvim-cotd.md") | ^ask -m "gemini-2.5-flash-lite" | ^glow
}

# Internal: build context string for a given tool
def _ask_dotfiles_context [tool: string, dotfiles: string] {
    match $tool {
        "zsh" => {
            $"=== ZSH CONFIG \(.zshrc\) ===\n(open $"($dotfiles)/zsh/.zshrc")\n\n"
        }
        "git" => {
            $"=== GIT CONFIG \(.gitconfig\) ===\n(open $"($dotfiles)/git/.gitconfig")\n\n"
        }
        "tmux" => {
            $"=== TMUX CONFIG \(.tmux.conf\) ===\n(open $"($dotfiles)/tmux/.tmux.conf")\n\n"
        }
        "aerospace" => {
            let f = $"($dotfiles)/aerospace/.config/aerospace/aerospace.toml"
            if ($f | path exists) {
                $"=== AEROSPACE CONFIG ===\n(open $f)\n\n"
            } else { "" }
        }
        "nvim" => {
            let keymaps = (open $"($dotfiles)/nvim/.config/nvim/lua/core/keymaps.lua")
            let options = (open $"($dotfiles)/nvim/.config/nvim/lua/core/options.lua")
            let plugins = (glob $"($dotfiles)/nvim/.config/nvim/lua/plugins/*.lua" | each { |f|
                $"=== NVIM PLUGIN: ($f | path basename) ===\n(open $f)\n\n"
            } | str join)
            $"=== NVIM KEYMAPS ===\n($keymaps)\n\n=== NVIM OPTIONS ===\n($options)\n\n($plugins)"
        }
        _ => ""
    }
}
