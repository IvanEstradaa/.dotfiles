WEZTERM_PATH="$HOME/.config/wezterm"
CONFIG_FILE="wezterm.lua"

# Remove .config/wezterm
rm -rf $WEZTERM_PATH

# Create .config/wezterm
mkdir -p $WEZTERM_PATH

# Symlink
ln -s $PWD/wezterm/$CONFIG_FILE $WEZTERM_PATH/$CONFIG_FILE