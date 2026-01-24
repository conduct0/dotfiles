Here you find all my dotfiles. I am using bare repo approach described here: https://wiki.archlinux.org/title/Dotfiles

## Setup

```bash
git clone --bare https://github.com/conduct0/dotfiles $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
# Example for adding to the dotfiles repo: 
dotfiles add .vimrc
dotfiles commit -m "add git"
```
### Notes and requirements
- I use FiraCode Nerd Font Icons will look wierd without those symbols.
- I use fzf

