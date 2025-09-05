# Set up XDG directories if not already set (must be before p10k instant prompt)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source all modular config files (excluding platform-specific ones)
for config_file in "${XDG_CONFIG_HOME}/zsh/.zshrc.d"/*.zsh; do
  if [[ -r "$config_file" && "$config_file" != *"platform-"* ]]; then
    source "$config_file"
  fi
done

# Load platform-specific configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific configs
  if [[ -r "${XDG_CONFIG_HOME}/zsh/.zshrc.d/platform-macos.zsh" ]]; then
    source "${XDG_CONFIG_HOME}/zsh/.zshrc.d/platform-macos.zsh"
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific configs
  if [[ -r "${XDG_CONFIG_HOME}/zsh/.zshrc.d/platform-linux.zsh" ]]; then
    source "${XDG_CONFIG_HOME}/zsh/.zshrc.d/platform-linux.zsh"
  fi
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${XDG_CONFIG_HOME}/zsh/.p10k.zsh" ]] || source "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"
