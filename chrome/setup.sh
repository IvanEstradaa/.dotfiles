echo "
--------------------------------------------------------------------------------------
| To make librewolf customizations take effect, set the following in 'about:config': |
| toolkit.legacyUserProfileCustomizations.stylesheets = true                         |
--------------------------------------------------------------------------------------
"

PROFILE_PATH="$HOME/Library/Application Support/librewolf/Profiles/u0qnsa0l.default-default"

# Symlink
ln -s $PWD/chrome/ $PROFILE_PATH