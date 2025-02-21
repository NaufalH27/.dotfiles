alias eww='~/.config/eww/eww/target/release/eww'
alias ls='ls --color=auto'
alias sudo='sudo'

setopt CORRECT
# Better history navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

bindkey '^H' backward-word          # Ctrl + H moves back one word
bindkey '^L' forward-word           # Ctrl + L moves forward one word
bindkey '^K' history-substring-search-up    # Ctrl + K searches history upwards
bindkey '^J' history-substring-search-down  # Ctrl + J searches history downwards


# Completion settings
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'





# Source plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh

eval "$(oh-my-posh --config ~/.config/posh/config.toml init zsh)"


# Source environment variables and aliases
source ~/.config/zsh/env.zsh
source ~/.config/zsh/syntax-highlighting-catppuccin.zsh
source ~/.config/zsh/fzf-style.zsh
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
export HISTSIZE=10000
export SAVEHIST=10000

export PATH="/home/nopal/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/nopal/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
