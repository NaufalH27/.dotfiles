


alias n='nvim'
alias eww='~/.config/eww/eww/target/release/eww'
alias ls='ls --color=auto'
alias sudo='sudo'



# Init
autoload -U compinit
zmodload zsh/complist

# Enable autocorrection
setopt CORRECT

# Source environment variables and aliases
source ~/.config/zsh/env.zsh


# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Better history navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


# Completion settings
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'



# Edit line in Vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line


# Source plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh


eval "$(starship init zsh)"

# Catppuccin Mocha Theme (for zsh-syntax-highlighting)
#
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70'

ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#a6e3a1'


ZSH_HIGHLIGHT_STYLES[alias]=fg="#89b4fa",bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg="#89b4fa",bold
ZSH_HIGHLIGHT_STYLES[function]=fg="#89b4fa",bold
ZSH_HIGHLIGHT_STYLES[command]=fg="#89b4fa",bold
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8',bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg='#f38ba8'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg='#f38ba8'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg='#f38ba8' 
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f38ba8' 
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8'
