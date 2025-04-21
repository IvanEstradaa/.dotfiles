chmod +x $HOME/.dotfiles/bin/*
sudo mkdir -p /usr/local/bin/
sudo find -L /usr/local/bin -type l -exec rm -i {} +
sudo find $HOME/.dotfiles/bin/ -mindepth 1 -maxdepth 1 -type f ! -name 'setup.sh' ! -exec test -e /usr/local/bin/$(basename {}) \; -exec ln -s {} /usr/local/bin/ \; -exec echo "Added new symlink: $(basename {})" \;

# This combination allows clean up old symlinks and ensure new ones are properly set up in /usr/local/bin/

# First, we make all files in $PWD/bin/ executable.
# Then, we remove all broken symbolic links on /usr/local/bin interactively.
# After that, we create symbolic links for all regular files in $PWD/bin/ (except setup.sh) to /usr/local/bin/, but only if they don't already exist there.
# Finally, we print a message for each new symlink created.


# Notes:
# For drag bin see: https://github.com/Wevah/dragterm/issues/2 , implementation with yazi: https://github.com/nik012003/ripdrag/issues/19
# For keymaster bin see: https://github.com/johnthethird/keymaster.git, later see qrcode implementation: https://apple.stackexchange.com/questions/176119/how-to-access-the-wi-fi-password-through-terminal 
# For localsend bin see: https://github.com/zpp0196/localsend-rs?tab=readme-ov-file