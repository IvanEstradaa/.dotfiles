AEROSPACE_PATH="$HOME/.config/aerospace"
CONFIG_FILE="aerospace.toml"

# Remove .config/aerospace
rm -rf $AEROSPACE_PATH

# Create .config/aerospace
mkdir -p $AEROSPACE_PATH

# Symlink
ln -s $PWD/aerospace/$CONFIG_FILE $AEROSPACE_PATH/$CONFIG_FILE
