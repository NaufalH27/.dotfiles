export PREFERRED_ICON_THEME=WhiteSur
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"

export MANPAGER="nvim +Man!"

export GCM_CREDENTIAL_STORE="cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
export PATH="$HOME/development/flutter/bin:$PATH"

export PATH="/home/nopal/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/nopal/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export PATH=$PATH:/home/nopal/.spicetify
export ICON_DIRS="$HOME/.local/share/icons:/usr/share/icons:/usr/share/pixmaps"

alias eww='~/.config/eww/eww/target/release/eww'
alias ls='ls --color=auto'
alias sudo='sudo'
alias buildApk='./gradlew --no-daemon assembleDebug && adb install app/build/outputs/apk/debug/app-debug.apk || waydroid app install app/build/outputs/apk/debug/app-debug.apk'



# Completion settings

eval "$(oh-my-posh --config ~/.config/posh/config.toml init zsh)"


# Source environment variables and aliases
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"
export HISTSIZE=10000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt CORRECT

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/fzf-tab/fzf-tab.zsh

KEYTIMEOUT=1
bindkey -e
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^K' up-line
bindkey '^J' down-line
bindkey '^H' backward-word
bindkey '^L' forward-word



echo
