# Own
alias vim="nvim"
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias ses="sh $XDG_CONFIG_HOME/tmux/tmux-sessionizer.sh"
alias reload="source $ZDOTDIR/.zshrc"
alias edit="nvim $ZDOTDIR/.zshrc"

# Colors
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'

# Files
alias ..='cd ..'
alias l='ls'
alias ll='ls -l'
alias la='ls -lA'

# Git
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
alias g='git'
alias gst='git status'
alias gp='git push'
alias gd='git diff'
alias gb='git branch'
alias gc='git commit --vebose'
alias ga='git add'
alias gsw='git switch'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
