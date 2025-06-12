POSTING_PATH="$HOME/.config/posting"
THEMES_PATH="$HOME/.local/share/posting/themes"

# Esure .config/posting exists
rm -rf $POSTING_PATH
mkdir -p $POSTING_PATH

ln -s $PWD/posting/config.yaml $POSTING_PATH

# Ensure share/posting exists
rm -rf $THEMES_PATH
mkdir -p $THEMES_PATH

# Symlink theme
ln -s $PWD/posting/Black_Metal.yaml $THEMES_PATH
