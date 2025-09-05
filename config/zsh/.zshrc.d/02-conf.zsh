# Zsh Configuration
# This file contains general zsh settings and options

# Auto CD without typing 'cd'
setopt AUTO_CD

# Correction for commands (e.g. offers to fix 'sl' -> 'ls')
setopt CORRECT
setopt CORRECT_ALL

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

# Quick directory switching
# Stores directory stack, access with 'd'
# cd +4 -> goes to dir with index 4
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Key binds
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' backward-kill-line
bindkey '^K' kill-line

# Completion settings
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Create necessary XDG directories
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
