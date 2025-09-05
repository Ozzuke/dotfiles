# Create and enter a directory
md() {
    mkdir -p "$1" && cd "$1"
}


# Git add all, commit with message, push to origin
gcp() {
    git add -A
    git commit -m "$1"
    git push
}

### Python venv functions ###

# Create and activate a new venv, install requirements if present
# Usage: venv [name] (default: venv)
venv() {
    local venv_name="${1:-venv}"
    python3 -m venv "$venv_name"
    source "$venv_name/bin/activate"
    if [ -f "requirements.txt" ]; then
        echo "Found requirements.txt, installing packages..."
        pip install -r requirements.txt
    fi
}

# Activate a venv
# Usage: va [name] (default: venv)
va() {
    local venv_name="${1:-venv}"
    if [ -d "$venv_name" ]; then
        source "$venv_name/bin/activate"
    else
        echo "Virtual environment '$venv_name' not found"
    fi
}

# Quick Python environment info
pyenv() {
    echo "Python Version: $(python --version)"
    echo "Pip Version: $(pip --version)"
    echo "Virtual Environment: $VIRTUAL_ENV"
    echo "\nInstalled Packages:"
    pip list
}

# Initialize conda for the current shell
conda-init() {
    eval "$(/opt/homebrew/anaconda3/bin/conda shell.zsh hook)"
    echo "Conda initialized. Use 'conda deactivate' to exit current environment."
}


## Quick directory navigation with bookmarks
# Usage:
# mark work -> creates bookmark named 'work' for current directory
# jump work -> jumps to bookmarked directory
# marks -> lists all bookmarks
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}


### Docker shortcuts ###

# Pretty docker ps - lists container names, status, and ports
dps() {
    docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
}
