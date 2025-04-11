echo "
--------------------------------------------------------------------------------------
| To make librewolf customizations take effect, set the following in 'about:config': |
| toolkit.legacyUserProfileCustomizations.stylesheets = true                         |
--------------------------------------------------------------------------------------
"

PROFILE_PATH="$HOME/Library/Application Support/librewolf/Profiles/u0qnsa0l.default-default"

mkdir -p $PROFILE_PATH/chrome

# Symlink
ln -s $PWD/librewolf/userChrome.css $PROFILE_PATH/chrome/userChrome.css
ln -s $PWD/librewolf/userContent.css $PROFILE_PATH/chrome/userContent.css