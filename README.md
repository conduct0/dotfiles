# Setup
If you want to only install selected folders in your config do the following
[This](https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository) helped me understand how to pull selectively instead of hell submodules.
```bash
cd ~/.config
git init
git remote add -f origin git@github.com:nicolascampbell/dotfiles.git
git config core.sparseCheckout true
# This ensures only the sway/ directory will be pulled, you can select what do you want to pull.
echo "sway/" >> .git/info/sparse-checkout
git pull origin main
```
Otherwise just do 
```bash
git clone https://github.com/nicolascampbell/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"
```

## Notes and requirements

- Set the background image
- I use [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) Icons will look wierd without those symbols. 
