Here you find all my dotfiles.  I use [dotter](https://github.com/SuperCuber/dotter/tree/master) to handle the dotfiles.

## Setup

You need to install `dotter`.
```bash
cargo install dotter
```

The clone the dotfiles
```bash
git clone --bare https://github.com/conduct0/dotfiles $HOME/.dotfiles

# Check what would happen
dotter deploy --dry-run
# Apply and overwrite
dotter deploy --force
```
### Notes and requirements
- FiraCode Nerd Font Icons will look wierd without those symbols.
- fzf

