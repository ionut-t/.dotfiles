#!/usr/bin/env zsh

# Enable zsh word splitting similar to bash
setopt SH_WORD_SPLIT
# Extended globbing for better pattern matching
setopt EXTENDED_GLOB
# Error if glob pattern has no matches
setopt NOMATCH

# Check for required commands
autoload -Uz colors && colors

if (( ! $+commands[yazi] )); then
    print "Error: yazi is not installed. Please install it first."
    exit 1
fi

# Cleaner way to define colors in zsh
typeset -A color_map=(
    info    $fg[yellow]
    success $fg[green]
    error   $fg[red]
    reset   $reset_color
)

# Function to print colored output
print_colored() {
    local color=$1
    shift
    print -P "${color_map[$color]}$*${color_map[reset]}"
}

# Function to select files using yazi
select_files() {
    local branch=$1
    local temp_dir=$(mktemp -d)
    local selection_file="$temp_dir/selection"

    # Checkout the branch
    git checkout -q $branch

    # Create a temporary directory with the files
    print_colored info "Opening yazi for $branch branch..." >&2
    print_colored info "Press 'Space' to select files, 'q' to confirm selection" >&2

    # Use yazi for file selection
    # The --chooser-file option will save selected files to our temp file
    yazi . --chooser-file="$selection_file"

    # Read selected files if the selection file exists
    local -a selected_files=()
    if [[ -f $selection_file ]]; then
        selected_files=(${(f)"$(cat $selection_file)"})
        # Convert to relative paths
        selected_files=(${selected_files[@]#$PWD/})
    fi

    # Clean up
    rm -rf $temp_dir

    # Return selected files
    print -l $selected_files
}

# Function to sync one file or directory between branches
# Assumes we are already on the target branch
sync_file() {
    local source_branch=$1
    local target_branch=$2
    local file=$3

    print_colored info "Syncing $file from $source_branch to $target_branch..."

    # Pull the file/directory from source branch into the current working tree and index
    if ! git checkout $source_branch -- $file 2>/dev/null; then
        print_colored error "File or directory $file not found in $source_branch"
        return 1
    fi

    print_colored success "Synced: $file"
}

# Function to pull latest changes for a branch
pull_latest_changes() {
    local branch=$1
    local current_branch=${$(git branch --show-current)}
    
    print_colored info "Pulling latest changes for $branch branch..."
    
    # Checkout the branch and pull
    git checkout -q $branch
    git pull
    
    # Return to original branch
    git checkout -q $current_branch
}

main() {
    # Store current branch name
    local CURRENT_BRANCH=${$(git branch --show-current)}

    # Get other branch name
    local OTHER_BRANCH=${$(git branch | grep -v "\*" | grep -E "^[[:space:]]+(main|work)$" | tr -d '[:space:]')}

    if [[ -z $OTHER_BRANCH ]]; then
        print_colored error "Error: Could not find 'main' or 'work' branch"
        exit 1
    fi

    # Stash any current changes
    git stash -q

    print_colored info "Current branch: $CURRENT_BRANCH"
    print_colored info "Other branch: $OTHER_BRANCH"
    
    # Pull latest changes for the other branch
    pull_latest_changes $OTHER_BRANCH
    
    print "\nSelect source branch for sync:"
    print "1) $CURRENT_BRANCH"
    print "2) $OTHER_BRANCH"
    read "source_choice?Enter choice (1/2): "

    case $source_choice in
        1) source_branch=$CURRENT_BRANCH; target_branch=$OTHER_BRANCH ;;
        2) source_branch=$OTHER_BRANCH; target_branch=$CURRENT_BRANCH ;;
        *) print_colored error "Invalid choice"; exit 1 ;;
    esac

    # Select files using yazi
    local -a selected_files=($(select_files $source_branch))

    if (( ${#selected_files} == 0 )); then
        print "No files selected. Exiting."
        git checkout -q $CURRENT_BRANCH
        git stash pop -q 2>/dev/null
        exit 0
    fi

    # Show selected files and confirm
    print "\nSelected files:"
    print -l $selected_files

    # Confirm sync
    print "\nDo you want to sync these files from $source_branch to $target_branch? [y/N]"
    read -q "response?Confirm sync? [y/N] "
    print

    if [[ $response == "y" ]]; then
        # Switch to target branch once before syncing all files
        git checkout -q $target_branch

        for file in $selected_files; do
            sync_file $source_branch $target_branch $file
        done
        if ! git diff --cached --quiet; then
            git commit -m "Sync dotfiles from $source_branch"
            print_colored success "Committed changes in $target_branch"
        fi

        print_colored success "\nSync completed!"
    else
        print "Sync cancelled."
    fi

    # Return to original branch and restore changes
    git checkout -q $CURRENT_BRANCH
    git stash pop -q 2>/dev/null
}

main
