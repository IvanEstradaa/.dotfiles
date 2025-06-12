HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey -e

# bindkey "^f" autosuggest-accept
# bindkey '^[f' forward-word
# bindkey "^f" forward-char
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward


# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward

bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

bindkey '^o' clear-screen
