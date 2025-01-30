
chmod +x $HOME/.dotfiles/bin/* && sudo find -L /usr/local/bin -type l -exec rm -i {} + && sudo find $HOME/.dotfiles/bin/ -mindepth 1 -maxdepth 1 -type f ! -name 'setup.sh' ! -exec test -e /usr/local/bin/$(basename {}) \; -exec ln -s {} /usr/local/bin/ \;

# This combination allows clean up old symlinks and ensure new ones are properly set up in /usr/local/bin/

# First, we make all files in $PWD/bin/ executable.
# Then, we remove all broken symbolic links on /usr/local/bin interactively.
# After that, we create symbolic links for all regular files in $PWD/bin/ (except setup.sh) to /usr/local/bin/, but only if they don't already exist there.