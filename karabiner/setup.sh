KARABINER_PATH="$HOME/.config/karabiner"
# CONFIG_FILE="karabiner.json"

open -a "Karabiner-Elements"

# Remove .config/karabiner
rm -rf $KARABINER_PATH

# Create .config/karabiner
# mkdir -p $KARABINER_PATH

# Symlink
ln -s $PWD/karabiner/ $HOME/.config/

# Restart karabiner_console_user_server
launchctl kickstart -k gui/`id -u`/org.pqrs.service.agent.karabiner_console_user_server

# Install dependencies and build
yarn install --cwd $PWD/karabiner
yarn --cwd $PWD/karabiner run build