TMUX_PATH="$HOME/.config/tmux"

# Remove .config/tmux
rm -rf $TMUX_PATH

# Symlink
ln -s $PWD/tmux/ $HOME/.config/

# install tpm in plugins directory
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm 
