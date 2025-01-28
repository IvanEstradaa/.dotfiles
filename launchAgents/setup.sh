# For remaping keys, see: https://hidutil-generator.netlify.app/
# For LaunchAgent syntax, see: https://hidutil-generator.netlify.app/

LAUNCHAGENTS_PATH="$HOME/Library/LaunchAgents/"
REMAP_FILE="com.local.KeyRemapScript.plist"

ln -s $PWD/launchAgents/$REMAP_FILE $LAUNCHAGENTS_PATH/$REMAP_FILE