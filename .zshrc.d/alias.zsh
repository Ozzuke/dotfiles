# Filesystem
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias la='ls -lAh --color=auto'
alias mkdir='mkdir -p'                # Create parent directories if they don't exist
alias path='echo $PATH | tr ":" "\n"' # List all directories in PATH
alias rr=ranger
alias rd='source ranger' # Follow ranger directory (exiting ranger will return to shell in the same dir as ranger was)

# System
alias du='du -h'
alias h='history'
alias grep='grep -E --color=auto'
alias vi='vim'
alias reload='source ~/.zshrc'

# Python
alias py=python3
alias pip=pip3
alias python=python3
alias ipy=ipython
alias pyserve="python -m http.server"
alias pip-up="pip list --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U"
alias pypath='python -c "import sys; print(\"\n\".join(sys.path))"'
alias conda-bin='export PATH="/opt/homebrew/anaconda3/bin:$PATH"'
alias con="conda-init"
alias ml="ml-mode"

# Homebrew
alias upup='brew update && brew upgrade'
alias brewdeps='brew deps --tree --installed'

# Network
alias ip="curl -s ipinfo.io | jq ."
alias ports="lsof -PiTCP -sTCP:LISTEN"

# Git
alias yy='gh copilot suggest'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'

# Other
alias nk-ssh='ssh root@nk.inpropartner.ee'
