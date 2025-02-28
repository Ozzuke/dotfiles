# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Source config files
for config_file in $HOME/.zshrc.d/*.zsh; do
  source $config_file
done


# MacOS specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $HOME/.zshrc.macos
fi

# Linux specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $HOME/.zshrc.linux
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
