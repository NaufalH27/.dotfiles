# variables for zsh and bash
# this file in sourced in .zshrc and .bashrc

#fzf settings 
source ~/.config/zsh/fzf-style.zsh

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="google-chrome-stable"
export TERM="xterm-256color"

# Manpager
export MANPAGER="nvim +Man!"

export GCM_CREDENTIAL_STORE="cache"
# XDG variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Cleaning ~
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export GOPATH="$XDG_DATA_HOME"/go

export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export STARSHIP_CONFIG=~/.config/starship/starship.toml