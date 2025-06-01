# Make hammerspoon use a better config path
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

HAMMERSPOON_PATH="$HOME/.config/hammerspoon"

# Remove .config/hammerspoon
rm -rf $HAMMERSPOON_PATH

# Symlink
ln -s $PWD/hammerspoon/ $HOME/.config/

open -a Hammerspoon

# Add Hammerspoon to login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:false}'