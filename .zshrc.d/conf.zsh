# Auto CD without typing 'cd'
setopt AUTO_CD

# Correction for commands (e.g. offers to fix 'sl' -> 'ls')
setopt CORRECT
setopt CORRECT_ALL

# History configuration
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
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
