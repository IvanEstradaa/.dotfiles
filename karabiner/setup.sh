KARABINER_PATH="$HOME/.config/karabiner"
# CONFIG_FILE="karabiner.json"

open -a "Karabiner-Elements"

# Remove .config/karabiner
rm -rf $KARABINER_PATH

# Create .config/karabiner
# mkdir -p $KARABINER_PATH

# Symlink
ln -s $PWD/karabiner/ $HOME/.config/

# Restart karabiner_console_user_server: https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
# If the id is incorrect, find it by running `launchctl list | grep karabiner`
launchctl kickstart -k gui/`id -u`/org.pqrs.service.agent.karabiner_console_user_server

# Install dependencies and build
yarn install --cwd $PWD/karabiner
yarn --cwd $PWD/karabiner run build