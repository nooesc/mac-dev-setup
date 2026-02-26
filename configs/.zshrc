# --- Zimfw Setup ---
export ZIM_HOME=${ZIM_HOME:-${ZDOTDIR:-$HOME}/.zim}

# Download zimfw if not present
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Auto-build init.zsh if .zimrc changed
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-$HOME}/.zimrc" ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init -q
fi

# Load plugins
source "${ZIM_HOME}/init.zsh"

# --- Prompt ---
eval "$(starship init zsh)"

# --- Paths ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# --- Shell Behavior ---
setopt hist_ignore_all_dups
setopt share_history
HISTSIZE=10000
SAVEHIST=10000
autoload -Uz compinit && compinit
bindkey '^R' history-incremental-search-backward
eval "$(zoxide init zsh)"

# --- Modern CLI Aliases ---
alias ls='eza -al --icons --git --group-directories-first --header --time-style=relative --color=always --color-scale'
alias cat='bat'
alias find='fd'
alias grep='rg'

# --- Utility Aliases ---
alias cl='clear'
alias reload='source ~/.zshrc'
alias ip='curl -s ifconfig.me'
alias q='exit'

# --- Claude Code ---
alias cc='claude'
