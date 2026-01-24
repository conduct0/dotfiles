## Completion
autoload -U compinit; compinit
zstyle ':completion:*' menu select
# This handles completion search when I already typed the start of the command
# https://unix.stackexchange.com/a/672892
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/shell/key-bindings.zsh 

## VI mode
bindkey -v
# makes the change quicker https://thevaluable.dev/zsh-install-configure-mouseless/
export KEYTIMEOUT=1


## Aliases
source $ZDOTDIR/aliases.zsh

## Plugins
source $ZDOTDIR/plugins.zsh

## Prompt
eval "$(starship init zsh)"
