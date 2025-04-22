YAZI_PATH="$HOME/.config/yazi"

# Remove .config/yazi
rm -rf $YAZI_PATH

# Symlink
ln -s $PWD/yazi/ $HOME/.config/