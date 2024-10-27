# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Env variables

if [ -f "$HOME/.env" ]; then
  source "$HOME/.env"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"

## apps
export PATH="/Applications/PyCharm.app/Contents/MacOS:$PATH"


# aliases

## filesystem
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias la='ls -lAh --color=auto'
alias mkdir='mkdir -p'
alias path='echo $PATH | tr ":" "\n"'
alias rr=ranger
alias rd='source ranger'

## python
alias py=python3
alias pip=pip3
alias python=python3
alias ipy=ipython
alias pyserve="python -m http.server"
alias pip-upgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
alias pypath='python -c "import sys; print(\"\n\".join(sys.path))"'
alias pyc='pycharm .' # open current dir in pycharm
alias conda-bin='export PATH="/opt/homebrew/anaconda3/bin:$PATH"'

## conda
alias con="conda-init"
alias ml="ml-mode"

## homebrew
alias upup='brew update && brew upgrade'
alias brewdeps='brew deps --tree --installed'

## network
alias ip="curl -s ipinfo.io | jq ."
alias ports="lsof -PiTCP -sTCP:LISTEN"

## git
alias cps='gh copilot suggest'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'


# configuration

## Auto CD without typing 'cd'
setopt AUTO_CD

## Correction for commands
setopt CORRECT
setopt CORRECT_ALL

## History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

## Quick directory switching
# Stores directory stack, access with 'd'
# cd +4 -> goes to dir with index 4
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# keybinds

bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line


# functions

## Create and enter directory
md() {
    mkdir -p "$1" && cd "$1"
}

## Python virtual environment functions
venv() {
    # Create and activate a new venv, install requirements if present
    # Usage: venv [name] (default: venv)
    local venv_name="${1:-venv}"
    python3 -m venv "$venv_name"
    source "$venv_name/bin/activate"   
    if [ -f "requirements.txt" ]; then
        echo "Found requirements.txt, installing packages..."
        pip install -r requirements.txt
    fi
}
va() {
    # Activate a venv
    # Usage: va [name] (default: venv)
    local venv_name="${1:-venv}"
    if [ -d "$venv_name" ]; then
        source "$venv_name/bin/activate"
    else
        echo "Virtual environment '$venv_name' not found"
    fi
}
pyenv() {
    # Quick Python environment info
    echo "Python Version: $(python --version)"
    echo "Pip Version: $(pip --version)"
    echo "Virtual Environment: $VIRTUAL_ENV"
    echo "\nInstalled Packages:"
    pip list
}

# Simple Python script template
pyscript() {
    local filename="$1"
    local editor="${2:-subl}"  # Default to subl
    
    # If no filename provided, create temp{n}.py
    if [ -z "$filename" ]; then
        local i=1
        filename="temp.py"
        while [ -f "$filename" ]; do
            filename="temp$i.py"
            ((i++))
        done
    else
        # Add .py extension if not present
        [[ "$filename" != *.py ]] && filename="$filename.py"
        
        # Check if file already exists
        if [ -f "$filename" ]; then
            read -p "File $filename already exists. Overwrite? (y/N) " confirm
            if [[ ! $confirm =~ ^[Yy]$ ]]; then
                echo "Operation cancelled."
                return 1
            fi
        fi
    fi
    
    # Create script with template
    cat > "$filename" << 'EOF'
#!/usr/bin/env python3
"""
Description: 
Author: Osvald Nigola
Date: $(date +"%Y-%m-%d")
"""

def main():
    

if __name__ == "__main__":
    main()
EOF
    
    # Replace date placeholder
    sed -i "" "s/\$(date +\"%Y-%m-%d\")/$(date +"%Y-%m-%d")/g" "$filename"
    
    chmod +x "$filename"
    
    # Open with specified editor
    case "$editor" in
        "pycharm")
            pycharm "$filename"
            ;;
        "subl"|"sublime")
            subl "$filename:9"  # Jump to line 9 (inside main function)
            ;;
        "code"|"vscode")
            code "$filename"
            ;;
        *)
            echo "Unknown editor: $editor"
            echo "Available editors: pycharm, subl/sublime, code/vscode"
            return 1
            ;;
    esac
    
    echo "Created $filename"
}

# CLI Python script template
pycli() {
    local filename="$1"
    local editor="${2:-subl}"  # Default to subl
    
    # If no filename provided, create temp{n}.py
    if [ -z "$filename" ]; then
        local i=1
        filename="temp.py"
        while [ -f "$filename" ]; do
            filename="temp$i.py"
            ((i++))
        done
    else
        # Add .py extension if not present
        [[ "$filename" != *.py ]] && filename="$filename.py"
        
        # Check if file already exists
        if [ -f "$filename" ]; then
            read -p "File $filename already exists. Overwrite? (y/N) " confirm
            if [[ ! $confirm =~ ^[Yy]$ ]]; then
                echo "Operation cancelled."
                return 1
            fi
        fi
    fi
    
    # Create script with template
    cat > "$filename" << 'EOF'
#!/usr/bin/env python3
"""
Description: 
Author: Osvald Nigola
Date: $(date +"%Y-%m-%d")
"""

import argparse
from typing import NamedTuple, List

class Args(NamedTuple):
    flags: argparse.Namespace
    args: List[str]

def parse_args() -> Args:
    """Parse both known and unknown arguments."""
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("--flag") # action="store_true" for just check if flag present
    flags, args = parser.parse_known_args()
    return Args(flags, args)

def main():
    args = parse_args()
    print(f"Flags: {vars(args.flags)}")
    print(f"Arguments: {args.args}")



if __name__ == "__main__":
    main()
EOF
    
    # Replace date placeholder
    sed -i "" "s/\$(date +\"%Y-%m-%d\")/$(date +"%Y-%m-%d")/g" "$filename"
    
    chmod +x "$filename"
    
    # Open with specified editor
    case "$editor" in
        "pycharm")
            pycharm "$filename"
            ;;
        "subl"|"sublime")
            subl "$filename:27"  # Jump to main
            ;;
        "code"|"vscode")
            code "$filename"
            ;;
        *)
            echo "Unknown editor: $editor"
            echo "Available editors: pycharm, subl/sublime, code/vscode"
            return 1
            ;;
    esac
    
    echo "Created $filename"
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

## Conda envs
conda-init() {
    # Initialize conda for the current shell
    eval "$(/opt/homebrew/anaconda3/bin/conda shell.zsh hook)"
    echo "Conda initialized. Use 'conda deactivate' to exit current environment."
}

ml-mode() {
    # Initialize conda and activate ML environment
    conda-init
    conda activate ml  # Replace 'ml' with desired env name
    echo "ML environment activated with:"
    echo "Python: $(which python)"
    echo "Conda env: $CONDA_DEFAULT_ENV"
}


## Extract various archive formats
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## Docker shortcuts
dps() {
    # Pretty docker ps
    docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
}


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# completions
# ## ngrok
# if command -v ngrok &>/dev/null; then
#     eval "$(ngrok completion)"
# fi

# plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# has to be at the end of .zshrc
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
