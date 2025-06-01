NVIM_PATH="$HOME/.config/nvim"

# Remove .config/hammerspoon
rm -rf $NVIM_PATH

# Symlink
ln -s $PWD/nvim/ $HOME/.config/

