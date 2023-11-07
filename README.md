# Nvim and Sway config 
Nvim configs based on ThePrimeagen config. This folders should be in ~/.config/

If you want to only install selected folders in your if config do the following
The following is done according to [this](https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository) question.
```bash
cd ~/.config
git init
git remote add -f origin git@github.com:nicolascampbell/dotfiles.git
git config core.sparseCheckout true
# This ensures only the sway/ directory will be pulled
echo "sway/" >> .git/info/sparse-checkout
git pull origin main
```
Otherwise just do 
```bash
git clone https://github.com/nicolascampbell/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"
```
